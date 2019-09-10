require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @event = FactoryBot.create(:event)
    @user  = create(:user)
  end

  test "should get index" do
    sign_in @user
    get events_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    sign_in @user

    assert_difference('Event.count') do
      post events_url, params: { event: { cbd_relation: @event.cbd_relation, end_date: @event.end_date, is_provisional_date: @event.is_provisional_date, location: @event.location, outputs: @event.outputs, relevance: @event.relevance, start_date: @event.start_date, summary: @event.summary, title: "Event 12" } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    sign_in @user
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    sign_in @user
    patch event_url(@event), params: { event: { cbd_relation: @event.cbd_relation, end_date: @event.end_date, is_provisional_date: @event.is_provisional_date, location: @event.location, outputs: @event.outputs, relevance: @event.relevance, start_date: @event.start_date, summary: @event.summary, title: "Event 8" } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    sign_in @user
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
