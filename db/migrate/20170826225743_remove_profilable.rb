class RemoveProfilable < ActiveRecord::Migration[5.1]
  def change
    remove_column :knack_post, :profilable_id
    remove_column :knack_post, :profilable_type
    remove_column :knack_post, :id_before_splitting
  end
end
