namespace :photoclicker do
  
  namespace :mailing do

    desc "Send mailing"
    task :send => :environment do

      email_limit = 120 # all emails limit
      domain_limit_count = 80 # popular domain limit

      # get all records
      mailing_count = AdminMailingSend.count

      next unless mailing_count > 0

      # get most popular domains
      mailing_domains = AdminMailingSend.find_by_sql("SELECT SUBSTR( email, INSTR( email,  '@' ) +1 ) AS domain, COUNT(*) as count_all , CEIL( COUNT(*) / #{mailing_count} * #{email_limit}) as count_mail FROM admin_mailing_sends GROUP BY domain HAVING count_all > #{domain_limit_count} ORDER BY count_all DESC")

      # get domains
      popular_mailing_domains = mailing_domains.collect { |m| m.domain }

      # get all emails form popular domains
      popular_mailing_count = mailing_domains.inject(0) { |sum,x| sum + x.count_mail }

      # user mailing
      users_mailings = []

      # get emails from non popular domains
      if popular_mailing_count < email_limit

        users_mailings = AdminMailingSend.order(:email).limit(email_limit - popular_mailing_count)
        users_mailings.where("SUBSTRING_INDEX( admin_mailing_sends.email, '@', -1) NOT IN (?)", popular_mailing_domains) if popular_mailing_domains.present?
        users_mailing_ids = users_mailings.collect{ |u| u.id }

      end

      # get mails from popular domains
      mailing_domains.each do |mailing_domain|

        users_mailing_popular = AdminMailingSend.where("SUBSTRING_INDEX( admin_mailing_sends.email, '@', -1) = ?", mailing_domain.domain).limit(mailing_domain.count_mail)
        users_mailing_popular.where("id NOT IN (?)", users_mailing_ids) if users_mailing_ids.present?

        users_mailings += users_mailing_popular

      end

      # randomize emails so the same domain is not one after another
      users_mailings = users_mailings.shuffle

      users_mailings.each do |user_mailing|

        #if user_mailing.user.blank?
        #  user_mailing.destroy
        #  next
        #end

        if user_mailing.template == 'message_notification'

          sender = User.find(user_mailing.sender_id)
          ApplicationMailer.message_notification(user_mailing.user, sender).deliver

        end
        if user_mailing.template == 'adv_mailing'

          ApplicationMailer.admin_mailing_start(user_mailing).deliver

        end
        if user_mailing.template == 'mailing_to_user'

          ApplicationMailer.mailing_to_user(user_mailing).deliver

        end

        user_mailing.destroy

      end

    end

  end
  
end
