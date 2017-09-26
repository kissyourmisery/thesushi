class Slackchannel < ApplicationRecord
	belongs_to :slackbot

	has_many :slacksubscriptions, dependent: :destroy
	has_many :jobs, through: :slacksubscriptions

end
