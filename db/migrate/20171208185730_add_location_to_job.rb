class AddLocationToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :location, :string
    add_column :jobs, :job_type, :string
    add_column :jobs, :salary, :integer
    add_column :jobs, :salary_range, :string
  end
end
