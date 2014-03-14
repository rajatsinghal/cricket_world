class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :teams
  has_many :users
  accepts_nested_attributes_for :teams, allow_destroy: true, :reject_if => proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :users, allow_destroy: true, :reject_if => proc { |attributes| attributes['name'].blank? }

  def display_name
  	self.email
  end
end
