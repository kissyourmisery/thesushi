class Service < ApplicationRecord

	has_many :slackbots, dependent: :destroy

	has_many :servicesubscriptions, dependent: :destroy
	has_many :users, through: :servicesubscriptions
	
	has_many :trellobots, dependent: :destroy

	has_many :google_oauths, dependent: :destroy
end
