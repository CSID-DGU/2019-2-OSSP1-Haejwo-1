class Chatroom < ApplicationRecord
  belongs_to :event
  has_many :messages, dependent: :destroy
  has_many :senders, through: :messages, source: :user
  has_many :receivers, through: :messages, source: :user

  belongs_to :request_user, class_name: 'User'
  belongs_to :perform_user, class_name: 'User'
end
