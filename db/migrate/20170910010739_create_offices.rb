class CreateOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :offices do |t|
      t.string :name
      t.belongs_to :organisation, foreign_key: true

      t.timestamps
    end
  end
end
