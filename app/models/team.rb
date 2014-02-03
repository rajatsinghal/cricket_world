class Team < ActiveRecord::Base  
  belongs_to :admin_user
  has_many :league_statuses, :dependent => :delete_all
end