class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  enum gender: [:no_select, :man, :woman]

  mount_uploader :thumbnail, ImageUploader

  has_many :events, dependent: :destroy

  def thumbnail_url
    thumbnail.url.present? ? thumbnail.url : '/vuma/images/profile.png'
  end
end
