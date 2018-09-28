class AddTimezoneStrToKnackPost < ActiveRecord::Migration[5.1]
  def change
  	add_column :knack_post, :timezone_str, :string, default: 'UTC'
  end
end
