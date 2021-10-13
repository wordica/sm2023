ActiveAdmin.register Profile, :as => 'Profiles' do
    
    menu :priority => 6
    before_filter { @skip_sidebar = true }
    

end