class SupplyMapsController < ApplicationController
  before_action :set_supply_map, only: [:show, :edit, :update, :destroy]

  # GET /supply_maps
  # GET /supply_maps.json
  def index
    @supply_maps = SupplyMap.all
  end

  # GET /supply_maps/1
  # GET /supply_maps/1.json
  def show
  end

  # GET /supply_maps/new
  def new
    @supply_map = SupplyMap.new
  end

  # GET /supply_maps/1/edit
  def edit
  end

  # POST /supply_maps
  # POST /supply_maps.json
  def create
    @supply_map = SupplyMap.new(supply_map_params)

    respond_to do |format|
      if @supply_map.save
        format.html { redirect_to @supply_map, notice: 'Supply map was successfully created.' }
        format.json { render :show, status: :created, location: @supply_map }
      else
        format.html { render :new }
        format.json { render json: @supply_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supply_maps/1
  # PATCH/PUT /supply_maps/1.json
  def update
    respond_to do |format|
      if @supply_map.update(supply_map_params)
        format.html { redirect_to @supply_map, notice: 'Supply map was successfully updated.' }
        format.json { render :show, status: :ok, location: @supply_map }
      else
        format.html { render :edit }
        format.json { render json: @supply_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supply_maps/1
  # DELETE /supply_maps/1.json
  def destroy
    @supply_map.destroy
    respond_to do |format|
      format.html { redirect_to supply_maps_url, notice: 'Supply map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supply_map
      @supply_map = SupplyMap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supply_map_params
      params.require(:supply_map).permit(:name, :id)
    end
end
