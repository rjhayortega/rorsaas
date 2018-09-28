class AddPageToFacebookAds < ActiveRecord::Migration[5.1]
  def change
    add_reference :facebook_ads, :page
  end
end
