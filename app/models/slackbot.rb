class Slackbot < ApplicationRecord

	belongs_to :user
	belongs_to :service
	has_many :slackchannels, dependent: :destroy
	
end
