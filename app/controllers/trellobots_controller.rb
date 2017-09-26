class TrellobotsController < ApplicationController

	def new
		@trellobot = Trellobot.new
	end

	def create
		if Servicesubscription.find_by(user_id: current_user.id, service_id: Service.find_by(name:"Trello").id) == nil
			Servicesubscription.create(user_id: current_user.id, service_id: Service.find_by(name:"Trello").id)
		end
		@trellobot = current_user.trellobots.create(trellobot_params)

		user_info = HTTParty.get "https://api.trello.com/1/members/#{@trellobot.username}?fields=username,fullName,url&boards=all&board_fields=name&organizations=all&organization_fields=displayName&key=#{@trellobot.authenticity_key}&token=#{@trellobot.authenticity_token}"



		user_info["organizations"].each do |org|
			@trellobot.trelloteams.create(trello_id: org["id"], name: org["displayName"])
		end
		redirect_to services_path
	end

	private
	def trellobot_params
		params.require(:trellobot).permit(:authenticity_token, :authenticity_key, :service_id, :username)
	end

end

# user_info = HTTParty.get "https://api.trello.com/1/members/chengyinxu/boards?key=02555771890dc845264c54f1202c04cb&token=21dc67a9140f2db8800e0e64001a7746975f79962d14705a92504113f9b75675"