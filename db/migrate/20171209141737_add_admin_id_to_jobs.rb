class AddAdminIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :admin_id, :integer
  end
end
