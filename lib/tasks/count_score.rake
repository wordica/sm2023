namespace :photoclicker do
  
    namespace :score do
      desc "Counting score"
      task :counter => :environment do


        all_users = User.all

        users_with_photos = []

        all_users.each do |f|

            if f.photos.length >= 1

                users_with_photos.push(f.id)

            end

        end

        downloads = 0
        views = 0
        likes = 0

        users_with_photos.each do |f|

            Photo.where('user_id =?',f).each do |c|
                    
                downloads += c.downloads
                views += c.views
                likes += c.likes

            end
            score = downloads*5 + views + likes*4
            Ranking.where('user_id =?',f).update(:downloads => downloads, :views => views, :likes => likes, :score => score)
            User.where('id =?',f).update(:score => score)
            downloads = 0
            views = 0
            likes = 0

        end



      end

    end

end