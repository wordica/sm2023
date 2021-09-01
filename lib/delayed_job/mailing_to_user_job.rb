class MailingToUserJob < Struct.new(:mailing_to_user_id)

  def perform

    @mailing_to_user = MailingToUser.find(mailing_to_user_id)

    users = User.select("users.email")
   
    #users = users.where("users.confirmed_at IS NOT NULL")

    users = users.where("users.blocked = ?",false)
    users = users.where("users.name = ?", @mailing_to_user.filters[:login]) if @mailing_to_user.filters[:login].present?
    users = users.where("users.current_sign_in_at >= ?", @mailing_to_user.filters[:logged_minimum] + " 00:00:00") if @mailing_to_user.filters[:logged_minimum].present?
    users = users.where("users.current_sign_in_at <= ?", @mailing_to_user.filters[:logged_maximum] + " 23:59:59") if @mailing_to_user.filters[:logged_maximum].present?
    
    users.each do |user|

      admin_mailing_send = AdminMailingSend.new(
       
        :email => user.email,
        :sender_email => @mailing_to_user.send("sender_1"),
        :subject => @mailing_to_user.send("subject_1"),
        :template => "mailing_to_user"
      )
      admin_mailing_send.save

    end

  end

  def success(job)

    Rails.logger.info "mailing_to_user id = #{@mailing_to_user.id} sent"
    @mailing_to_user.update_attribute(:sent, true)

  end

  def error(job, exception)

    Rails.logger.error "Job failed #{exception}"

  end
  
end
