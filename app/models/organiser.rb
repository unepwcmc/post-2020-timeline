class Organiser < ApplicationRecord
  has_and_belongs_to_many :events, class_name: "Event", join_table: 'event_organisers'
  validates :name, uniqueness: true
end
