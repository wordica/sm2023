class CreateDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :descriptions do |t|

      t.string :desc
      t.integer :photo_id
      t.timestamps
    end
  end
end
