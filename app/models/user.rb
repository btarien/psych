class User < ApplicationRecord
  require 'open-uri'

  after_create :set_default_avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  has_one_attached :avatar
  has_one :player

  def set_default_avatar
    return if avatar.attached?

    LetterAvatar.setup { |config| config.pointsize = 300 }
    avatar.attach(io: URI.open(LetterAvatar.generate(name, 1000)), filename: "#{name}.png", content_type: 'image/png')
  end
end
