class AddSlugToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :slug, :string, null: false

    Property.all.each do |pro|
      pro.slug = nil
      pro.save
    end

    add_index :properties, :slug, unique: true
  end
end
