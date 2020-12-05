class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def show
    @players = Player.where(game: @game)
    @player = Player.find_by(user: current_user)
  end

  def create
    code = generate_code
    @game = Game.new(code: code, open: true)
    until @game.save
      code = generate_code
      @game = Game.new(code: code, open: true)
    end
    Player.create!(user: current_user, game: @game)
    redirect_to edit_game_path(@game)
  end

  def edit
    @players = Player.where(game: @game)
  end

  def update
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
    params.require(:game).permit(:code, :open)
  end

  def generate_code
    letters = ('A'..'Z').to_a
    letters.sample(8).join
  end
end
