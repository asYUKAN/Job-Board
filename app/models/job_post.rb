class JobPost < ApplicationRecord
  belongs_to :company
  has_many :users, :through => :job_applications
end
