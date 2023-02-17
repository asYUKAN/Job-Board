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
            @discussion.is_user=false
        else
            flash[:info]="Please sign in to ask questions"
            redirect_to new_user_session_path
            return
        end
        
        @discussion.save

        if JobPost.find_by_id(@discussion.job_post_id).nil?
            flash[:error]="That Job Post is deleted by its Company"
            @discussion.destroy
            redirect_to job_posts_path
        else 
            flash[:notice]="Question posted successfully "
            redirect_to job_post_url(@discussion.job_post_id)
          
        end
        
        
    end

    def create_answer
        
        # @job_post=JobPost.find_by_id(@discussion.job_post_id)

        @answer=Discussion.new(params.permit(:parent_id, :job_post_id, :content))
        
        if current_user && user_signed_in?
            @answer.author_id=current_user.id
            @answer.is_user=true
        elsif current_company && company_signed_in?
            @answer.author_id=current_company.id
            @answer.is_user=false
        else
            flash[:info]="Please sign in to answer questions"
            redirect_to new_user_session_path
            return
        end
        
        @answer.save
        if Discussion.find_by_id(@answer.parent_id).nil?
            flash[:error]="That question is deleted by its author"
            @answer.destroy
            redirect_to job_posts_path
        else 

            redirect_to job_post_url(@answer.job_post_id)
        end
        
        
    end

    def edit 
        @discussion=Discussion.find_by_id(params[:id])
        if @discussion.nil?
            flash[:error]="Discussion not available"
            redirect_to job_posts_path
        elsif @discussion.is_user==true 
            if (current_user && current_user.id == @discussion.author_id && @discussion.update(params.permit(:content)))
                flash[:notice]="Reply was updated successfully"
                redirect_to job_post_path(@discussion.job_post_id)
            end
        elsif (@discussion.is_user==false || @discussion.is_user.nil?)
            if (current_company && current_company.id == @discussion.author_id && @discussion.update(params.permit(:content)))
                flash[:notice]="Reply was updated successfully"
                redirect_to job_post_path(@discussion.job_post_id)
            end
        else
            flash[:error]="You can edit your reply only"
            redirect_to job_post_path(@discussion.job_post_id)
        end
        
    end

    def update
    end

    def destroy
      
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
        if current_company && current_company.id == @job_post.company_id
            
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

end