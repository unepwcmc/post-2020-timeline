class HomeController < ApplicationController
  after_action :allow_iframe

  def index
    @filters  = Event.filters_to_json
    @nav      = Event.years_to_json
    @timeline = Event.events_to_json
  end

  def download_calendar_event
    filename = "post-2020_timeline-#{Date.today}"
    if params[:format]=='vcs'
      filename += '.vcs'
    else
      filename += '.ics'
    end

    calendar_event = Event.events_to_calendar(params[:format])
    send_data calendar_event, type: 'text/calendar', disposition: 'attachment', filename: filename
  end

  private
    def allow_iframe
      response.headers['X-Frame-Options'] = "ALLOW FROM http://uknea.unep-wcmc.org/test.html"
    end
end
