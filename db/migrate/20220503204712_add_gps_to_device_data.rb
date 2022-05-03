class AddGpsToDeviceData < ActiveRecord::Migration[7.0]
  def change
    add_column: device_data, :gps, :float, array: true, default: []
  end
end
