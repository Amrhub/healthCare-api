class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :gender
      t.date :birth_date
      t.integer :age
      t.string :address

      t.timestamps
    end
  end
end
