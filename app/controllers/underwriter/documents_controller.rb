class Underwriter::DocumentsController < Underwriter::ApplicationController

  def index
    @documents = Document.order(:updated_at)
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(document_params) && RotService.update_user_score(@document.account.user)

      redirect_to underwriter_documents_path
    else
      @errors = @document.errors.full_messages
      render 'edit'
    end
  end

  private

    def document_params
      params.require(:document).permit(:note, :status)
    end

end
