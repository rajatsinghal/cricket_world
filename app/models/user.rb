class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name, :email, :phone_number
  
  has_many :players, :dependent => :delete_all
  has_many :team_managers, :dependent => :delete_all
  
  accepts_nested_attributes_for :players, :allow_destroy => true
  accepts_nested_attributes_for :team_managers, :allow_destroy => true
  
  attr_accessor :temporary_password
  before_create :set_pending
  after_create :send_invitation
  
  STATUS_PENDING = 1
  STATUS_CONDIRMED = 2
  
  def self.get_random_temporary_password
    (0...9).map { (65 + rand(26)).chr }.join
  end
  
  def send_invitation
    InvitationMailer.send_invitation(self).deliver
  end
  
  scope :pending, lambda { where(:status => STATUS_PENDING) }
  scope :confirmed, lambda { where(:status => STATUS_CONDIRMED) }
  
  def pending?
    status == STATUS_PENDING
  end
  
  def confirmed?
    status == STATUS_CONDIRMED
  end
  
  def set_pending
    self.status = STATUS_PENDING
  end
  
  def set_confirmed
    self.status = STATUS_CONDIRMED
  end
end
