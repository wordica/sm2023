class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|

      t.string  :instagram_url
      t.string  :facebook_url
      t.string  :my_site
      t.integer :uploaded_photos
      t.integer :rating
      t.string :profile_name
      t.integer :user_id
      t.timestamps
    end
  end
end
