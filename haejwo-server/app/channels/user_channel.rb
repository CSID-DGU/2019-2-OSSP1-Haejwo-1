class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{params['user_id']}_channel" if params['user_id'].present?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
