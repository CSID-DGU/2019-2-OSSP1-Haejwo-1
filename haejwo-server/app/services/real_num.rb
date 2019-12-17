class RealNum
  attr_reader :event_requests

  def initialize(event_requests)
    @event_requests = event_requests
  end

  def get_real_price
    real_price = 0
    if event_requests[:price] != 0
      real_price = (event_requests[:price].to_i * (100 - event_requests[:sale_rate].to_i)/100.to_f).to_i
    else
      real_price = event_requests[:price].to_i
    end
    return real_price
  end
end
