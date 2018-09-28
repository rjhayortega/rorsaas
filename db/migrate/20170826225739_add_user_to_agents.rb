class AddUserToAgents < ActiveRecord::Migration[5.1]
  def change
    add_reference :agents, :user
  end
end
