class AddMainImageAndActiveToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :main_image_id, :integer
    add_column :apartments, :active, :boolean, null: false, default: false
  end
end
