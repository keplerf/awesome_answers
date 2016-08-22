class QuestionsController < ApplicationController
  # Get/ questions/new

  before_action :find_question, only: [:show, :edit, :update, :destroy ]
  before_action :authenticate_user! , only: [:create, :edit, :destroy, :update,:new]

  QUENSTION_PER_PAGE = 10

  def new
    @question = Question.new

  end

  def index
    @questions = Question.order(created_at: :desc).
                          page(params[:page]).
                          per(QUENSTION_PER_PAGE)

  end

  def show
    # @question = Question.find params[:id]
    @answer = Answer.new
  end

  def create

    @question       = Question.new question_params
    @question.user  = current_user

    if @question.save
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})
      # flash[:notice] = "Question created successfully"
      redirect_to question_path(@question), notice: "Question created successfully"
    else
      flash[:alert] = @question.errors.full_messages.join(", ")
      render :new
    end

  end

  def edit
    # @question = Question.find params[:id]
  end

  def destroy
    # question = Question.find params[:id]
    @question.destroy
    redirect_to questions_path
  end


  def update
    # @question = Question.find params[:id]
   if @question.update question_params
     redirect_to question_path(@question)
   else
     render :edit
   end
  end

  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit([:title, :body])
    # we're using the `strong parameters` feature of Rails here to only allow
   # mass-assigning the attributes that we want to allow the user to set
  #  question_params  = params.require(:question).permit([:title, :body])
  end

end
