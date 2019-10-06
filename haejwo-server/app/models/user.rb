class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  enum gender: [:no_select, :man, :woman]
  enum status: [:approved, :waiting, :unapproved]
  mount_uploader :thumbnail, ImageUploader
  mount_uploader :student_card_image, ImageUploader

  def thumbnail_url
    thumbnail.url.present? ? thumbnail.url : '/vuma/images/profile.png'
  end

  def student_card_image_url
    student_card_image.url.present? ? student_card_image.url : '/vuma/images/profile.png'
  end

end
