class JobPostsController < ApplicationController
    
    #before_action :authenticate!
   # before_action :authenticate_company!, only: [:create , :company_job_posts, :edit, :update, :destroy]
    before_action :authenticate_company!, only: [:job_post_applicants]

    def new
        # @address=CS
        unless current_company
            redirect_to company_session_path
        end
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

    def edit 
        @job_post = JobPost.find(params[:id])
        unless current_company && current_company.id == @job_post.company_id
            flash[:notice]="You can only edit your posts"
            redirect_to job_posts_path
        end
        
    end
    
    def update
      
            @job_post=JobPost.find(params[:id])

           

            if params[:share]   
                
              if current_user.nil?
                flash[:notice]="You need to signin as user to share your profile!"
                 redirect_to new_user_session_path
            

             elsif(@job_post.job_applications.where(user_id: current_user.id).empty?)
                @job_application=JobApplication.new 
                @job_application.job_post_id=params[:id]
                @job_application.user_id=current_user.id 
                @job_application.save
                flash[:notice]="Profile shared successfully"
                redirect_to job_posts_path 

              else
                 
                flash[:notice]="Profile already shared successfully"
                redirect_to job_posts_path  
              end
            else
                if current_company && current_company.id == @job_post.company_id && @job_post.update(params.require(:job_post).permit(:title, :mode,  :apply_link, :job_type, :location, :description))
                    flash[:notice]="Job Post edited successfully"
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
            flash[:notice]="You can only see applicants of your job posts"
            redirect_to company_posts_path
        end
    end


    def destroy
      
        @job_post=JobPost.find(params[:id])
        if current_company && current_company.id == @job_post.company_id
            flash[:notice]="You can delete your posts"
           @job_post.destroy 
           redirect_to company_posts_path
        else
            flash[:notice]="You can only delete your posts"
            redirect_to company_posts_path
        end
    end

        





end