class Trelloteam < ApplicationRecord
	belongs_to :trellobot

	has_many :trellosubscriptions, dependent: :destroy
	has_many :jobs, through: :trellosubscriptions

end