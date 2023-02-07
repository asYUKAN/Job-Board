class AddDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :contact, :integer
    add_column :users, :resume_link, :string
  end
end
