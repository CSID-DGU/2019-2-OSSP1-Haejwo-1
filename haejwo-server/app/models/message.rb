class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom


  def next
    chatroom.messages.where("id > ?", id).first
  end

  def prev
    chatroom.messages.where("id < ?", id).last
  end
end
