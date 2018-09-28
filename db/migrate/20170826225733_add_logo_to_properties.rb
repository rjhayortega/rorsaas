class AddLogoToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :logo, :string
  end
end
