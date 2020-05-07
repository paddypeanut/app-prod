class User < ApplicationRecord

	has_secure_password
	has_many :customers
	has_many :consignments
end
