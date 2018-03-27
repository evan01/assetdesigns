class SupplyChain < ActiveRecord::Base
	has_and_belongs_to_many :suppliers
	has_many :supplier_connections
	
	# Method that calculates the total emissions of all the connections in the supply chain
	def getTotalCO2Emissions
		# Get all the connections in the supply chain
		supply_chain_connections = SupplierConnection.where(supply_chain_id: self.id)
		
		# Add up all co2 emissions
		total_co2 = 0
		supply_chain_connections.each do |c|
			total_co2 += c.co2_emission
		end

		# Return the total co2 emissions
		total_co2
	end

	# Method that calculates the total distance of all the connections in the supply chain
	def getTotalDistance
		# Get all the connections in the supply chain
		supply_chain_connections = SupplierConnection.where(supply_chain_id: self.id)
		
		# Add up all distances
		total_distance = 0
		supply_chain_connections.each do |c|
			total_distance += c.distance
		end

		# Return the total distance
		total_distance
	end

	# Method to get the origin of the supply chain
	# Note: this assumed that the connections belonging to this supply chain are "linked" in the sense that the supplier_b of one 
	# of the connection corresponds to the supplier_a of another connection (unless they are the first or last connection). 
	# In theory that should be the case. If not, the method returns the supplier_a of the first connection belonging to this supply chain
	def getOriginSupplier
		# Get all the connections in the supply chain
		supply_chain_connections = SupplierConnection.where(supply_chain_id: self.id)
	
		# Algorithm to find the origin supplier: Set the parent_connection to a random connection (in this case the first one, it 
		# doesn't matter). While there exists a connection whose supplier_b_id corresponds to the parent_connection's supplier_a_id 
		# (i.e.: there exists a connection upstream of the parent_connection), set the origin_connection to the parent_connection
		# and find the next parent connection (if it exists). Note that "parent" means "closer to the start of the suply chain".
		parent_connection = supply_chain_connections[0]
		origin_correction = nil
		while (parent_connection != nil) do
			origin_connection = parent_connection
			parent_connection = supply_chain_connections.find_by supplier_b_id: origin_connection.supplier_a_id
		end
	
		# Get and return origin supplier
		if (origin_connection != nil)
			origin_supplier = Supplier.find(origin_connection.supplier_a_id)
			origin_supplier.name
		else
			""
		end
	end

	# Method to get the final point of the supply chain
	# Note: this assumed that the connections belonging to this supply chain are "linked" in the sense that the supplier_b of one 
	# of the connection corresponds to the supplier_a of another connection (unless they are the first or last connection). 
	# In theory that should be the case. If not, the method returns the supplier_a of the first connection belonging to this supply chain
	def getFinalSupplier
		# Get all the connections in the supply chain
		supply_chain_connections = SupplierConnection.where(supply_chain_id: self.id)
	
		# Algorithm to find the final supplier: Set the child_connection to a random connection (in this case the first one, it 
		# doesn't matter). While there exists a connection whose supplier_a_id corresponds to the child_connection's supplier_b_id 
		# (i.e.: there exists a connection downstream of the child_connection), set the final_connection to the child_connection
		# and find the next child_connection (if it exists). Note that "child" means "closer to the end of the suply chain".
		child_connection = supply_chain_connections[0]
		final_correction = nil
		while (child_connection != nil) do
			final_connection = child_connection
			child_connection = supply_chain_connections.find_by supplier_a_id: final_connection.supplier_b_id
		end
	
		# Get and return origin supplier
		if (final_connection != nil)
			final_supplier = Supplier.find(final_connection.supplier_b_id)
			final_supplier.name
		else
			""
		end

	end
end
