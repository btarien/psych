class VotesController < ApplicationController
  def index
    answer = Answer.find(params[:answer_id])
    @votes = Vote.where(answer: answer)
    @answers = answer.question.answers.order("votes_count desc")
    @question = Question.find(@votes.first.question.id)
    @game = answer.game
    @player = Player.find_by(user: current_user)
    @players = @game.players.order(points: :desc)
  end

  def create
    @player = Player.find_by(user: current_user)
    @answer = Answer.find(params[:answer_id])
    @answers = @answer.question.answers # used for rerendering answers#index
    @vote = Vote.new(answer: @answer, player: @player)
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
