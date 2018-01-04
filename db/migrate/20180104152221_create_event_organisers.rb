class CreateEventOrganisers < ActiveRecord::Migration[5.1]
  def change
    create_table :event_organisers do |t|
      t.belongs_to :event, index: true
      t.belongs_to :organiser, index: true
      t.timestamps
    end
  end
end
