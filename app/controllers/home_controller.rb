class HomeController < ApplicationController
  def index
    @filters  = Event.filters_to_json
    @nav      = Event.years_to_json
    @timeline = Event.events_to_json
    @nav = ['2017', '2018', '2019', '2020'].to_json
  end
end
