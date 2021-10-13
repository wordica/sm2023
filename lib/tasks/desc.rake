namespace :photoclicker do
  
    namespace :desc do
      desc "Adding default description"
      task :default => :environment do

        Photo.all.each do |d|

            Description.create!(:photo_id => d.id, :name => 'You can add description to this photo')

        end

      end


    end



end
