class SupplierConnection < ActiveRecord::Base
	belongs_to :supplier_a, :class_name => :Supplier
	belongs_to :supplier_b, :class_name => :Supplier
	belongs_to :supply_chains
end