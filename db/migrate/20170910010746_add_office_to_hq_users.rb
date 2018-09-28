class AddOfficeToHqUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :hq_users, :office, foreign_key: true
  end
end
