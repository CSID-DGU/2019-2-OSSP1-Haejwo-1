class Message < ApplicationRecord
  belongs_to :chatroom

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  def next
    chatroom.messages.where("id > ?", id).first
  end

  def prev
    chatroom.messages.where("id < ?", id).last
  end
end
