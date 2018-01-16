require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "index action returns 200" do
    event = FactoryBot.create(:event)

    get :index
    assert_response :success
  end

  test "index action returns 200 if end_date not present" do
    event = FactoryBot.create(:event_no_end_date)

    get :index
    assert_response :success
  end

end
