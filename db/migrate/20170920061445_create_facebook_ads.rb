class CreateFacebookAds < ActiveRecord::Migration[5.1]
  def change
    create_table :facebook_ads do |t|
      t.string :campaign_name
      t.string :objective
      t.string :audience_location
      t.string :audience_group
      t.string :gender_preference
      t.text :detail
      t.string :total_budget
      t.date :start_on
      t.date :finish_on
      t.string :url
      t.string :headline
      t.string :best_pitch
      t.string :image

      t.belongs_to :facebook_connected_account, foreign_key: true

      t.timestamps
    end
  end
end
