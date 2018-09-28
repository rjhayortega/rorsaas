class AddVerifiedToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :knack_profiles, :verified, :boolean, default: false
  end
end
