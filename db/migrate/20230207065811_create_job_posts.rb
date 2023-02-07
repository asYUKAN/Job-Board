class CreateJobPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :job_posts do |t|
      t.string :title
      t.string :mode
      t.date :deadline
      t.string :apply_link
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
