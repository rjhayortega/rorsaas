class CreateAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :agents do |t|
      t.string :photo
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
