class AddOrganisationToHqUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :hq_users, :organisation, foreign_key: true
  end
end
