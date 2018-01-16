class AddProvisionalDateFlagToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :is_provisional_date, :boolean, default: false, null: false
  end
end
