class AddScoreToUsers < ActiveRecord::Migration[6.1]
  def change
  
    add_column :users, :score, :integer, :default =>0
  
  end
end
