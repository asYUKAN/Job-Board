class JobPostsController < ApplicationController
    
   
    before_action :authenticate_company!, only: [:job_post_applicants]

    def new
        unless current_company
            redirect_to company_session_path
        end
    end

    def show
        @job_post = JobPost.find_by_id(params[:id])
        if @job_post.nil?
            redirect_to job_posts_path
        else
            @company = Company.find(@job_post.company_id)
        end
       
    end

    def create

        unless current_company
            redirect_to company_session_path
        end

        @job_post= JobPost.new(params.require(:job_post).permit(:title, :mode,  :apply_link, :job_type, :location, :description))
        @job_post.company_id = current_company.id
        @job_post.save
       
        redirect_to company_posts_path
    end

    def index
        # @job_posts = JobPost.all
        @job_posts=JobPost.paginate(page: params[:page],per_page:5)


    end
    
    def search
        @job_posts=JobPost.where("title Like ?", JobPost.sanitize_sql_like(params[:q])+"%").or(JobPost.where("job_type Like ?", JobPost.sanitize_sql_like(params[:q])+"%").or(JobPost.where("mode Like ?", JobPost.sanitize_sql_like(params[:q])+"%"))).or(JobPost.where("location Like ?", JobPost.sanitize_sql_like(params[:q])+"%")).paginate(page: params[:page],per_page:5)
        render "job_posts/index"
    end
    def edit 
        @job_post = JobPost.find(params[:id])
        unless current_company && current_company.id == @job_post.company_id
            flash[:error]="You can only edit your posts"
            redirect_to job_posts_path
        end
        
    end
    
    def update
      
            @job_post=JobPost.find(params[:id])

           

            if params[:share]   
                    
                if current_user.nil?
                    flash[:error]="You need to signin as user to share your profile!"
                    redirect_to new_user_session_path
                

                elsif(@job_post.job_applications.where(user_id: current_user.id).empty?)
                    @job_application=JobApplication.new 
                    @job_application.job_post_id=params[:id]
                    @job_application.user_id=current_user.id 
                    @job_application.save
                    flash[:notice]="Profile shared successfully"
                    redirect_to job_posts_path 

                else
                    
                    flash[:info]="Profile already shared successfully"
                    redirect_to job_posts_path  
                end
            else
                if current_company && current_company.id == @job_post.company_id && @job_post.update(params.require(:job_post).permit(:title, :mode,  :apply_link, :job_type, :location, :description))
                    flash[:notice]="Job Post updated successfully"
                    redirect_to company_posts_path
                
                end

            end
           
        
    end

    def share 
        
          @job_application=JobApplication.new 
          @job_application.job_post_id=params[:id]
          @job_application.user_id=current_user.id 
          @job_application.save
          flash[:notice]="Profile shared successfully"

    end

    def company_job_posts

        if current_company
        @job_posts=Company.find(current_company.id).job_posts.paginate(page: params[:page],per_page:5)
        end

    end

    def job_post_applicants
        @job_post=JobPost.find(params[:id])
        if current_company && current_company.id == @job_post.company_id 
            @job_applicants=@job_post.job_applications.paginate(page: params[:page],per_page:10)
        else 
            flash[:error]="You can only see applicants of your job posts"
            redirect_to company_posts_path
        end
    end


    def destroy
      
        @job_post=JobPost.find(params[:id])
        if current_company && current_company.id == @job_post.company_id
            flash[:notice]="Job Post has been deleted successfully"
           @job_post.destroy 
           redirect_to company_posts_path
        else
            flash[:error]="You can only delete your posts"
            redirect_to company_posts_path
        end
    end

        





end