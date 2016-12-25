class DocumentsController < ApplicationController
  include Authorizable

  def index
    @documents = current_account.documents.order(:updated_at)
  end

  def create
    @document = Document.new(document_params)
    @document.account = current_account
    if @document.save
      redirect_to documents_path
    else
      @errors = @document.errors.full_messages
      render 'new'
    end
  end

  def update
    @document = entity

    if @document.update_attributes(document_params)
      redirect_to documents_path
    else
      @errors = @document.errors.full_messages
      render 'edit'
    end
  end

  def new
    @document = Document.new
  end

  def edit
    @document = entity
  end

  def destroy
    @document = entity
    @document.destroy
  end

private

  def document_params
    params.require(:document).permit(:note, :file)
  end

  def entity
    Document.find(params[:id])
  end

  def model
    Document
  end

end
