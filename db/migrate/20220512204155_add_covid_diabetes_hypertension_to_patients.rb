class AddCovidDiabetesHypertensionToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :covid, :boolean, default: false
    add_column :patients, :diabetes, :boolean, default: false
    add_column :patients, :hypertension, :boolean, default: false
  end
end
