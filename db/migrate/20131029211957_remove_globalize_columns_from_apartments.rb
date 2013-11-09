class RemoveGlobalizeColumnsFromApartments < ActiveRecord::Migration
  def up
    remove_column :apartments, :title
    remove_column :apartments, :description
  end

  def down
    add_column :apartments, :title, :string, null: false
    add_column :apartments, :description, :text, null: false
  end
end
