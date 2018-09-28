class AddIsNewDesignToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :hq_users, :is_new_design, :boolean, default: true
    User.where("id < 890").update_all is_new_design: false
  end
end
