ActiveAdmin.register User, :as => 'Users' do
    
    menu :priority => 5


    filter :email
    filter :username
    filter :id

    member_action :block_ip, method: 'get' do

      user = User.find(params[:id])
      user.block_ip
      redirect_back fallback_location: admin_user_path and return
      
    end

    index do
    
      selectable_column
      column :score
      column :id
      column :username
      column :email
      column :confirmed_at
      column :current_sign_in_at
      column :sign_in_count
      column :current_sign_in_ip do |i|

        link_to( i.current_sign_in_ip,'https://whatismyipaddress.com/ip/' + i.current_sign_in_ip.to_s, target: "_blank" )

      end
     
      
      column :actions do |u|
        links = ''.html_safe
        links << link_to('edytuj', [:edit, :admin, u], :class => "member_link")
        links << link_to('usun', [:admin, u], :class => "member_link", :method => :delete, data: { confirm: 'na pewno?'})
        #links << link_to('usun_wyslij', [:delete_user_with_mail,:admin, u], :class => "member_link", :action => 'delete_user_with_mail', :confirm => 'na pewno?')
        links << link_to('IP BAN', [:block_ip,:admin,u], :action => 'block_ip', data: { confirm: 'na pewno?'}, :class => "member_link")
        links
      end
      
      column :photos do |u|
        links = ''.html_safe
        links << link_to(t("active_admin.view"), admin_photos_path(:q => { :user_id_eq => u.id }, :scope => :all), :class => "member_link")
        links
      end
      
      column :messages do |u|
        links = ''.html_safe
        links << link_to(t("active_admin.inbox"), admin_messages_path(:q => { :user_id_eq => u.id }), :class => "member_link")
        links
      end
      
      column :profile do |u|
        links = ''.html_safe
        links << link_to(t("active_admin.view"), [:admin, u.profile], :class => "member_link")
        #links << link_to(t("active_admin.edit"), [:edit, :admin, u.profile], :class => "member_link")
        links
      end

    end

    

end