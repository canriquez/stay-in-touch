class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  def my_friends
    friends = friendships.map{|friendship| friendship.friend if friendship.confirmed}
    friends += inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
    friends.compact   #cleanup
  end

  #My sent friendship requests not accepted or denied 
  def pending_requests
    friendships.map{|friendship| friendship.friend if !friendship.confirmed && !friendship.denied}.compact
  end

  #recieved friendship requests that I have not accepted or denied 
  def recieved_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed && !friendship.denied}.compact
  end

  def accept_request(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def reject_request(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.denied = true
    friendship.save
  end

  def is_friend?(user)
    friends.include?(user)
  end

end
