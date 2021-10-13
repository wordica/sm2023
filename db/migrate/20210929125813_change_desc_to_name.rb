class ChangeDescToName < ActiveRecord::Migration[6.1]
  def change

    add_column :descriptions, :name, :text
    remove_column :descriptions, :desc, :text

  end
end
