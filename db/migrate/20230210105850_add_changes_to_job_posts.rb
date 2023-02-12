class AddChangesToJobPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :job_posts, :job_type, :string 
    add_column :job_posts, :location, :string 

  end
end
