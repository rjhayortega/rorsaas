class CreateEnquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :postcode
      t.text :message
      t.belongs_to :agent, foreign_key: true
      t.belongs_to :property, foreign_key: true

      t.timestamps
    end
  end
end
