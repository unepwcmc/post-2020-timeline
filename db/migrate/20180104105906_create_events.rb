class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :location
      t.string :organisers
      t.string :summary, null: false
      t.string :relevance
      t.string :outputs, null: false
      t.string :category_first, null: false
      t.string :category_second
    end
  end
end
