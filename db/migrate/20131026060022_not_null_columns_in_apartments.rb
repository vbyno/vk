class NotNullColumnsInApartments < ActiveRecord::Migration
  def up
  	change_table :apartments do |t|
  		t.change :title, :string, null: false
      t.change :price, :decimal, precision: 6, scale: 2, null: false
      t.change :description, :text, null: false
    end
  end

  def down
    change_table :apartments do |t|
      t.change :title, :string
      t.change :price, :decimal, precision: 6, scale: 2
      t.change :description, :text
    end
  end
end
