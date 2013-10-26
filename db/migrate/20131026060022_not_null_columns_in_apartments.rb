class NotNullColumnsInApartments < ActiveRecord::Migration
  def change
  	change_table :apartments do |t|
  		t.change :title, :string, null: false
      t.change :price, :decimal, precision: 6, scale: 2, null: false
      t.change :description, :text, null: false
    end
  end
end
