class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
    
      t.string :email
      t.string :name
      t.string :subject
      t.text :body
      t.string :user_agent
      t.timestamps
    end
  end
end
