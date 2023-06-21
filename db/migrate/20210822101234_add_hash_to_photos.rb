class AddHashToPhotos < ActiveRecord::Migration[6.1]
  def change

    add_column :photos, :hashed, :string

  end
end
