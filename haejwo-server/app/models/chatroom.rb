class Chatroom < ApplicationRecord
  belongs_to :event
  has_many :messages, dependent: :destroy
  has_many :senders, through: :messages, source: :user
  has_many :receivers, through: :messages, source: :user

  belongs_to :request_user, class_name: 'User'
  belongs_to :perform_user, class_name: 'User'

  def oppenent_user(current_user)
    if current_user == perform_user
      request_user
    else
      perform_user
    end
  end
end
