class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|

      t.integer :counter
      t.integer :user_id
      t.integer :photo_id
      t.string :name
      t.timestamps
    end
  end
end
