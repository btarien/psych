class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  before_destroy { |record| Answer.where(question: record).delete_all }
end
