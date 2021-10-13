class AddPhotodescription < ActiveRecord::Migration[6.1]
  def change

    add_column :photos, :desc, :text

  end
end
