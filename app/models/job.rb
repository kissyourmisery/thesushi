class Job < ApplicationRecord

	belongs_to :user
	has_many :employees
	
	has_many :slacksubscriptions, dependent: :destroy
	has_many :slackchannels, through: :slacksubscriptions

	has_many :trellosubscriptions, dependent: :destroy
	has_many :trelloteams, through: :trellosubscriptions

	has_many :googlesubscriptions, dependent: :destroy
	has_many :gfolders, through: :googlesubscriptions
	
end