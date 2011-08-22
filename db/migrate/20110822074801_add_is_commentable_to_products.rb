class AddIsCommentableToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_commentable, :boolean, :default => true
  end

  def self.down
    remove_column :products, :is_commentable
  end
end
