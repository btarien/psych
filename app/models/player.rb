class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :answers, dependent: :nullify
  has_many :votes, dependent: :nullify
  before_destroy { |record| Answer.where(player: record).delete_all }
end
