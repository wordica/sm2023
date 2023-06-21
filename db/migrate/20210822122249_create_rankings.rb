class CreateRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :rankings do |t|
      t.integer :user_id
      t.integer :views
      t.integer :downloads
      t.integer :likes

      t.timestamps
    end
  end
end
