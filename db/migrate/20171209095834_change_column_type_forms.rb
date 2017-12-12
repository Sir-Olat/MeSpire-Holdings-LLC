class ChangeColumnTypeForms < ActiveRecord::Migration[5.1]
  def change
    change_column :forms, :mobile_number, :string
  end
end
