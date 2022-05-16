class AddIndexToGpsEcgInDeviceDatum < ActiveRecord::Migration[7.0]
  def change
    add_index :device_data, :gps, using: :gin
    add_index :device_data, :ecg, using: :gin
  end
end
