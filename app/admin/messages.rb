ActiveAdmin.register Message, :as => 'Messages' do
    
    before_filter { @skip_sidebar = true }

end