class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    @player.user = current_user
    @player.game = Game.find_by(code: @player.code)
    if @player.save
      GameChannel.broadcast_to(
        @player.game,
        "<li>#{@player.user.name}</li>"
      )
      redirect_to game_path(@player.game)
    else
      render :new
    end
  end

  def destroy
    @player = Player.find(params[:id])
    Vote.where(answer: Answer.where(player: @player)).delete_all
    Answer.where(player: @player).delete_all
    @player.destroy
    redirect_to root_path
  end

  private

  def player_params
    params.require(:player).permit(:code)
  end
end
