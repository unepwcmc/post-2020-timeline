class CreateEventCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :event_categories do |t|
      t.belongs_to :event, index: true
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end
