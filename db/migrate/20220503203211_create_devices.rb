class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.references :device_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
