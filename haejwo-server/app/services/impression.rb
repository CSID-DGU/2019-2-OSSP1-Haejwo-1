class Impression
  attr_reader :obj, :user

  def initialize(obj, user = nil)
    @obj = obj
    @user = user
  end

  def add
    if user.nil?
      add_view_count
    else
      add_view_count if obj.user != user
    end
  end

  private
  def add_view_count
    obj.update_attributes(view_count: obj.view_count + 1)
  end
end
