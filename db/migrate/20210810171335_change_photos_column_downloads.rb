class ChangePhotosColumnDownloads < ActiveRecord::Migration[6.1]
  def change

    change_column :photos, :downloads, :integer, :default => 0
    
  end
end
