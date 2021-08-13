class AddColumnsToPhotos < ActiveRecord::Migration[6.1]
  def change

    add_column :photos, :user_id, :integer
    add_column :photos, :active, :boolean, :defalut => false
    add_column :photos, :checked, :boolean, :default => false
    add_column :photos, :tags, :string 

  end
end
