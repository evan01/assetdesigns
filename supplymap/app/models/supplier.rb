class Supplier < ActiveRecord::Base
	validates :name, presence: true
	validates :type, presence: true
	validates :lattitude, presence: true
	validates :longitude, presence: true
end
