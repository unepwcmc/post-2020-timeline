class AddCbdRelationToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :cbd_relation, :string
  end
end
