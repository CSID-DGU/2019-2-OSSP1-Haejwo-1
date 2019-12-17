class CalculateOrderTotal
  attr_reader :_year, :_month, :_payment_method

  def initialize(_year, _month, _payment_method)
    @_year = _year
    @_month = _month
    @_payment_method = _payment_method
  end

  def results
    orders = get_order_list
    [
      orders.size,
      orders.pluck('user_id').uniq.count,
      orders.sum(:total_without_shipping),
      orders.sum(:point),
      orders.sum(:total)
    ]
  end

  private
  def get_order_list
    extract_order_calculation = ExtractOrderCalculation.new(_year, _month)
    orders = extract_order_calculation.exec
    orders.send(_payment_method)
  end
end
