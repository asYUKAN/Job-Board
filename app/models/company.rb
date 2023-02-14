class Company < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :job_posts, dependent: :destroy
  validates :founded, numericality: { 
  only_integer: true, 
  less_than_or_equal_to: ->(_company) { Date.current.year }
}
end
