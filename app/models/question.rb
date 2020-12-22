class Question < ApplicationRecord
  belongs_to :game
  has_many :answers, dependent: :destroy
  has_many :votes, through: :answers

  validates_presence_of :question

  @@questions = [
    "What would %s do?",
    "What is %s's favorite color?"
  ]

  def self.questions
    @@questions.sample(10)
  end

  def next
    Question.find_by(game: game, number: number + 1)
  end

  def previous
    Question.find_by(game: game, number: number - 1)
  end
end
