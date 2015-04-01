class AddPermalinkToApartment < ActiveRecord::Migration
  def up
    add_column :apartments, :permalink, :string
    Apartment.update_all(permalink: "NO PERMALINK!")
    change_column :apartments, :permalink, :string, null: false
  end

  def down
    remove_column :apartments, :permalink
  end
end

