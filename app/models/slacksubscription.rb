class Slacksubscription < ApplicationRecord

	belongs_to :slackchannel
	belongs_to :job
	
end