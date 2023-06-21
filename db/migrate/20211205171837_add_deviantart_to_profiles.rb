class AddDeviantartToProfiles < ActiveRecord::Migration[6.1]
  def change

    add_column :profiles, :deviantart_url, :string, :default => "won't say"
    
  end
end
