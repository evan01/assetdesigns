class SupplyChainController < ApplicationController
    PER_PAGE = 10

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

    def suppliers
        p "Requesting suppliers"
        page_number = params[:page] ? params[:page].to_i : 1
        supplier_offset = PER_PAGE * (page_number - 1)
        @suppliers      = Supplier.limit(PER_PAGE).offset(supplier_offset)
        @next_page  = page_number + 1 if @suppliers.count == PER_PAGE
    end
end
