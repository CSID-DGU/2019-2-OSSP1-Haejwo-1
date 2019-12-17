class FollowService
  attr_reader :follower, :followed

  def initialize(follower, followed)
    @follower = follower
    @followed = followed
  end

  def exec
    follow = Follow.find_by(f_h)
    if follow.nil?
      Follow.create!(f_h)
    else
      follow.destroy
    end
  end

  private
  def f_h
    return {
      follower: follower,
      followed: followed
    }
  end
end
