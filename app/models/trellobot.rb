class Trellobot < ApplicationRecord

	belongs_to :user
	belongs_to :service
	has_many :trelloteams, dependent: :destroy
	
end