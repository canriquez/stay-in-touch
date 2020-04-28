class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX, message: 'The email is not valid' }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships 
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"

  def my_friends
    friends = friendships.map{|friendship| friendship.friend if friendship.status == 'accepted'}
    friends += inverse_friendships.map{|friendship| friendship.user if friendship.status == 'accepted'}
    friends.compact   #cleanup
  end

  #My sent friendship requests 
  def pending_requests
    friendships.map{|friendship| friendship.friend if friendship.status == "requested" }.compact
  end

  #recieved friendship requests that I have not accepted or denied 
  def recieved_requests
    inverse_friendships.map{|friendship| friendship.user if friendship.status == 'requested'}.compact
  end

  def accept_request(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = 'accepted'
    friendship.save
  end

  def reject_request(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = 'rejected'
    friendship.save
  end

  def is_friend?(user)
    my_friends.include?(user)
  end
end
