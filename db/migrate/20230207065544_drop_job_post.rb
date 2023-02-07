class DropJobPost < ActiveRecord::Migration[7.0]
  def change
    drop_table :job_posts
  end
end
