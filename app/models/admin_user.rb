class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :teams
  accepts_nested_attributes_for :teams, allow_destroy: true, :reject_if => proc { |attributes| attributes['name'].blank? }
end
