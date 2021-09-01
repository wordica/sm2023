class CreateAdvMailings < ActiveRecord::Migration[6.1]
  def change
    create_table :adv_mailings do |t|

      t.timestamps
    end
  end
end
