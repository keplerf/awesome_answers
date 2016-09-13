class Api::V1::QuestionsController < ApplicationController

  QUENSTION_PER_PAGE = 20

  def index
    @questions = Question.order(created_at: :desc).
                          page(params[:page]).
                          per(QUENSTION_PER_PAGE)

    #  render json: @questions

  end
end
