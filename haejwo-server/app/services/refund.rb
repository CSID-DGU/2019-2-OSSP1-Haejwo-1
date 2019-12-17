class Refund
  include Iamport
  attr_reader :_event, :refund_requests

  def initialize(_event, refund_requests)
    @_event = _event
    @refund_requests = refund_requests
  end

  def success
    ActiveRecord::Base.transaction do
      if request_refund?
        refund = _event.refunds.create!
        reset_line_items(refund) # 환불 요청한 line_item정보 리셋 or 삭제
        refund_sum = refund.line_items.sum(:total)
        point = _event.point
        pay_back(refund, point, refund_sum) # 환불하려는 총금액과 포인트 사용 비교해서 환불처리
      else
        raise 'error'
      end
    end
  end

  private
  def request_refund?
    result = false
    _event.line_items.each do |line_item|
      will_refund_line_item_quantity = refund_requests["quantity-#{line_item.id}"].to_i
      if will_refund_line_item_quantity.present? && will_refund_line_item_quantity > 0
        result = true
      end
    end
    result
  end

  def create_refund_line_item(refund, line_item, will_refund_line_item_quantity)
    refund.line_items.create!(
      item: line_item.item,
      option: line_item.option,
      quantity: will_refund_line_item_quantity,
      price: line_item.price,
      total: line_item.price * will_refund_line_item_quantity
    )
  end

  def reset_line_items(refund)
    _event.line_items.each do |line_item|
      will_refund_line_item_quantity = refund_requests["quantity-#{line_item.id}"].to_i
      if will_refund_line_item_quantity.present? && will_refund_line_item_quantity > 0
        result_quantity = line_item.quantity - will_refund_line_item_quantity
        if result_quantity == 0
          create_refund_line_item(refund, line_item, will_refund_line_item_quantity)
          line_item.destroy!
        else
          create_refund_line_item(refund, line_item, will_refund_line_item_quantity)
          line_item.update_attributes!(
            quantity: result_quantity,
            total: line_item.price * result_quantity
          )
        end
      end
    end
  end

  def readd_point(amount)
    new_point_history = NewPointHistory.new(_event.user, amount, :refund, _event)
    new_point_history.generate
  end

  def pay_back(refund, point, refund_sum)
    if point.zero?
      _event.update_attributes!(total: _event.total - refund_sum)
      refund.update_attributes!(total: refund_sum)
      iamport_cancel(_event._event, refund_sum) # 최종 아이엠 포트 환불
    elsif point < refund_sum # 환불하려는 총액이 포인트 사용량보다 많을 때
      real_pay_back_total = refund_sum - point
      _event.update_attributes!(total: _event.total - real_pay_back_total, point: 0) # Order의 Total 다시 계산하기
      refund.update_attributes!(total: real_pay_back_total, point: point) # 환불의 토탈, 포인트 계산
      readd_point(point) # 포인트 사용이 있었다면 포인트 먼저 돌려줌
      iamport_cancel(_event._event, real_pay_back_total) # 최종 아이엠 포트 환불
    else
      _event.update_attributes(point: point - refund_sum)
      refund.update_attributes!(point: refund_sum) # 환불의 토탈, 포인트 계산
      readd_point(refund_sum)
    end
  end
end
