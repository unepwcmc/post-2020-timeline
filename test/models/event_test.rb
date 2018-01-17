class EventTest < ActiveSupport::TestCase

  test "should not save event without title" do
    event = Event.new
    assert_not event.save
  end

  test "event timeline json should be correct" do
    event = FactoryBot.create(:event)
    organiser1 = FactoryBot.create(:organiser, name: "CBD Secretariat")
    event.organisers << organiser1
    expected_json = [
      {
        year: 2017,
        past_year: true,
        months: [
          {
            month: "jan",
            past_month: true,
            events: [
              {
                id: event.id,
                title: event.title,
                category: event.category,
                start_year: event.start_date.year,
                start_month: format('%02d', event.start_date.month),
                start_day: format('%02d', event.start_date.day),
                end_year: event.end_date.year,
                end_month: format('%02d', event.end_date.month),
                end_day: format('%02d', event.end_date.day),
                current_event: false,
                past_event: true,
                location: event.location,
                organisers: [organiser1.name],
                summary: event.summary,
                relevance: event.relevance,
                outputs: event.outputs,
                cbd_relation: event.cbd_relation,
                is_provisional_date: event.is_provisional_date
              }
            ]
          }]
        }].to_json

    json = Event.events_to_json
    assert_equal expected_json, json
  end

  test "filters json should be correct" do
    organiser1 = FactoryBot.create(:organiser, name: "CBD Secretariat")
    organiser2 = FactoryBot.create(:organiser, name: "UNEP-WCMC")
    organiser3 = FactoryBot.create(:organiser, name: "United Nations")
    event1 = FactoryBot.create(:event)
    event2 = FactoryBot.create(:event,
                               organisers: [organiser1],
                               category: "Marine-focus",
                               cbd_relation: "Other relevance")
    event3 = FactoryBot.create(:event,
                               organisers: [organiser2],
                               category: "Communications",
                               cbd_relation: "Direct contribution")
    event4 = FactoryBot.create(:event,
                               organisers: [organiser3],
                               category: "Area-based conservation",
                               cbd_relation: "Part of the process")
    expected_json = [
      {
        name: "category",
        title: "category",
        options: ["Area-based conservation", "Communications", "Intergovernmental processes", "Marine-focus"],
        multiple: false
      },
      {
        name: "organisers",
        title: "organisers",
        options: ["CBD Secretariat", "UNEP-WCMC", "United Nations"],
        multiple: true
      },
      {
        name: "cbd_relation",
        title: "CBD relation",
        options:["Direct contribution", "Other relevance", "Part of the process"],
        multiple: true
      }].to_json

    json = Event.filters_to_json
    assert_equal expected_json, json

  end

  test "years json should be correct" do
    event1 = FactoryBot.create(:event, start_date: Date.new(2017, 1, 1), end_date: Date.new(2018, 1, 1))
    event2 = FactoryBot.create(:event, start_date: Date.new(2019, 1, 1), end_date: Date.new(2020, 1, 1))

    expected_json = [2017,2018,2019,2020].to_json
    json = Event.years_to_json

    assert_equal expected_json, json
  end

end
