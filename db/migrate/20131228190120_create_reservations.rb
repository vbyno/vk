class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :apartment, null: false, index: true
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.datetime :check_in, null: false
      t.datetime :check_out, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
