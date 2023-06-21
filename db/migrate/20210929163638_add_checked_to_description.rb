class AddCheckedToDescription < ActiveRecord::Migration[6.1]
  def change


    add_column :descriptions, :checked, :boolean, :default => false

  end
end
