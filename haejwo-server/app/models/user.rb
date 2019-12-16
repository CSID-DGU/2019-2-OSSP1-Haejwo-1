class User < ApplicationRecord
  CERTIFICATION_STATES = %i[unapproved waiting approved].freeze
  ACCOUNT_TYPES = %i{default naver kakao facebook}

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :identities, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :chatrooms, through: :messages, dependent: :destroy
  has_many :pushes, dependent: :destroy
  has_many :reports, dependent: :destroy

  enum gender: %i[no_select man woman]
  enum certification_state: CERTIFICATION_STATES
  enum device_type: %i[android ios]
  enum account_type: ACCOUNT_TYPES

  mount_uploader :thumbnail, ImageUploader
  mount_uploader :student_card_image, ImageUploader

  scope :whitelist, -> { where(blacklist: false) }
  scope :blacklist, -> { where(blacklist: true) }

  def to_s
    name
  end

  def thumbnail_url
    thumbnail.url.present? ? thumbnail.url : '/vuma/images/profile.png'
  end

  def student_card_image_url
    student_card_image.url.present? ? student_card_image.url : '/vuma/images/profile.png'
  end

  def send_push(title, body)
    if device_token.present? && device_type.present? && Rails.env.production?
      fcm = FCM.new(ENV['FCM_KEY'])
      registration_ids = [device_token]
      options = { 'notification': {
        'title': title,
        'body': body
        }
      }
      response = fcm.send(registration_ids, options)
      pushes.create!(title: title, body: body)
    end
  end
end
