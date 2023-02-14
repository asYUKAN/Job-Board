class JobApplicationsController <  ApplicationController


    before_action :authenticate_user!, only: [:user_job_applications, :destroy]

    def user_job_applications
        if current_user
            @job_applications = current_user.job_applications.paginate(page: params[:page],per_page:5)
        end
    end


    def destroy
        @job_application=JobApplication.find(params[:id])
        if current_user && current_user.id == @job_application.user_id
            flash[:notice]="Your application has been droped successfully"
           @job_application.destroy 
           redirect_to job_applications_path
        else
            flash[:notice]="You can only drop your application"
            redirect_to cjob_applications_path
        end
    end


    def update
       
        @job_application= JobApplication.find(params[:id])

        if @job_application.update(params.require(:job_application).permit(:staus))
            flash[:notice]="Remarks sent successfully"
            redirect_to company_posts_path
        
        end

    end



    def create
        
        @job_application=JobApplication.new(params.require(:id))
        @job_application.user_id=current_user.id 
        @job_application.job_post_id=params[:id]
    end

end