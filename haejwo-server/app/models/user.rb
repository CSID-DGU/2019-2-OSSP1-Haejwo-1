class User < ApplicationRecord
  CERTIFICATION_STATES = %i[unapproved waiting approved].freeze
  ACCOUNT_TYPES = %i[default naver kakao facebook].freeze

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :identities, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :chatroom_request_relation, foreign_key: :request_user_id, class_name: 'Chatroom'
  has_many :request_chatrooms, through: :chatroom_request_relation, source: :perform_user, dependent: :destroy
  has_many :chatroom_perform_relation, foreign_key: :perform_user_id, class_name: 'Chatroom'
  has_many :perform_chatrooms, through: :chatroom_perform_relation, source: :request_user, dependent: :destroy
  has_many :message_sender_relation, foreign_key: :sender_id, class_name: 'Message'
  has_many :sender_messages, through: :message_sender_relation, source: :receiver, dependent: :destroy
  has_many :message_receiver_relation, foreign_key: :receiver_id, class_name: 'Message'
  has_many :receiver_messages, through: :message_receiver_relation, source: :sender, dependent: :destroy
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
