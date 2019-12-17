class NewPointHistory
  attr_reader :_user, :_amount, :_state, :order

  def initialize(_user, _amount, _state, order = nil)
    @_user = _user
    @_amount = _amount
    @_state = _state
    @order = order
  end

  def generate
    if _amount > 0
      _user.point_histories.create!(point_history_hash)
      _user.update_attributes!(point: result_point)
    end
  end

  private
  def point_history_hash
    result = {
      _amount: _amount,
      _state: _state
    }
    result[:order] = order if order.present?
    result
  end

  # _state에 따라 달라지는 포인트
  def result_point
    if _state == 'accumulate'
      _user.point + _amount
    else
      _user.point - _amount
    end
  end
end
