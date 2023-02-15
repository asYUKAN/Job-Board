class JobPost < ApplicationRecord
  belongs_to :company
  
  has_many :job_applications, dependent: :destroy
 
  has_many :users, :through => :job_applications

  has_many :discussions, dependent: :destroy
end
