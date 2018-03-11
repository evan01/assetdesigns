class SupplyChainsController < ApplicationController
    PER_PAGE = 10

    # Display list of suppliers (10 per page)
    def index
        p "Requesting supply chains"
        page_number = params[:page] ? params[:page].to_i : 1
        supplychain_offset = PER_PAGE * (page_number - 1)
        @supplychains = SupplyChain.all
        @next_page = page_number + 1 if @supplychains.count == PER_PAGE
    end

    # Show supplier
    def show
        @supplychain = SupplyChain.find(params[:id])
    end

    # New supplier and create
    def new
        @supplychain = SupplyChain.new
    end

    def create
        @supplychain = SupplyChain.new supplychain_params

        if @supplychain.save
            flash[:success] = "Added Supplier"
            redirect_to supply_chain_path(@supplychain)
        else
            render :new
        end
    end

    # Edit and update supplier
    def edit
        @supplychain = SupplyChain.find(params[:id])
    end

    def update
        @supplychain = SupplyChain.find(params[:id])

        if @supplychain.update supply_chain_params
            flash[:success] = "Updated Supplier"
            redirect_to supply_chain_path(@supplychain)
        else
            render :edit
        end
    end

    # Delete supplier
    def destroy
        @supplychain = SupplyChain.find params[:id]
        @supplychain.destroy
        redirect_to supply_chains_path
    end

    private

    def supply_chain_params
        params.require(:supply_chain).permit(:name, :description)
    end
end