class Event < ApplicationRecord
  has_and_belongs_to_many :organisers, class_name: 'Organiser', join_table: 'event_organisers'
end
