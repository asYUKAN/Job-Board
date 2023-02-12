class JobPostsController < ApplicationController
    
    #before_action :authenticate!


    def new
    end

    def authenticate!
        if current_user || current_company
          a=1
        else
            redirect_to new_user_session_path
        end
      end

    def show
        @job_post = JobPost.find(params[:id])
        @company = Company.find(@job_post.company_id)
    end

    def create
        
        @job_post= JobPost.new(params.require(:job_post).permit(:title, :mode,  :apply_link, :job_type, :location, :description))
        @job_post.company_id = current_company.id
        @job_post.save
       
        redirect_to job_post_path(@job_post.id)
    end

    def index
        @job_posts = JobPost.all

    end



end