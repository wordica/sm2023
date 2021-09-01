class AdminMessageJob < Struct.new(:admin_message_id)
  
  def perform

    @admin_message = AdminMessage.find(admin_message_id)

    users = User.select("users.id, users.name, users.email, users.authentication_token, settings.message_1").joins(:profile, :setting).joins("LEFT JOIN assets ON users.id = assets.user_id AND assets.avatar = 1")
    users = users.where("users.confirmed_at IS NOT NULL")
    users = users.where("users.name = ?", @admin_message.filters[:login]) if @admin_message.filters[:login].present?
    
    if @admin_message.filters[:login].blank?

      users = users.where("profiles.term_gender_id = ?", @admin_message.filters[:term_gender_id].to_i) if @admin_message.filters[:term_gender_id].present?
      users = users.where("profiles.birthdate >= ?", Profile.age_to_date(@admin_message.filters[:age_maximum].to_i + 1) + 1) if @admin_message.filters[:age_maximum].present?
      users = users.where("profiles.birthdate <= ?", Profile.age_to_date(@admin_message.filters[:age_minimum].to_i)) if @admin_message.filters[:age_minimum].present?
      users = users.where("profiles.state_id IN(?)", @admin_message.filters[:state_id]) if @admin_message.filters[:state_id].present?
      users = users.where("profiles.country_id IN(?)", @admin_message.filters[:country_id]) if @admin_message.filters[:country_id].present?
      users = users.where("assets.avatar = ?", true) if @admin_message.filters[:has_photo].present?
      users = users.where("assets.avatar IS NULL") if @admin_message.filters[:has_no_photo].present?
      users = users.where("(users.premium_at IS NULL AND users.vip_at IS NULL) OR (users.premium_at <= ? AND users.vip_at <= ?)", DateTime.now, DateTime.now) if @admin_message.filters[:account_id].present? && @admin_message.filters[:account_id].to_i == 1
      users = users.where("users.premium_at >= ?", DateTime.now) if @admin_message.filters[:account_id].present? && @admin_message.filters[:account_id].to_i == 2
      users = users.where("users.vip_at >= ?", DateTime.now) if @admin_message.filters[:account_id].present? && @admin_message.filters[:account_id].to_i == 3
      users = users.where("users.last_sign_in_at >= ?", @admin_message.filters[:logged_minimum] + " 00:00:00") if @admin_message.filters[:logged_minimum].present?
      users = users.where("users.last_sign_in_at <= ?", @admin_message.filters[:logged_maximum] + " 23:59:59") if @admin_message.filters[:logged_maximum].present?
    end

    users.each do |user|

      ActiveRecord::Base.transaction do

        # Save message
        @message = Message.new(:sender_id => @admin_message.user_id, :content => @admin_message.content, :category => 1)
        @message.user_id = user.id
        @message.save

        # Save visit
        @visit = Visit.find_or_initialize_by_user_id_and_visitor_id(user.id, @admin_message.user_id)
        @visit.update_attributes(:user_id => user.id, :visitor_id => @admin_message.user_id, :read => false)

      end

      if user.message_1

        admin_mailing_send = AdminMailingSend.new(
          
          :user_id => user.id,
          :name => user.name,
          :email => user.email,
          :authentication_token => user.authentication_token,
          :sender_id => @admin_message.user_id,
          :template => "message_notification"
        )

        admin_mailing_send.save
      end

    end

  end

  def success(job)

    Rails.logger.info "Admin message id = #{@admin_message.id} sent"
    @admin_message.update(:sent, true)

  end

  def error(job, exception)

    Rails.logger.error "Job failed #{exception}"

  end

end
