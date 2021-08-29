class AddHireToProfiles < ActiveRecord::Migration[6.1]
  def change

    add_column :profiles, :hire, :boolean, :default => false
    
  end
end
