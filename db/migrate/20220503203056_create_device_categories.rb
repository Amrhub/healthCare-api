class CreateDeviceCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :device_categories do |t|
      t.string :device_name
      t.decimal :price
      t.string :device_items

      t.timestamps
    end
  end
end
