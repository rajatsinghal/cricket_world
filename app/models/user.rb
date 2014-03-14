class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #validates_presence_of :name, :email, :phone_number
  validates_presence_of :name
  
  has_many :players, :dependent => :delete_all
  has_many :team_managers, :dependent => :delete_all
  belongs_to :admin_user
  
  accepts_nested_attributes_for :players, :allow_destroy => true
  accepts_nested_attributes_for :team_managers, :allow_destroy => true
  
  attr_accessor :temporary_password
  before_create :set_pending
  #after_create :send_invitation
  
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

  def self.create_more
    player_names = ['Sunil Singh','Nadim Hussain','Lawton Niall','Arpit Kumar','Tanuj Barooah','Abhinav Aggarwal','Pratik Mishra','Rajat Bhatnagar','Arpit Kapoor','Rajat Kumar','Anuj Maheshwari','Chandrakishore Baruah','Suraj Maheshwari','Apurv Mehta','Nikhil Kohli','Abhay Mongia','Harshal Bhatnagar','Erin Quirk','Sukhram Chopra','Gurdweep Dhariwal','Aditya Pandit','Mohan Patel','Agamjeet Gupta','Pargat Chopra','Archie Tyas','Sahib Arora','Nikhil Mongia','Sukhindir Chopra','Abhay Rastogi','Harshal Udayar']
    user = User.find(1)

    15.times do |i|
      new_user = User.new
      new_user.phone_number = user.phone_number
      new_user.email = "saurabh+#{i}@octathorpeweb.com"
      new_user.name = player_names[i]
      random_temporary_password = User.get_random_temporary_password
      new_user.password = random_temporary_password
      new_user.password_confirmation = random_temporary_password
      new_user.save
      new_user.players.create({team_id: 1})
    end

    15.times do |i|
      new_user = User.new
      new_user.phone_number = user.phone_number
      new_user.email = "saurabh+#{15+i}@octathorpeweb.com"
      new_user.name = player_names[15+i]
      random_temporary_password = User.get_random_temporary_password
      new_user.password = random_temporary_password
      new_user.password_confirmation = random_temporary_password
      new_user.save
      new_user.players.create({team_id: 2})
    end
  end

end
