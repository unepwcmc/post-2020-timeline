class HomeController < ApplicationController
  def index
    @filters =  Event.filters_to_json
    @timeline = Event.events_to_json
  end
end
