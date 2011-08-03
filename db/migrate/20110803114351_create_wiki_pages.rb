class CreateWikiPages < ActiveRecord::Migration
  def self.up
    create_table :wiki_pages do |t|
      t.string :title
      t.text :content
      t.string :slug, :uniq => true, :nil => false
      t.boolean :is_visible, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :wiki_pages
  end
end
