class ChangeColumnUserToPatient < ActiveRecord::Migration[7.0]
  def change
    remove_column :device_data, :user_id
    add_reference :devices, :patient, foreign_key: true
  end
end
