class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy

  enum gender: [:no_select, :man, :woman]
  enum status: [:approved, :waiting, :unapproved]
  enum device_type: [:android, :ios]

  mount_uploader :thumbnail, ImageUploader
  mount_uploader :student_card_image, ImageUploader

  def thumbnail_url
    thumbnail.url.present? ? thumbnail.url : '/vuma/images/profile.png'
  end

  def student_card_image_url
    student_card_image.url.present? ? student_card_image.url : '/vuma/images/profile.png'
  end

  def send_push(body)
    if device_token.present? && device_type.present?
      fcm = FCM.new(ENV['FCM_KEY'])
      registration_ids = [device_token]
      options = { 'notification': {
        'title': '알림메시지',
        'body': body
        }
      }
      response = fcm.send(registration_ids, options)
      puts "푸시 결과 #{response.to_yaml}"
    end
  end
end
