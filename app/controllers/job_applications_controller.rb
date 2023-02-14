class JobApplicationsController <  ApplicationController


    

    def index
        if current_user
            @job_application = current_user.job_applications
        end
    end



    def create
        byebug
        @job_application=JobApplication.new(params.require(:id))
        @job_application.user_id=current_user.id 
        @job_application.job_post_id=params[:id]
    end

end