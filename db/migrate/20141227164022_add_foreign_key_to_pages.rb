class AddForeignKeyToPages < ActiveRecord::Migration
  def up
    add_foreign_key(:pages, :pages, column: 'parent_id', name: 'parent_page_foreign_key')
  end

  def down
    remove_foreign_key(:pages, name: 'parent_page_foreign_key')
  end
end

