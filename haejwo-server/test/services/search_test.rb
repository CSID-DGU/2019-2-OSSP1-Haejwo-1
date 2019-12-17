require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  setup do
    @search = Search.create!()
  end

  test "search 생성" do
    search_id = @search.id
    service = SearchService.new(search_id)
    pp service.build_search(search_id).attributes
  end
end
