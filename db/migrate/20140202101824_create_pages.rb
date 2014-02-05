class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :type, null: false
      t.integer :parent_id, index: true
      t.string :permalink, null: false
      t.string :locale, null: false
      t.text :content, null: false
      t.boolean :active, null: false, default: false
      t.string :seo_title, null: false
      t.string :seo_description
      t.string :seo_keywords
      t.timestamps
    end
  end
end
