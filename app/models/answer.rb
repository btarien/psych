class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :player
  has_many :votes, dependent: :delete_all

  validates_presence_of :answer
end
