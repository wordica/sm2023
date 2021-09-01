ActiveAdmin.register AdminMailing do
  
  before_filter { @skip_sidebar = true }
  menu :priority => 14
  form :partial => "form"
  
  permit_params :id, :sender_1, :subject_1, :sent, :filters, :created_at, :updated_at
  
  index do
    column :id
    column :sender_1
    column :subject_1
    column :sent
    column :created_at
    column :updated_at
    column :actions do |u|
      links = ''.html_safe
      links << link_to("wyslij", deliver_admin_admin_mailings_path(:id => u.id), :class => "member_link", :method => :post)
      links << link_to("zobacz", [:admin, u], :class => "member_link")
      links << link_to("usun", [:admin, u], :class => "member_link", :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'))
      links
    end
  end
  
  
  controller do
    def create
      @admin_mailing = AdminMailing.new(permitted_params[:admin_mailing])
      @admin_mailing.filters = permitted_params[:filters]
      @admin_mailing.save!
      redirect_back fallback_location: collection_path
    end
  end

  collection_action :deliver, :method => :post do
    Delayed::Job.enqueue(AdminMailingJob.new(params[:id]))
    redirect_back fallback_location: collection_path, :notice => I18n.t("views.mailer.delivering")
  end
  
  
  
  
end