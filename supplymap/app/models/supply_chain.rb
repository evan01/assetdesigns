class SupplyChain < ActiveRecord::Base
	has_and_belongs_to_many :suppliers
	has_many :supplier_connections
	
	# Method that calculates the total emissions of the full supply chain
	def total_co2_emission
		# Get all the suppliers present in the supply chain
		@suppliers = Supplier.where(supply_chain_id: self.id)
		
		# Get all the connections in the supply chain (must go through suppliers since no direct reference between
		# supply_chain and supplier_connnectioni)

		@all_connections = SupplierConnection.all
		@supply_chain_connections = []
		@all_connections.each do |c|
			if (@suppliers.include?(Supplier.find(c.supplier_a_id)) && @suppliers.include?(Supplier.find(c.supplier_b_id)))
				@supply_chain_connections.push(c)
			end
		end

		# Remove duplicates
		@supply_chain_connections.uniq

		@total_co2 = 0
		@supply_chain_connections.each do |c|
			@total_co2 += c.co2_emission
		end

		@total_co2
	end
end
