class CreateAdminMailings < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_mailings do |t|
      t.string   "sender_1"
      t.string   "sender_2"
      t.string   "subject_1"
      t.string   "subject_2"
      t.text     "filters"
      t.boolean  "sent",       default: false, null: false
      t.timestamps
    end
  end
end
