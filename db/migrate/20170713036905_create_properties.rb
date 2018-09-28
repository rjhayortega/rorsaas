class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.string :address
      t.belongs_to :user

      t.timestamps
    end
  end
end
