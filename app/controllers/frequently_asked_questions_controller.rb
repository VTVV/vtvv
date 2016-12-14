class FrequentlyAskedQuestionsController < ApplicationController

  before_action :check_underwriter, except: [:index]

  def index
    @faqs = FrequentlyAskedQuestion.all
  end

  def new
    @faq = FrequentlyAskedQuestion.new
  end

  def create
    @faq = FrequentlyAskedQuestion.new(faqs_params)
    if @faq.save
      flash[:success] = 'FAQ was successfully created!'
      redirect_to frequently_asked_questions_path
    else
      @errors = @faq.errors.full_messages
      render 'new'
    end
  end

  def edit
    @faq = FrequentlyAskedQuestion.find(params[:id])
  end

  def update
    @faq = FrequentlyAskedQuestion.find(params[:id])
    if @faq.update((faqs_params))
      flash[:success] = 'FAQ was successfully updated!'
      redirect_to frequently_asked_questions_path
    else
      @errors = @faq.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @faq = FrequentlyAskedQuestion.find(params[:id])
    @faq.destroy
    redirect_to frequently_asked_questions_path
  end

  private

  def faqs_params
    params.require(:frequently_asked_question).permit(:title, :content)
  end

  def check_underwriter
    unless current_account.underwriter?
      redirect_to frequently_asked_questions_path
    end
  end
end
