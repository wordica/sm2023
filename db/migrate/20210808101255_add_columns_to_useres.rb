class AddColumnsToUseres < ActiveRecord::Migration[6.1]
  def change

    add_column :users, :username, :string
    add_column :users, :gender, :integer
    add_column :users, :terms, :boolean, :default => false
    add_column :users, :personal_data, :boolean, :default => false
    add_column :users, :marketing, :boolean, :default => false
    add_column :users, :marketing_second, :boolean, :default => false

    
  end
end
