class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name, :email, :phone_number
  
  has_many :players
  has_many :team_managers
  
  accepts_nested_attributes_for :players, :allow_destroy => true
  accepts_nested_attributes_for :team_managers, :allow_destroy => true
  
  attr_accessor :temporary_password
  after_create :send_invitation
  
  def self.get_random_temporary_password
    (0...9).map { (65 + rand(26)).chr }.join
  end
  
  def send_invitation
    InvitationMailer.send_invitation(self).deliver
  end
end
