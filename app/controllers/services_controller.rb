class ServicesController < ApplicationController


	def index
		@services = Service.where(supported?: 1)
		@slackbot_count = current_user.slackbots.count
		@trellobot_count = current_user.trellobots.count
		@google_oauth_count = current_user.google_oauths.count
	end




# 	def create
# 		@slackbot = current_user.slackbots.new(bot_params)

# 	end

# 	private
# 	def employee_params
# 		params.require(:slackbot).permit(:authenticity_token, :service_id, :user_id)
# 	end

end