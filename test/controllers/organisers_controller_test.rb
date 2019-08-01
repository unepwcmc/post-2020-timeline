require 'test_helper'

class OrganisersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organiser = FactoryBoy.create(:organiser)
  end

  test "should get index" do
    get organisers_url
    assert_response :success
  end

  test "should get new" do
    get new_organiser_url
    assert_response :success
  end

  test "should create organiser" do
    assert_difference('Organiser.count') do
      post organisers_url, params: { organiser: { name: @organiser.name } }
    end

    assert_redirected_to organiser_url(Organiser.last)
  end

  test "should show organiser" do
    get organiser_url(@organiser)
    assert_response :success
  end

  test "should get edit" do
    get edit_organiser_url(@organiser)
    assert_response :success
  end

  test "should update organiser" do
    patch organiser_url(@organiser), params: { organiser: { name: @organiser.name } }
    assert_redirected_to organiser_url(@organiser)
  end

  test "should destroy organiser" do
    assert_difference('Organiser.count', -1) do
      delete organiser_url(@organiser)
    end

    assert_redirected_to organisers_url
  end
end
