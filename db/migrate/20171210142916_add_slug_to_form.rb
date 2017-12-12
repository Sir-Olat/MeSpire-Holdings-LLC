class AddSlugToForm < ActiveRecord::Migration[5.1]
  def change
    add_column :forms, :linkedin_url, :string
    add_column :forms, :slug, :string
    add_index :forms, :slug, unique: true
  end
end
