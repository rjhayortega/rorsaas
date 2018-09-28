class AddAgentToProperty < ActiveRecord::Migration[5.1]
  def change
    add_reference :properties, :agent, foreign_key: true
  end
end
