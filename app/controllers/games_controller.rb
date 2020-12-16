class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def show
    @players = Player.where(game: @game)
    @player = Player.find_by(user: current_user)
  end

  def create
    code = generate_code
    @game = Game.new(code: code, open: true, user: current_user)

    until @game.save # make sure code unique
      code = generate_code
      @game = Game.new(code: code, open: true)
    end

    @player = Player.create!(user: current_user, game: @game)
    redirect_to game_path(@game) # go to show
  end

  def update
    @game.update(game_params)
    @game.questions << generate_questions
    @game.save
    GameChannel.broadcast_to(
      @game,
      { action: "start", id: @game.questions.first.id }
    )
  end

  def destroy
    @game.destroy
    redirect_to root_path
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:code, :open, :user)
  end

  def generate_code
    letters = ('A'..'Z').to_a
    letters.sample(8).join
  end

  def generate_questions
    questions = []
    10.times do |num|
      questions << Question.create!(
        number: num + 1,
        question: "What would #{Player.first.user.name} do?",
        player: Player.first, game: @game
      )
    end
    return questions
  end
end
