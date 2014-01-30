class User < ActiveRecord::Base
  has_many :shouts

  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: 'FollowingRelationship'
  # SELECT * FROM following_relationships WHERE follower_id = ?
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: 'FollowingRelationship' 
  has_many :followers, through: :follower_relationships
  # SELECT * FROM following_relationshipw WHERE follower_id = ?
  # SELECT * FROM users WHERE id in (?) # follower_ids
  #

  def following? user
    followed_user_ids.include? user.id
  end

  def follow user
    followed_users << user
  end

  def unfollow user
    followed_users.delete(user)
  end
end
