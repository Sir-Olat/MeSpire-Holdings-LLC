class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.string :name
      t.string :address
      t.string :email
      t.datetime :dob
      t.string :reference
      t.string :position
      t.integer :mobile_number

      t.timestamps
    end
  end
end
