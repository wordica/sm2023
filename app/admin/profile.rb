ActiveAdmin.register Profile, :as => 'Profiles' do
    
    menu :priority => 5
    before_filter { @skip_sidebar = true }
    

end