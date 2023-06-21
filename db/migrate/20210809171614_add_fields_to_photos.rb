class AddFieldsToPhotos < ActiveRecord::Migration[6.1]
  def change

    add_column :photos, :downloads, :integer
    add_column :photos, :likes, :integer

  end
end
