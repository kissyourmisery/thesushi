class Gfolder < ApplicationRecord
	belongs_to :google_oauth

	has_many :googlesubscriptions, dependent: :destroy
	has_many :jobs, through: :googlesubscriptions

end