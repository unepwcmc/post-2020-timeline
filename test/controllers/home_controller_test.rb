require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "index action returns 200" do
    event = FactoryBot.create(:event,
      start_date: Date.new(2017, 1, 1),
      end_date: Date.new(2018, 1, 1),
      location: "London, UK"
    )

    get :index
    assert_response :success
  end

end
