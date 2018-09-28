class AddStripeCustomerIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :hq_users, :stripe_customer_id, :string
  end
end
