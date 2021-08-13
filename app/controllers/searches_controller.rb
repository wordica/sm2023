class SearchesController < ApplicationController




    def new 


    end


    def create



    end










     # Only allow a list of trusted parameters through.
     def search_params
        params.require(:search).permit(:author, :keyword)
      end


end
