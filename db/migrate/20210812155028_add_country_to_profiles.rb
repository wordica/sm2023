class AddCountryToProfiles < ActiveRecord::Migration[6.1]
  def change

    add_column :profiles, :country, :string
    
  end
end
