class CreateOrganisers < ActiveRecord::Migration[5.1]
  def change
    create_table :organisers do |t|
      t.string :name
      t.timestamps
    end
  end
end
