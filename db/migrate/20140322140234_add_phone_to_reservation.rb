class AddPhoneToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :customer_phone, :string, null: false
  end
end
