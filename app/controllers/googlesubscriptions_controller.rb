class GooglesubscriptionsController < ApplicationController


	def new
		@job = Job.find(params[:job_id])
		@googlesub = Googlesubscription.new
	end

	def create
		@googlesub = Googlesubscription.create(googlesub_params)
		redirect_to new_job_googlesubscription_path(job_id: @googlesub.job_id)
	end

	private
	def googlesub_params
		params.require(:googlesubscription).permit(:job_id, :gfolder_id)
	end

end