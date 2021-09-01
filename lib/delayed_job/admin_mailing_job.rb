class AdminMailingJob < Struct.new(:admin_mailing_id)

  def perform
    @admin_mailing = AdminMailing.find(admin_mailing_id)

    users = AdvMailing.select(:email)
   
    
    users.each do |user|
     
      
      admin_mailing_send = AdminMailingSend.new(
       
        :email => user.email,
        :sender_email => @admin_mailing.send("sender_1"),
        :subject => @admin_mailing.send("subject_1"),
        :template => "adv_mailing"
      )
      
      if admin_mailing_send.save
        #Rails.logger.fatal "duap"
      else
        #Rails.logger.fatal "czemu kurwa mac"
      end

    end

  end

  def success(job)

    #Rails.logger.info "Admin mailing id = #{@admin_mailing.id} sent"
    @admin_mailing.update(:sent => true)

  end

  def error(job, exception)

    Rails.logger.error "Job failed #{exception}"

  end
  
end
