class AddDetailsToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :name, :string
    add_column :companies, :contact, :integer
    add_column :companies, :website_link, :string
    add_column :companies, :about, :text
    add_column :companies, :founded, :integer
    add_column :companies, :size, :integer
  end
end
