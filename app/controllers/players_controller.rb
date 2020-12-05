class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @player.user = current_user
    @player.game = Game.find_by(code: @player.code)
    if @player.save
      redirect_to game_path(@player.game)
    else
      render :new
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to root_path
  end

  private

  def player_params
    params.require(:player).permit(:code)
  end
end
