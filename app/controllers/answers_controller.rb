class AnswersController < ApplicationController
  def index
    @answers = Answer.where(question: params[:question_id])
    @question = @answers.first.question
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question = Question.find(params[:question_id])
    @answer.player = Player.find_by(user: current_user)
    if @answer.save
      redirect_to question_answers_path
    else
      render :index
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer)
  end
end
