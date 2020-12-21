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
    @vote = Vote.new(answer: @answer, player: @player)
    @answers = @answer.question.answers
    if @vote.save
      @answer.player.increment!(:points)
      if @answer.question.votes.count == @answer.game.players.count
        GameChannel.broadcast_to(
          @answer.game,
          { action: "show votes" }
        )
      end
      redirect_to answer_votes_path(@answer)
    else
      render 'answers/index'
    end
  end
end
