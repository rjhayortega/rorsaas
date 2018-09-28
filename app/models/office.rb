# == Schema Information
#
# Table name: offices
#
#  id                             :integer          not null, primary key
#  name                           :string(255)
#  organisation_id                :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  users_count                    :integer          default(0)
#  maximum_users_count            :integer          default(10000)
#  payer_id                       :integer
#  stripe_manager_subscription_id :string(255)
#  stripe_agents_subscription_id  :string(255)
#  stripe_customer_id             :string(255)
#

class Office < ApplicationRecord
  validates :name, presence: true
  belongs_to :organisation

  belongs_to :payer, class_name: "User", optional: true

  has_many :users

  def update_agents_subscription!
    self.reload
    sub = Stripe::Subscription.retrieve(self.stripe_agents_subscription_id)
    sub.quantity = users_count
    sub.save
  end

  def cancel_current_subscriptions!
    self.update payer: nil
    raise '' if self.errors.present?

    if self.stripe_manager_subscription_id.present?
      begin
        sub = Stripe::Subscription.retrieve(self.stripe_manager_subscription_id)
        sub.delete
      rescue
      end
    end

    if self.stripe_agents_subscription_id.present?
      begin
        sub = Stripe::Subscription.retrieve(self.stripe_agents_subscription_id)
        sub.delete
      rescue
      end
    end

    self.update(
      stripe_manager_subscription_id: nil,
      stripe_agents_subscription_id: nil,
    )
  end
end
