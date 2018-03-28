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
	def getFirstSupplier
		# Get and return origin supplier
		first_connection = self.getFirstConnection
		if (first_connection != nil)
			first_supplier = Supplier.find(first_connection.supplier_a_id)
			first_supplier.name
		else
			""
		end
	end

	def getFirstConnection
		# Get all the connections in the supply chain
		supply_chain_connections = SupplierConnection.where(supply_chain_id: self.id)
	
		# Algorithm to find the first connection: Set the parent_connection to a random connection (in this case the first one, it 
		# doesn't matter). While there exists a connection whose supplier_b_id corresponds to the parent_connection's supplier_a_id 
		# (i.e.: there exists a connection upstream of the parent_connection), set the first_connection to the parent_connection
		# and find the next parent connection (if it exists). Note that "parent" means "closer to the start of the suply chain".
		parent_connection = supply_chain_connections[0]
		first_correction = nil
		while (parent_connection != nil) do
			first_connection = parent_connection
			parent_connection = supply_chain_connections.find_by supplier_b_id: first_connection.supplier_a_id
		end
		
		# Return last connection
		first_correction
	end

	# Method to get the last point of the supply chain
	# Note: this assumed that the connections belonging to this supply chain are "linked" in the sense that the supplier_b of one 
	# of the connection corresponds to the supplier_a of another connection (unless they are the first or last connection). 
	# In theory that should be the case. If not, the method returns the supplier_a of the first connection belonging to this supply chain
	def getLastSupplier
		# Get and return origin supplier
		last_connection = self.getLastConnection
		if (last_connection != nil)
			last_supplier = Supplier.find(last_connection.supplier_b_id)
			last_supplier.name
		else
			""
		end
	end

	def getLastConnection
		# Get all the connections in the supply chain
		supply_chain_connections = SupplierConnection.where(supply_chain_id: self.id)
	
		# Algorithm to find the last connection: Set the child_connection to a random connection (in this case the first one, it 
		# doesn't matter). While there exists a connection whose supplier_a_id corresponds to the child_connection's supplier_b_id 
		# (i.e.: there exists a connection downstream of the child_connection), set the last_connection to the child_connection
		# and find the next child_connection (if it exists). Note that "child" means "closer to the end of the suply chain".
		child_connection = supply_chain_connections[0]
		last_correction = nil
		while (child_connection != nil) do
			last_connection = child_connection
			child_connection = supply_chain_connections.find_by supplier_a_id: last_connection.supplier_b_id
		end

		# Return last connection
		last_correction
	end
end
