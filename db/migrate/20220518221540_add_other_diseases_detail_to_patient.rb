class AddOtherDiseasesDetailToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :other_diseases_detail, :text
  end
end
