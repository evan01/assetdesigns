class MapController < ApplicationController

    def supply_map
        p 'requested the supply map'
        render :map, content_type: 'application/liquid'
        # render :map
    end
end
