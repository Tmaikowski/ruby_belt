class CreateHubs < ActiveRecord::Migration[5.0]
  def change
    create_table :hubs do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
