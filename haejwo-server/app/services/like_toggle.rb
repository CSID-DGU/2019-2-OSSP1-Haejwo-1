class LikeToggle
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def exec
    like = Like.find_by(like_relation_hash)
    if like.nil?
      like = Like.create!(like_relation_hash)
    else
      like.destroy
    end
  end

  private
  def like_relation_hash
    return {
      user: user,
      post: post
    }
  end
end
