class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.column :body, :string
      
      t.column :user_name, :string
      
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

  def self.down
    drop_table :messages
  end
end
