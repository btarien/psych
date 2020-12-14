class Vote < ApplicationRecord
  belongs_to :answer
  belongs_to :player
  has_one :question, through: :answer
end
