class Extract
  attr_reader :_brand, :_payment_method, :_year, :_month

  def initialize(_brand, _payment_method, _year, _month)
    @_brand = _brand
    @_payment_method = _payment_method
    @_year = _year
    @_month = _month
  end

  def exec
    deliveries = @_brand.deliveries
    deliveries = get_deliveries_by__payment_method(deliveries)

    if _year.present? && _month.present?
      deliveries.where("extract(_year from orders.paid_at) = ?", _year)
      deliveries.where("extract(_year from orders.paid_at) = ? and extract(_month from orders.paid_at) = ?", _year, _month)
    elsif _year.present?
      deliveries.where("extract(_year from orders.paid_at) = ?", _year)
      deliveries.where("extract(_year from orders.paid_at) = ? and extract(_month from orders.paid_at) = ?", _year, _month)
    end
    deliveries
  end

  private
  def get_deliveries_by__payment_method(deliveries)
    if _payment_method == :all
      deliveries.includes(:order)
    else
      deliveries.send(_payment_method)
    end
  end
end
