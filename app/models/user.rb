class User < ActiveRecord::Base
  include Clearance::User

  has_many :google_oauths, dependent: :destroy

  has_many :employees, dependent: :destroy
  has_many :slackbots, dependent: :destroy 
  has_many :jobs, dependent: :destroy
  has_many :trellobots, dependent: :destroy

  has_many :servicesubscriptions, dependent: :destroy
	has_many :services, through: :servicesubscriptions


end
