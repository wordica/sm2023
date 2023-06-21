class AddColumnsToAdvMailing < ActiveRecord::Migration[6.1]
  def change

    add_column :adv_mailings, :email, :string, default: "", null: false
    
  end
end
