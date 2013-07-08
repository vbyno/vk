class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :title
      t.decimal :price, precision: 6, scale: 2
      t.text :description

      t.timestamps
    end
  end
end
