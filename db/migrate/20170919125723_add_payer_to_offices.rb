class AddPayerToOffices < ActiveRecord::Migration[5.1]
  def change
    add_reference :offices, :payer
  end
end
