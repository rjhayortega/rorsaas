class AddProfilableToKnackPost < ActiveRecord::Migration[5.1]
  def change
    add_reference :knack_post, :profilable, polymorphic: true
  end
end
