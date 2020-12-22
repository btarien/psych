class Vote < ApplicationRecord
  belongs_to :answer, counter_cache: true
  belongs_to :player
  has_one :question, through: :answer
  validate :not_own

  def not_own
    errors.add(:player, "You can't vote for your own answer") if answer.player == player
  end
end
