class SupplyChainController < ApplicationController
    # This is the main api endpoint of our app for get requests...    
    def test 
        p "API request for supply chain!"
        shops = Shop.all
        render json: {status: 'SUCCESS', message: 'Loaded all shops', data: shops}, status: :ok
    end 

    def all_shops
        p "Requesting all shops"
         shops = Shop.all
        render json: {status: 'SUCCESS', message: 'Loaded all shops', data: shops}, status: :ok
    end 
end
