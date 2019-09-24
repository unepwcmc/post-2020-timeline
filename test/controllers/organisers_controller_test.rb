require 'test_helper'

class OrganisersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @organiser = FactoryBot.create(:organiser)
    @user = create(:user)
  end

  test "should get index" do
    sign_in @user
    get organisers_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_organiser_url
    assert_response :success
  end

  test "should create organiser" do
    sign_in @user

    assert_difference('Organiser.count') do
      post organisers_url, params: { organiser: { name: "Test organiser" } }
    end

    assert_redirected_to organiser_url(Organiser.last)
  end

  test "should show organiser" do
    sign_in @user
    get organiser_url(@organiser)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_organiser_url(@organiser)
    assert_response :success
  end

  test "should update organiser" do
    sign_in @user
    patch organiser_url(@organiser), params: { organiser: { name: @organiser.name } }
    assert_redirected_to organiser_url(@organiser)
  end

  test "should destroy organiser" do
    sign_in @user

    assert_difference('Organiser.count', -1) do
      delete organiser_url(@organiser)
    end

    assert_redirected_to organisers_url
  end
end
