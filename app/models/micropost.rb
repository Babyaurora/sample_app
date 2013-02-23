class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  
  default_scope order: 'microposts.created_at DESC'
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  def self.from_users_followed_by(user)
    where("user_id IN (SELECT followed_id FROM relationships WHERE follower_id = ?) OR user_id = ?", user, user)
  end
end
