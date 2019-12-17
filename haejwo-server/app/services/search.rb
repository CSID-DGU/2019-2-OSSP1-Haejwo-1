class Search
  attr_reader :objs, :_sh, :q, :sort_params1

  def initialize(objs, _sh, q, sort_params1)
    @objs = objs
    @_sh = _sh
    @q = q
    @sort_params1 = sort_params1
  end

  def list
    r_objs = objs
    r_objs = _shed_objs(_sh) if (q.present? && _sh.present?)
    r_objs = r_objs.order(sort_params1)
  end

  private
  def _shed_objs(attr)
    objs.ransack(:"#{attr}_cont" => q).result
  end
end
