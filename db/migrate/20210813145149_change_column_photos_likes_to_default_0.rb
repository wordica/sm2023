class ChangeColumnPhotosLikesToDefault0 < ActiveRecord::Migration[6.1]
  def change

    change_column :photos, :likes, :integer, :default => 0

  end
end
