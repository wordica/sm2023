class AddScoreToRanking < ActiveRecord::Migration[6.1]
  def change

    add_column :rankings, :score, :integer, :default => 0
    change_column :rankings, :views, :integer, :default => 0
    change_column :rankings, :downloads, :integer, :default => 0
    change_column :rankings, :likes, :integer, :default => 0

  end
end
