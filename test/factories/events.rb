FactoryBot.define do
  factory :event do
    title "Awesome event"
    summary "This is awesome"
    start_date Date.new(2017, 1, 1)
    end_date Date.new(2018, 1, 1)
    location "London, UK"
    outputs "http://www.unep-wcmc.org"
    relevance "Test"
    cbd_relation "N/A"

    factory :event_no_end_date do
      end_date nil
    end
  end

end
