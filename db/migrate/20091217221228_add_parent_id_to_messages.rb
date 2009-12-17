class AddParentIdToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :parent_id, :integer, :null => true
  end

  def self.down
    remove_column :messages, :parent_id
  end
end
