class PayIamp
  attr_reader :_code, :iamp_res, :_event, :params

  def initialize(_code, iamp_res, _event, params)
    @_event = _event
    @_code = _code
    @iamp_res = iamp_res
    @params = params
  end

  # 결제완료시 최종 실행
  def success
    information_setter
    if _code == 0 && @paid_total == @_event.total
      begin
        ActiveRecord::Base.transaction do
          _event.update_attributes!(_event_hash)
          use_and_accumulate_point # 포인트 적립, 차감 및 히스토리 생성
          VirtualBank.create!(vbank_params) if params[:pay_method] == 'vbank'
        end
      rescue
        return false
      end
      return true
    else
      return false
    end
  end

  private
  def information_setter
    @status = iamp_res['status']
    @paid_total = iamp_res['amount']
    @pay_method = iamp_res['pay_method']
  end

  def _event_hash
    information_setter
    return {
      iamp_res: iamp_res,
      state: @status,
      total: @paid_total,
      paid_at: Time.current,
      payment_method: @pay_method
    }
  end

  def vbank_params
    {
      name: params[:vbank_name],
      _event: _event,
      holder: params[:vbank_holder],
      number: params[:vbank_num],
      due_date: params[:vbank_due]
    }
  end

  def use_and_accumulate_point
    will_point_total = _event.total / Item::WILL_POINT_PER
    if _event.point > 0
      new_point_history = NewPointHistory.new(_event.user, _event.point, :usage, _event)
      new_point_history.generate
    end
    if will_point_total > 0
      new_point_history = NewPointHistory.new(_event.user, will_point_total, :accumulate, _event)
      new_point_history.generate
    end
  end
end
