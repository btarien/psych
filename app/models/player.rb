class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  before_destroy { |record| Question.where(player: record).delete_all }
  before_destroy { |record| Answer.where(player: record).delete_all }
end
