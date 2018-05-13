class SupplyChainsController < ApplicationController
  before_action :set_supply_chain, only: [:show, :edit, :update, :destroy]

  # GET /supply_chains
  # GET /supply_chains.json
  def index
    @supply_chains = SupplyChain.all
  end

  # GET /supply_chains/1
  # GET /supply_chains/1.json
  def show
  end

  # GET /supply_chains/new
  def new
    @supply_chain = SupplyChain.new
  end

  # GET /supply_chains/1/edit
  def edit
  end

  # POST /supply_chains
  # POST /supply_chains.json
  def create
    @supply_chain = SupplyChain.new(supply_chain_params)

    respond_to do |format|
      if @supply_chain.save
        format.html { redirect_to @supply_chain, notice: 'Supply chain was successfully created.' }
        format.json { render :show, status: :created, location: @supply_chain }
      else
        format.html { render :new }
        format.json { render json: @supply_chain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supply_chains/1
  # PATCH/PUT /supply_chains/1.json
  def update
    respond_to do |format|
      if @supply_chain.update(supply_chain_params)
        format.html { redirect_to @supply_chain, notice: 'Supply chain was successfully updated.' }
        format.json { render :show, status: :ok, location: @supply_chain }
      else
        format.html { render :edit }
        format.json { render json: @supply_chain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supply_chains/1
  # DELETE /supply_chains/1.json
  def destroy
    @supply_chain.destroy
    respond_to do |format|
      format.html { redirect_to supply_chains_url, notice: 'Supply chain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supply_chain
      @supply_chain = SupplyChain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supply_chain_params
      params.fetch(:supply_chain, {})
    end
end
