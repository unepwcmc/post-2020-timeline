class RemoveCategoryFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :category, :string
  end
end
