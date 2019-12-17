class LikeService
  attr_reader :_user, :_likes, :_followings

  def initialize(_user)
    @_user = _user
    @_likes = (_user._likes.pluck(:post_id).uniq) rescue []
    @_followings = (_user._followings.pluck(:id).uniq) rescue []
  end

  def is_like(post_id)
    _likes.include?(post_id)
  end

  def is_follower(_user_id)
    _followings.include?(_user_id)
  end

  def get_heart_state(post_id)
    is_like(post_id) ? 'ion-ios-happy' : 'ion-md-happy'
  end

  def get_follow_state(followed_id)
    is_follower(followed_id) ? '팔로우 취소' : '팔로우'
  end
end
