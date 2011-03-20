class AddSummaryToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :summary, :text
  end

  def self.down
    remove_column :products, :summary
  end
end
