class JobsController < ApplicationController


	def new
		@job = Job.new
	end

	def create
		@job = Job.create(job_params)
		redirect_to job_path(@job)
	end

	def show
		@job = Job.find(params[:id])
		@services = current_user.services
	end

	private
	def job_params
		params.require(:job).permit(:position, :user_id)
	end

end