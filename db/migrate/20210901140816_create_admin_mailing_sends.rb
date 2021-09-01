class CreateAdminMailingSends < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_mailing_sends do |t|
      t.integer  "user_id"
      t.string   "name"
      t.string   "email"
      t.string   "authentication_token"
      t.string   "term_gender_id"
      t.integer  "sender_id"
      t.string   "sender_email"
      t.string   "subject"
      t.string   "template"
      t.timestamps
    end
  end
end
