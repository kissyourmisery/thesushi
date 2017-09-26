class EmployeesController < ApplicationController

	def index
		if !current_user.nil?

			@employees = current_user.employees
		else
			redirect_to sign_in_path
		end
	end

	def new
		@employee = Employee.new
	end

	def create
		@employee = current_user.employees.create(employee_params)

		if @employee.job.slacksubscriptions != nil
			slack_invitation(@employee)
		end

		if @employee.job.trellosubscriptions != nil
			trello_invitation(@employee)
		end

		if @employee.job.googlesubscriptions != nil
			gdrive_invitation(@employee)
		end


			# invitator = SlackInvitation::Invitator.new
 	 #    invitator.config(current_user.slack_domain, current_user.email, current_user.slack_password)
 
 	 #    # Invite method returns true or false
 	 #    invitator.start
 	 #    invitator.invite(@employee.email) 
 	 #    invitator.quit
			redirect_to employees_path

	end

	def show
		@employee = Employee.find(params[:id])
	end

	private
	def employee_params
		params.require(:employee).permit(:name, :email, :job_id)
	end

	def slack_invitation(employee)
		bot_array = [] # stores authenticity token of each bot 
		employee.job.slacksubscriptions.each do |sub|
			token = sub.slackchannel.slackbot.authenticity_token
			bot_array << token
		end
		bot_array = bot_array.uniq
		
		bot_array.each do |bot|			
			channel_array = []
			Slackbot.find_by(authenticity_token: bot, user_id: current_user.id).slackchannels.each do |channel|
				if Slacksubscription.find_by(slackchannel_id: channel.id, job_id: employee.job.id) != nil
					channel_array << channel.slack_id
					@slack_id = channel_array.join(',')			
				end		
			end
			slack_invite = HTTParty.post "https://slack.com/api/users.admin.invite?token=#{bot}&email=#{employee.email}&channels=#{@slack_id}"	
		end
	end

	def trello_invitation(employee)
		bot_array = [] # stores authenticity token of each bot 
		employee.job.trellosubscriptions.each do |sub|
			token = sub.trelloteam.trellobot.authenticity_token
			bot_array << token
		end
		bot_array = bot_array.uniq

		bot_array.each do |bot|
			Trellobot.find_by(authenticity_token: bot, user_id: current_user.id).trelloteams.each do |team|
				if Trellosubscription.find_by(trelloteam_id: team.id, job_id: employee.job.id) != nil
					@auth_token = bot
					@auth_key = Trellobot.find_by(authenticity_token: bot, user_id: current_user.id).authenticity_key
					@team_id = team.trello_id
					trello_invite = HTTParty.put "https://api.trello.com/1/organizations/#{@team_id}/members?key=#{@auth_key}&token=#{@auth_token}&email=#{employee.email}&fullName=#{employee.name}"
				end
			end			
		end
	end

	def gdrive_invitation(employee)
		bot_array = [] # stores refresh token of each bot 
		employee.job.googlesubscriptions.each do |sub|
			refresh_token = sub.gfolder.google_oauth.refresh_token
			bot_array << refresh_token
		end
		bot_array = bot_array.uniq

		bot_array.each do |bot|
			credentials = Google::Auth::UserRefreshCredentials.new(
			 client_id: ENV['GOOGLE_CLIENT_ID'],
			 client_secret: ENV['GOOGLE_CLIENT_SECRET'],
			 scope: [
			   "https://www.googleapis.com/auth/drive",
			   "https://spreadsheets.google.com/feeds/"
			 ])
			# don't need the redirect url anymore since we are restoring a session 
			credentials.refresh_token = bot
			credentials.fetch_access_token!
			session = GoogleDrive::Session.from_credentials(credentials)
			byebug
			 
			GoogleOauth.find_by(user_id: current_user.id, refresh_token: bot).gfolders.each do |folder|
				if Googlesubscription.find_by(job_id: employee.job.id, gfolder_id: folder.id) != nil					
					session.files.each do |file|
						if file.id == folder.google_id
							file.acl.push({type:"user", email_address: employee.email, role: "writer"})
						end
					end
				end
			end
		end
	end
end
