class AddImageAndTimestampsToCatAutomate < ActiveRecord::Migration[5.1]
  def up
    add_column :cat_automate, :image, :string
    add_column :cat_automate, :created_at, :datetime
    add_column :cat_automate, :updated_at, :datetime

    QueueList.find_each do |ql|
      ql.update remote_image_url: "http://app.houseq.io/upload_files/post/" + ql.img
    end
  end

  def down
    remove_column :cat_automate, :image, :string
    remove_column :cat_automate, :created_at, :datetime
    remove_column :cat_automate, :updated_at, :datetime
  end
end
