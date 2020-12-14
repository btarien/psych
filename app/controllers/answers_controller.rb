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
      if Answer.where(question: @answer.question).count == @answer.game.players.count
        GameChannel.broadcast_to(
          @answer.game,
          { action: "show answers" }
        )
      end
      redirect_to question_answers_path(@answer.question) # redirect to answers#index
    else
      render :index
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer)
  end
end
