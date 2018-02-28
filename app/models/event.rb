class Event < ApplicationRecord
  has_and_belongs_to_many :organisers, class_name: 'Organiser', join_table: 'event_organisers'
  has_and_belongs_to_many :categories, class_name: 'Category', join_table: 'event_categories'
  validates :title, presence: true

  def self.filters_to_json
    events = Event.all.order(id: :asc)
    unique_categories = Category.pluck(:name).compact.uniq.sort
    unique_organisers = Organiser.pluck(:name).compact.uniq.sort
    unique_cbd_relations = events.pluck(:cbd_relation).compact.uniq.sort.select {|i| !i.blank? }
    unique_cbd_relations.insert(0, "Show all")
    unique_cbd_relations.delete("Other relevance")

    filters = [
      {
        name: 'category',
        title: 'groupings',
        options: unique_categories,
        type: 'multiple'
      },
      {
        name: 'organisers',
        title: 'organisers',
        options: unique_organisers,
        type: 'multiple'
      },
      {
        name: 'cbd_relation',
        title: 'Relation to the CBD’s post-2020 process',
        options: unique_cbd_relations,
        type: 'radio'
      }
    ].to_json
  end

  def self.years_to_json
    events = Event.all
    start_year = events.pluck(:start_date).compact.sort.first.year rescue nil
    end_year = events.pluck(:end_date).compact.sort.last.year rescue nil
    years = start_year.upto(end_year).to_a rescue nil
    years.to_json
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
        past_month: past_month(year_events, month),
        events: group_by_month(year_events, month, year)
      }
      end

      yearly_events_hash = {
        year: year,
        past_year: past_year(year_events),
        months: monthly_events
      }

      timeline << yearly_events_hash
    end
    timeline.to_json
  end

  def self.events_to_calendar(format = nil)
    events = Event.where(is_provisional_date: false)
    calendar = Icalendar::Calendar.new

    if format == 'vcs'
      calendar.prodid = '-//Microsoft Corporation//Outlook MIMEDIR//EN'
      calendar.version = '1.0'
    else # ical
      calendar.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//EN'
      calendar.version = '2.0'
    end

    events.each do |event|
      calendar_event = Icalendar::Event.new
      calendar_event.dtstart = event.start_date
      calendar_event.dtend = event.end_date
      calendar_event.summary = event.title
      calendar_event.description = event.summary
      calendar_event.url = post_2020_website
      calendar_event.location = event.location

      calendar.add_event(calendar_event)
      calendar.publish
    end

    calendar.to_ical
  end

  private

  def self.post_2020_website
    "http://www.google.com"
  end

  def self.group_by_month(year_events, month, year)
    sql = %{
      EXTRACT(month from start_date) = ? OR
      EXTRACT(month from end_date) = ?
    }
    monthly_events_list = year_events.where(sql, month, month).order(:start_date)
    current_event_id = find_current_event_id

    monthly_events_list.map do |monthly_event|
      current_event = current_event_id == monthly_event.id
      past_event = (monthly_event.end_date < Date.today) rescue nil
      start_day = format('%02d', monthly_event.start_date.day) rescue nil
      start_month = format('%02d', monthly_event.start_date.month) rescue nil
      end_day = format('%02d', monthly_event.end_date.day) rescue nil
      end_month = format('%02d', monthly_event.end_date.month) rescue nil
      {
        id: monthly_event.id,
        title: monthly_event.title,
        category: monthly_event.categories.pluck(:name),
        start_year: monthly_event.start_date&.year,
        start_month: start_month,
        start_day: start_day,
        end_year: monthly_event.end_date&.year,
        end_month: end_month,
        end_day: end_day,
        current_event: current_event,
        past_event: past_event,
        location: monthly_event.location,
        organisers: monthly_event.organisers.pluck(:name),
        summary: monthly_event.summary,
        relevance: monthly_event.relevance,
        outputs: generate_url(monthly_event.outputs),
        cbd_relation: monthly_event.cbd_relation,
        is_provisional_date: monthly_event.is_provisional_date
      }
    end
  end

  def self.find_current_event_id
    sql = %{
      start_date <= ? AND
      end_date >= ?
    }
    current_event = Event.where(sql, Date.today, Date.today).order(start_date: :asc).first.id rescue nil
    return current_event if current_event.present?

    # We haven't found the current_event so we need to find the next event
    Event.where("start_date > ?", Date.today).order(start_date: :asc).first.id rescue nil
  end

  def self.past_month(year_events, month)
    sql = %{
      (EXTRACT(month from start_date) = ? OR
      EXTRACT(month from end_date) = ?) AND
      end_date >= ?
    }

    year_events.where(sql, month, month, Date.today).blank?
  end

  def self.past_year(year_events)
    year_events.where("end_date >= ?", Date.today).blank?
  end

  def self.generate_url(output)
    uris = URI.extract(output, ['http', 'https'])
    emails = output.scan(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)

    uris.each do |uri|
      output.sub!(uri, "<a href='#{uri}' title='Visit #{uri}'>#{uri}</a>")
    end

    emails.each do |email|
      output.sub!(email, "<a href='mailto:#{email}' title='Email #{email}'>#{email}</a>")
    end

    output.html_safe
  end
end
