class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      
      t.string :author
      t.string :keyword
      t.timestamps
    end
  end
end
