class CreateFacebookConnectedAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :facebook_connected_accounts do |t|
      t.belongs_to :user
      t.boolean :verified, default: false
      t.belongs_to :profile_page
      t.string :facebook_ad_account_id

      t.timestamps
    end
  end
end
