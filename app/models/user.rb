class User < ApplicationRecord
  require 'open-uri'

  after_create :set_default_avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  has_one_attached :avatar

  def set_default_avatar
    unless avatar.attached?
      avatar.attach(io: URI.open(LetterAvatar.generate(name, 600)), filename: "#{name}.png", content_type: 'image/png')
    end
  end
end
