namespace :adv_mailing do
  
    namespace :remove do
  
     
      task :remove_email => :environment do

        unsub = Unsubscribe.all

        unsub.each do |f|

           token = f.token
           email = f.email

           adv_mail = AdvMailing.where('email =? and token =?',email,token).first
           
           if adv_mail.present?

             adv_mail.delete

           end

           f.delete

        end

      end

    end


end