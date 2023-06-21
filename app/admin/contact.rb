ActiveAdmin.register Contact, :as => 'Contact_Form' do
    
    menu :priority => 15
    before_filter { @skip_sidebar = true }

end