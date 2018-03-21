class SupplyChain < ActiveRecord::Base
	has_and_belongs_to_many :suppliers
	has_many :supplier_connections
end
