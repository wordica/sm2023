class AddViewsToPhotos < ActiveRecord::Migration[6.1]
  def change

    add_column :photos, :views, :integer, :default => 0
    
  end
end
