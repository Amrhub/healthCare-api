class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :specialization
      t.integer :years_experience
      t.decimal :salary

      t.timestamps
    end
  end
end
