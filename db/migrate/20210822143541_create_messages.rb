class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :subject
      t.string :email
      t.text :content

      t.timestamps
    end
  end
end
