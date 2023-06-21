class Unsubscribe < ApplicationRecord

    def freq_ask?

        @freq = Unsubscribe.where('created_at > ?', Time.now - rand(5..10).seconds).exists?
    
        if @freq
    
          return true
    
        else
    
          return false
    
        end
        
    end
    
end
