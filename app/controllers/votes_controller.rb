class VotesController < ApplicationController
  def create
    @player = Player.find_by(user: current_user)
    @answer = Answer.find(params[:answer_id])
    Vote.create!(answer: @answer, player: @player)
    redirect_to waiting_room_answer_path(@answer)
  end

  def waiting_room

  end
end
