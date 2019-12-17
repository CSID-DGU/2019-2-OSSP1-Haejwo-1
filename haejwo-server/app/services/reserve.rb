class Reserve
  attr_reader :user, :_event, :requests

  def initialize(user, _event, requests)
    @user = user
    @_event = _event
    @requests = requests
  end

  def exec_and_get_order
    ActiveRecord::Base.transaction do
      order = get_order
      add_line__events(order)
      order
    end
  end

  private
  def get_order
    get_order = GetOrder.new(user)
    if b_t == 'waiting' || b_t == 'approved'
      order = get_order.waiting
    elsif b_t == 'direct'
      order = get_order.direct
    else
      order = nil
    end
    order
  end

  # 상품을 장바구니에 담거나 바로 구매할 때 order의 line__event에 _event 담는 함수
  def add_line__events(order)
    line__event_arr.each do |info|
      if line__event = order.line__events.where(_event: _event, option_id: info[0]).first
        line__event.update_attributes(quantity: (line__event.quantity + info[1]))
      else
        order.line__events.create!(
          option_id: info[0],
          _event: _event,
          quantity: info[1]
        )
      end
    end
  end

  # [[option_id, quantity], ....] 형태의 배열생성
  def line__event_arr
    flat_infos = line__event_infos.split(',').map(&:to_i)
    result_infos = []
    infos = []
    check = 0
    flat_infos.each do |flat_info|
      check += 1
      infos.append(flat_info)
      if check == 2
        result_infos << infos
        check = 0
        infos = []
      end
    end
    result_infos
  end

  def line__event_infos
    requests[:line__event_infos]
  end

  def b_t
    requests[:b_t]
  end
end
