class Question < ApplicationRecord
  belongs_to :game
  belongs_to :player
  has_many :answers

  validates_presence_of :question
end
