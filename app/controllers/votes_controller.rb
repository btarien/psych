class VotesController < ApplicationController
  def index
    answer = Answer.find(params[:answer_id])
    @votes = Vote.where(answer: answer)
    @answers = Answer.where(question: answer.question)
    @question = Question.find(@votes.first.question.id)
  end

  def create
    @player = Player.find_by(user: current_user)
    @answer = Answer.find(params[:answer_id])
    Vote.create!(answer: @answer, player: @player)
    if @answer.question.votes.count == @answer.game.players.count
      GameChannel.broadcast_to(
        @answer.game,
        { action: "show votes" }
      )
    end
    redirect_to answer_votes_path(@answer)
  end
end
