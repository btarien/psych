class Game < ApplicationRecord
  has_many :players, dependent: :delete_all
  has_many :questions, dependent: :delete_all
  validates :code, uniqueness: true
end
