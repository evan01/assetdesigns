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
        @supplier = Supplier.find(params[:id])
    end

    # New supplier and create
    def new
        @supplier = Supplier.new
    end

    def create
        @supplier = Supplier.new supplier_params

        if @supplier.save
            flash[:success] = "Added Supplier"
            redirect_to supplier_path(@supplier)
        else
            render :new
        end
    end

    # Edit and update supplier
    def edit
        @supplier = Supplier.find params[:id]
    end

    def update
        @supplier = Supplier.find(params[:id])

        if @supplier.update supplier_params
            flash[:success] = "Updated Supplier"
            redirect_to supplier_path(@supplier)
        else
            render :edit
        end
    end

    # Delete supplier
    def destroy
        @supplier = Supplier.find params[:id]
        @supplier.destroy
        redirect_to suppliers_path
    end

    private

    def supplier_params
        params.require(:supplier).permit(:name, :product_kind, :description, :lattitude, :longitude)
    end
end