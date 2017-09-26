class SlacksubscriptionsController < ApplicationController


	def new
		@job = Job.find(params[:job_id])
		@slacksub = Slacksubscription.new
	end

	def create
		@slacksub = Slacksubscription.create(slacksub_params)
		redirect_to new_job_slacksubscription_path(job_id: @slacksub.job_id)
	end

	private
	def slacksub_params
		params.require(:slacksubscription).permit(:job_id, :slackchannel_id)
	end

end


