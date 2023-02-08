class JobPostsController < ApplicationController

    def show
        @job_post = JobPost.find(params[:id])
        @company = Company.find(@job_post.company_id)
    end

    def index
        @job_posts = JobPost.all

    end



end