require 'rubygems'
require 'sitemap_generator'


  SitemapGenerator::Sitemap.default_host = "https://photoclicker.net"
  SitemapGenerator::Sitemap.public_path = "public"
  SitemapGenerator::Sitemap.sitemaps_path = ''
  SitemapGenerator::Sitemap.create do
    
    add root_path, priority: 1, changefreq: 'daily'
    
    #add articles_path, changefreq: 'weekly'

    #Article.find_each do |article|
      #add article_path(article), changefreq: 'weekly', lastmod: (article.updated_at || article.created_at)
    #end
    
    User.where('last_sign_in_at IS NOT NULL').includes(:profile).each do |user|
      
        add profile_path(user.profile), changefreq: 'daily', lastmod: (user.profile.updated_at || user.profile.created_at)
        
    end

    Photo.all.each do |photo|
      
        add direct_photo_path(photo.hashed), changefreq: 'daily', lastmod: (photo.updated_at || photo.created_at)
        
    end
    
  end

  #SitemapGenerator::Sitemap.ping_search_engines