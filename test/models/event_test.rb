class EventTest < ActiveSupport::TestCase

  test "should not save event without title" do
    event = Event.new
    assert_not event.save
  end

  test "event timeline json should be correct" do
    event = FactoryBot.create(:event)
    expected_json = [
      {
        year:2017,
        past_year:true,
        months: [
          {
            month: "jan",
            past_month: true,
            events: [
              {
                title: "Awesome event",
                category: "Intergovernmental processes",
                start_year: 2017,
                start_month:"01",
                start_day: "01",
                end_year: 2018,
                end_month: "01",
                end_day: "01",
                current_event: false,
                past_event: true,
                location: "London, UK",
                organisers: [],
                summary: "This is awesome",
                relevance: nil,
                outputs: "http://www.unep-wcmc.org",
                cbd_relation: nil
              }
            ]}]}].to_json

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
        options: ["Area-based conservation", "Communications", "Intergovernmental processes","Marine-focus"],
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

end
