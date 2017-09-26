class SlackbotsController < ApplicationController


	def new
		@slackbot = Slackbot.new
	end

	def create
		if Servicesubscription.find_by(user_id: current_user.id, service_id: Service.find_by(name:"Slack").id) == nil
			Servicesubscription.create(user_id: current_user.id, service_id: Service.find_by(name:"Slack").id)
		end

		@slackbot = current_user.slackbots.create(slackbot_params)

		team_response = HTTParty.post "https://slack.com/api/team.info?token=#{@slackbot.authenticity_token}"
		name = team_response["team"]["name"]
		@slackbot.update(name: name)


		channel_response = HTTParty.post "http://slack.com/api/channels.list?token=#{@slackbot.authenticity_token}"
		channel_response["channels"].each do |channel|
			@slackbot.slackchannels.create(public?: 1, name: channel["name"], slack_id: channel["id"])
		end

		group_response = HTTParty.post "https://slack.com/api/groups.list?token=#{@slackbot.authenticity_token}"
		group_response["groups"].each do |channel|
			@slackbot.slackchannels.create(public?: 0, name: channel["name"], slack_id: channel["id"])
		end
		redirect_to services_path
	end

	private
	def slackbot_params
		params.require(:slackbot).permit(:authenticity_token, :service_id)
	end

end




