require 'googleauth'

class GoogleOauthsController < ApplicationController
  def create
  	# auth_hash = request.env['omniauth.auth']
  	# authentication = GoogleAuth.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])
  	# authentication ||= GoogleAuth.create_with_omniauth(auth_hash)

  	# if authentication.user
  	# 	authentication.update_token(auth_hash)
  	# else
	  # 	current_user.google_auth = authentication
  	# end

  	# redirect_to root_url
  end

  def new
  	@oauth = GoogleOauth.new
  end

  def get_drive_files
  	# session = GoogleDrive::Session.from_access_token(current_user.google_auth.access_token)

  	credentials = Google::Auth::UserRefreshCredentials.new(
  		client_id: ENV['GOOGLE_CLIENT_ID'],
  		client_secret: ENV['GOOGLE_CLIENT_SECRET'],
  		 # client id and client secret belongs to me, not the user!
  		scope: [
  			"https://www.googleapis.com/auth/drive",
  			"https://spreadsheets.google.com/feeds/"
  		], # to specify what scope the API can do for the user to authorize
  		redirect_uri: "http://localhost:3000/gdrive_files/callback",
  		state: params[:google_oauth][:username]
  	) # this is the url to redirect to after user has authorized from the link below

  	auth_url = credentials.authorization_uri
  	
  	redirect_to "https://accounts.google.com/" + auth_url.request_uri
	  #   auth = Signet::OAuth2::Client.new(
	  #     token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
	  #     client_id:            ENV['GOOGLE_CLIENT_ID'],
	  #     client_secret:        ENV['GOOGLE_CLIENT_SECRET'],
	  #     refresh_token:        current_user.google_auth.refresh_token # Get this from the omniauth strategy. 
	  #   )
	  #   auth.fetch_access_token!
	  #   x = Google::Apis::DriveV2
	  #   drive = x::DriveService.new
	  #   drive.authorization = auth
		# files = drive.list_files.map do |file|
		# 	[file.title, file.id]
		# end
  end

  def get_drive_files_callback
  	credentials = Google::Auth::UserRefreshCredentials.new(
  		client_id: ENV['GOOGLE_CLIENT_ID'],
  		client_secret: ENV['GOOGLE_CLIENT_SECRET'],
  		scope: [
  			"https://www.googleapis.com/auth/drive",
  			"https://spreadsheets.google.com/feeds/"
  		],
  		redirect_uri: "http://localhost:3000/gdrive_files/callback"
  	)
  	credentials.code = params[:code] # what is this line?
  	credentials.fetch_access_token!

  	

  	if credentials.refresh_token != nil

  		if Servicesubscription.find_by(user_id: current_user.id, service_id: Service.find_by(name:"Gdrive").id) == nil
			Servicesubscription.create(user_id: current_user.id, service_id: Service.find_by(name:"Gdrive").id)
			end

  		@bot = GoogleOauth.create(user_id: current_user.id, service_id: Service.find_by(name:"Gdrive").id, username: params[:state], refresh_token: credentials.refresh_token)


  		session = GoogleDrive::Session.from_credentials(credentials)

  		session.files.each do |file|
  			if file.mime_type == "application/vnd.google-apps.folder"
  				Gfolder.create(google_oauth_id: @bot.id, name: file.title, google_id: file.id)
  			end
  		end
  	end 

  	#print error message later on to say the user already registered with this google account!
  	
  	# this method doesn't require API key anymore! 



  	redirect_to services_path
  end

  private
  def google_oauth_params
		params.require(:google_oauth).permit(:username, :service_id)
	end
end
