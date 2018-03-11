class SupplierConnectionsController < ApplicationController
	PER_PAGE = 10

	def index
		 p "Requesting supplier connections"
        page_number = params[:page] ? params[:page].to_i : 1
        sup_connection_offset = PER_PAGE * (page_number - 1)
        @supplierconnections = SupplierConnection.all
        @next_page = page_number + 1 if @supplierconnections.count == PER_PAGE
    end

     # Show supplier connection
    def show
        @supplierconnection = SupplierConnection.find(params[:id])
        @suppliera = Supplier.find(@supplierconnection.supplier_a_id)
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

    # New supplier connection and create
    def new
        @supplierconnection = SupplierConnection.new
    end

    def create
        @supplierconnection = SupplierConnection.new supplier_connection_params

        if @supplierconnection.save
            flash[:success] = "Added Supplier Connection"
            redirect_to supplier_connection_path(@supplierconnection)
        else
            render :new
        end
    end

    # Edit and update supplier connection
    def edit
        @supplierconnection = SupplierConnection.find params[:id]
    end

    def update
        @supplierconnection = SupplierConnection.find(params[:id])

        if @supplierconnection.update supplier_connection_params
            flash[:success] = "Updated Supplier Connection"
            redirect_to supplier_connection_path(@supplierconnection)
        else
            render :edit
        end
    end

    # Delete supplier connection
    def destroy
        @supplierconnection = SupplierConnection.find params[:id]
        @supplierconnection.destroy
        redirect_to supplier_connections_path
    end

    private

    def supplier_connection_params
        params.require(:supplier_connection).permit(:supplier_a_id, :supplier_b_id, :co2_emission, :distance)
    end

end