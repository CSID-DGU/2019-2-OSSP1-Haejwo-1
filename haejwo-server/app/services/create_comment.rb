class CreateComment
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def is_success
    user = User.admin_user
    comm_params = comm_hash(user)
    Comment.create!(comm_params) ? true : false
  end

  private
  def comment_hash(user)
    @params[:comm][:post_id] = params[:post_id]
    @params[:comm][:user_id] = user.id
    @params.require(:comm).permit(:user_id, :post_id, :body)
  end
end
