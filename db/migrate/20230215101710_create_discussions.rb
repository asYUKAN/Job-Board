class CreateDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :discussions do |t|
      t.integer :parent_id
      t.integer :author_id
      t.boolean :is_user
      t.text :content
      t.references :job_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
