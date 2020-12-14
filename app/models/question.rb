class Question < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :answers, dependent: :destroy
  has_many :votes, through: :answers

  validates_presence_of :question

  def next
    Question.find_by(game: game, number: number + 1)
  end
end
