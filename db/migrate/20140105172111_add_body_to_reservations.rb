class AddBodyToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :body, :text
  end
end
