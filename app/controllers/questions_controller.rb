class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def show
    @answer = Answer.new
  end

  def create
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end
end
