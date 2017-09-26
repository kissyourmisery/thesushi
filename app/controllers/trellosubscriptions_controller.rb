class TrellosubscriptionsController < ApplicationController

	def new
		@job = Job.find(params[:job_id])
		@trellosub = Trellosubscription.new
	end

	def create
		@trellosub = Trellosubscription.create(trellosub_params)
		redirect_to new_job_trellosubscription_path(job_id: @trellosub.job_id)
	end

	private
	def trellosub_params
		params.require(:trellosubscription).permit(:job_id, :trelloteam_id)
	end


end