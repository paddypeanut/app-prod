class Consignment < ApplicationRecord
	belongs_to :user
	belongs_to :customer , counter_cache: true
end
