class CreateUserBanneds < ActiveRecord::Migration[6.1]
  def change
    create_table :user_banneds do |t|
      t.string :email
      t.string :ip
      t.string :username

      t.timestamps
    end
  end
end
