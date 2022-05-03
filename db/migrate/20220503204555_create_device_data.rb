class CreateDeviceData < ActiveRecord::Migration[7.0]
  def change
    create_table :device_data do |t|
      t.references :device, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :spo2
      t.integer :heart_rate
      t.float :temperature

      t.timestamps
    end
  end
end
