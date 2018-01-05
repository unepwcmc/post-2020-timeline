class Event < ApplicationRecord
  has_and_belongs_to_many :organisers, class_name: 'Organiser', join_table: 'event_organisers'

  def self.filters_to_json
    events = Event.all.order(id: :asc)
    unique_categories = events.pluck(:category).compact.uniq.sort
    unique_organisers = Organiser.pluck(:name).compact.sort

    filters = [
     {
        name: 'category',
        title: 'category',
        options: unique_categories,
        multiple: false
      },
     {
        name: 'organisers',
        title: 'organisers',
        options: unique_organisers,
        multiple: true
      }
    ].to_json
  end

  def self.events_to_json
    timeline = []
    events = Event.all.order(start_date: :asc)
    start_year = events.pluck(:start_date).compact.sort.first.year
    end_year = events.pluck(:start_date).compact.sort.last.year
    years = start_year.upto(end_year).to_a

    years.map do |year|
      sql = %{
        EXTRACT(year from start_date) = ? OR
        EXTRACT(year from end_date) = ?
      }
      year_events = events.where(sql, year, year)
      months = year_events.pluck(:start_date, :end_date).flatten.compact.map(&:month).uniq

      monthly_events = months.map do |month|
      {
        month: Date::ABBR_MONTHNAMES[month].downcase,
        events: monthly_events(year_events, month, year)
      }
      end

      yearly_events_hash = {
        year: year,
        months: monthly_events
      }

      timeline << yearly_events_hash
      timeline.to_json
    end
  end

  private

  def self.monthly_events(year_events, month, year)
    sql = %{
      EXTRACT(month from start_date) = ? OR
      EXTRACT(month from end_date) = ?
    }
    monthly_events_list = year_events.where(sql, month, month).order(:start_date)

    monthly_events_list.map do |monthly_event|
      start_day = format('%02d', monthly_event.start_date.day) rescue nil
      start_month = format('%02d', monthly_event.start_date.month) rescue nil
      end_day = format('%02d', monthly_event.end_date.day) rescue nil
      end_month = format('%02d', monthly_event.end_date.month) rescue nil
      {
        title: monthly_event.title,
        category: monthly_event.category,
        start_year: monthly_event.start_date&.year,
        start_month: start_month,
        start_day: start_day,
        end_year: monthly_event.end_date&.year,
        end_month: end_month,
        end_day: end_day,
        location: monthly_event.location,
        organisers: monthly_event.organisers.pluck(:name),
        summary: monthly_event.summary,
        relevance: monthly_event.relevance,
        outputs: monthly_event.outputs
      }
    end
  end

end
