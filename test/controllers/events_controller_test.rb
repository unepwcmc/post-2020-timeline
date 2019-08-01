require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = FactoryBot.create(:event)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { cbd_relation: @event.cbd_relation, end_date: @event.end_date, is_provisional_date: @event.is_provisional_date, location: @event.location, outputs: @event.outputs, relevance: @event.relevance, start_date: @event.start_date, summary: @event.summary, title: @event.title } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { cbd_relation: @event.cbd_relation, end_date: @event.end_date, is_provisional_date: @event.is_provisional_date, location: @event.location, outputs: @event.outputs, relevance: @event.relevance, start_date: @event.start_date, summary: @event.summary, title: @event.title } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
