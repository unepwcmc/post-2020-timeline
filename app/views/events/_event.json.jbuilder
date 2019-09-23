json.extract! event, :id, :title, :start_date, :end_date, :location, :summary, :relevance, :outputs, :cbd_relation, :is_provisional_date, :created_at, :updated_at
json.url event_url(event, format: :json)
