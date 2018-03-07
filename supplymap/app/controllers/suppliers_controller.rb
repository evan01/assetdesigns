class SuppliersController < ApplicationController
    PER_PAGE = 10

    # Display list of suppliers (10 per page)
    def index
        p "Requesting suppliers"
        page_number = params[:page] ? params[:page].to_i : 1
        supplier_offset = PER_PAGE * (page_number - 1)
        @suppliers = Supplier.all
        @next_page = page_number + 1 if @suppliers.count == PER_PAGE
    end

    # Show supplier
    def show
        @supplier = Supplier.find params[:id]
    end

    # New supplier
    def new
        @supplier = Supplier.new
    end

    # Adding new suppliers
    def create
        @supplier = Supplier.new supplier_params

        if @supplier.save
            flash[:success] = "Added Supplier"
            redirect_to supplier_path(@supplier)
        else
            render :new
        end
    end

    private

    def supplier_params
        params.require(:supplier).permit(:name, :type, :description, :lattitude, :longitude)
    end
end