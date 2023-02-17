class MainController < ApplicationController
   

    before_action :authenticate_admin

    def authenticate_admin
        unless (current_user && current_user.is_admin==true)
            flash[:error] ="You are not an admin"
            redirect_to job_posts_path
            return
        end
    end

    def index
    end

    def show_users
        @users = User.paginate(page: params[:page],per_page:10).where(is_admin:nil)
    end

    def destroy_user
        @user=User.find_by_id(params[:id])
        if @user.nil?
            flash[:error]="User is not available"
            redirect_to users_index_path
            return
        end
        if (current_user &&  user_signed_in? && current_user.is_admin==true)
            flash[:notice]="User account has been removed successfully"
            Discussion.all.each do |d|
                if d.author_id==@user.id
                    d.author_id=nil
                    d.save
                end
            end
           @user.destroy 
           redirect_to users_index_path
        else
            
            redirect_to users_index_path
        end
    end

    def show_companies
        @companies = Company.paginate(page: params[:page],per_page:10)
    end

    def destroy_company
        @company=Company.find_by_id(params[:id])
        if @company.nil?
            flash[:error]="Company is not available"
            redirect_to companies_index_path
            return
        end
        if (current_user &&  user_signed_in? && current_user.is_admin==true)
            flash[:notice]="Company account has been removed successfully"
           @company.destroy 
           redirect_to companies_index_path
        else
            
            redirect_to companies_index_path
        end
    end

    

    def destroy_job_post
        @job_post=JobPost.find_by_id(params[:id])
        if @job_post.nil?
            flash[:error]="Job Post is not available"
            redirect_to job_posts_path
            return
        end
        if (current_user &&  user_signed_in? && current_user.is_admin==true)
            flash[:notice]="Job Post has been deleted successfully"
           @job_post.destroy 
           redirect_to job_posts_path
        else
            
            redirect_to job_posts_path
        end
    end

    def destroy_discussion
        @discussion=Discussion.find_by_id(params[:id])
        
        @job_post=JobPost.find_by_id(@discussion.job_post_id)
        
        if @discussion.nil?
            flash[:error]="Discussion not available"
            redirect_to job_posts_path
            return
        end
        if @job_post.nil?
            flash[:error]="This Job Post is not available"
            redirect_to job_posts_path
            return
        end
        if (current_user &&  user_signed_in? && current_user.is_admin==true)
            
            Discussion.all.each do |discussion|
            
                if discussion.parent_id==@discussion.id
                    discussion.destroy
                end
            end
            @discussion.destroy
            flash[:notice]="Discussion and corresponding replys have been deleted successfully"
           
            redirect_to job_post_path(@discussion.job_post_id)
        else
            flash[:error]="You can only delete your posts discussions"
            redirect_to job_post_path(@discussion.job_post_id)
        end
    end

    def destroy_reply
        @reply = Discussion.find_by_id(params[:id])
        
        @job_post=JobPost.find_by_id(@reply.job_post_id)
        
        if @reply.nil?
            flash[:error]="That reply is not available"
            redirect_to job_posts_path
            return
        end
        if @job_post.nil?
            flash[:error]="This Job Post is not available"
            redirect_to job_posts_path
            return
        end

        if (current_user &&  user_signed_in? && current_user.is_admin==true)
           
            @reply.destroy
            flash[:notice]="reply has been deleted successfully"
        end

        redirect_to job_post_path(@reply.job_post_id)

    end



end