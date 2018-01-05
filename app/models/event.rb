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
    start_year = events.pluck(:start_date).compact.uniq.sort.first.year
    end_year = events.pluck(:start_date).compact.uniq.sort.last.year
    years = start_year.upto(end_year).to_a

    years.map do |year|
      start_of_year = Date.new(year,1,1)
      end_of_year = Date.new(year,12,31)
      year_events = events.where("start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?",
                                 start_of_year, end_of_year, start_of_year, end_of_year)
      months = year_events.pluck(:start_date, :end_date).flatten.uniq.compact.map { |e| e.strftime("%b") }.uniq.map(&:downcase)

      monthly_events = months.map do |month|
      [
        month: month,
        events: [ monthly_events(year_events, month, year) ]
      ]
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
    start_of_month = Date.parse('1st #{month} #{year}')
    end_of_month   = start_of_month.end_of_month

    monthly_events_list = year_events.where("start_date BETWEEN ? AND ? OR end_date BETWEEN ? AND ?",
                    start_of_month, end_of_month, start_of_month, end_of_month).order(:start_date)

    monthly_events_list.map do |monthly_event|
      start_day = monthly_event.start_date.nil? ? nil : format('%02d', monthly_event.start_date.day)
      start_month = monthly_event.start_date.nil? ? nil : format('%02d', monthly_event.start_date.month)
      end_day = monthly_event.end_date.nil? ? nil : format('%02d', monthly_event.end_date.day)
      end_month = monthly_event.end_date.nil? ? nil : format('%02d', monthly_event.end_date.month)
      {
        title: monthly_event.title,
        category: monthly_event.category,
        start_year: monthly_event.start_date&.year || nil,
        start_month: start_month,
        start_day: start_day,
        end_year: monthly_event.end_date&.year || nil,
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
