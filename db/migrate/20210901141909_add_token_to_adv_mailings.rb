class AddTokenToAdvMailings < ActiveRecord::Migration[6.1]
  def change

    add_column :adv_mailings, :token, :string
    
  end
end
