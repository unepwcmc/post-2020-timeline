class Category < ApplicationRecord
  has_and_belongs_to_many :events, class_name: "Event", join_table: 'event_categories'
  validates :name, uniqueness: true, presence: true
end
