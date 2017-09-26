class GoogleOauth < ActiveRecord::Base
	belongs_to :user
	belongs_to :service
	has_many :gfolders, dependent: :destroy
	

end