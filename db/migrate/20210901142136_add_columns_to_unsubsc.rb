class AddColumnsToUnsubsc < ActiveRecord::Migration[6.1]
  def change

    add_column :unsubscribes, :email, :string 
    add_column :unsubscribes, :token, :string

    
  end
end
