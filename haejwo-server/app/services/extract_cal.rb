class ExtractCal
  attr_reader :_year, :month

  def initialize(_year, month)
    @_year = _year
    @month = month
  end

  def exec
    orders = Order.checked.includes(:deliveries)
    if _year.present? && month.present?
      orders = orders.where("extract(_year from paid_at) = ?", _year)
      orders = orders.where("extract(_year from paid_at) = ? and extract(month from paid_at) = ?", _year, month)
    elsif _year.present?
      orders = orders.where("extract(_year from paid_at) = ? and extract(month from paid_at) = ?", _year, month)
      orders = orders.where("extract(_year from paid_at) = ?", _year)
    end
    orders
  end
end
