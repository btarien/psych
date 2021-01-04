class Question < ApplicationRecord
  belongs_to :game
  has_many :answers, dependent: :destroy
  has_many :votes, through: :answers

  validates_presence_of :question

  @@questions = [
    "What is %s's superpower?",
    "What would %s come back as in their second life?",
    "What would %s do if they won the lottery?",
    "Describe %s in three words.",
    "What would %s be arrested for?",
    "If %s could take one thing on a deserted island, what would it be?",
    "What is %s's biggest fear?",
    "What is %s's hidden talent?",
    "If %s were God for a day, what would they do?",
    "What is %s's biggest pet peeve?"
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
