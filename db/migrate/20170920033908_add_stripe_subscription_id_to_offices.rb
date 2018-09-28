class AddStripeSubscriptionIdToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :stripe_manager_subscription_id, :string
    add_column :offices, :stripe_agents_subscription_id, :string
    add_column :offices, :stripe_customer_id, :string
  end
end
