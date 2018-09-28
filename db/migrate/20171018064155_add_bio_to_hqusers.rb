class AddBioToHqusers < ActiveRecord::Migration[5.1]
  def change
    add_column :hq_users, :bio, :string
  end
end
