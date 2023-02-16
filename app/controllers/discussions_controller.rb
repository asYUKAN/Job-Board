class DiscussionsController < ApplicationController






   def new
   end
    def create_question

        @discussion =Discussion.new(params.permit(:job_post_id, :content))
        
        if current_user && user_signed_in?
            @discussion.author_id=current_user.id
            @discussion.is_user=true
        elsif current_company && company_signed_in?
            @discussion.author_id=current_company.id
        else
            flash[:info]="Please sign in to ask questions"
            redirect_to new_user_session_path
            return
        end
        
        @discussion.save
        flash[:notice]="Question posted successfully "
        redirect_to job_post_url(@discussion.job_post_id)
        
    end

    def create_answer

        @answer=Discussion.new(params.permit(:parent_id, :job_post_id, :content))
        
        if current_user && user_signed_in?
            @answer.author_id=current_user.id
            @answer.is_user=true
        elsif current_company && company_signed_in?
            @answer.author_id=current_company.id
        else
            flash[:info]="Please sign in to answer questions"
            redirect_to new_user_session_path
            return
        end
        
        @answer.save
        flash[:notice]="Reply sent successfully "
        redirect_to job_post_url(@answer.job_post_id)
        
    end

    def update
    end

    def destroy
      
        @discussion=Discussion.find_by_id(params[:id])
        @job_post=JobPost.find(@discussion.job_post_id)
        
        if current_company && current_company.id == @job_post.company_id
            
            Discussion.all.each do |discussion|
            
                if discussion.parent_id==@discussion.id
                    discussion.destroy
                end
            end
            @discussion.destroy
            flash[:notice]="Discussion and corresponding replys have been deleted successfully"
           
            redirect_to company_posts_path
        else
            flash[:error]="You can only delete your posts discussions"
            redirect_to company_posts_path
        end
    end

end