class AddFirstNameToAgents < ActiveRecord::Migration[5.1]
  def change
    rename_column :agents, :name, :first_name
    add_column :agents, :last_name, :string
  end
end
