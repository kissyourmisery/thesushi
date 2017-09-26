class Trellosubscription < ApplicationRecord

	belongs_to :trelloteam
	belongs_to :job
	
end