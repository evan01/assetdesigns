class Supplier < ActiveRecord::Base
	has_many(:supplier_connections, :foreign_key => :supplier_a_id, :dependent => :destroy)
	has_many(:reverse_supplier_connections, :class_name => :SupplierConnection, :foreign_key => :supplier_b_id, :dependent => :destroy)
 	has_many :suppliers, :through => :supplier_connections, :source => :supplier_b
	has_attached_file :image
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	has_and_belongs_to_many :supply_chains
end
