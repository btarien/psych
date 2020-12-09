class Game < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :players, dependent: :destroy
  belongs_to :user
  validates :code, uniqueness: true
  before_destroy { |record| Question.where(game: record).delete_all }
  before_destroy { |record| Player.where(game: record).delete_all }

  def host
    user
  end
end
