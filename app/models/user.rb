class User < ApplicationRecord
  before_save { self.email.downcase! }
  #belongs_to :university
  
  validates :name, presence: true,
                   length: { maximum: 30 },
                   uniqueness: true
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 255 }
  validates :password, length: { minimum: 8 }
  
  has_secure_password
  
  has_many :projects
  has_many :user_relationships
  has_many :followings, through: :user_relationships, source: :follow
  has_many :reverses_of_user_relationship, class_name: 'User_relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_user_relationship, source: :user
  has_many :project_favorites
  has_many :likes, through: :project_favorites, source: :project
  has_many :applikations
  has_many :participatings, through: :applikations, source: :project
  
  
  #フォロー機能
  def follow(other_user)
    unless self == other_user
      self.user_relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    user_relationship = self.user_relationships.find_by(follow_id: other_user.id)
    user_relationship.destroy if user_relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #お気に入り機能
  def like(project)
    self.favorites.find_or_create_by(project_id: project.id)
  end
  
  def unlike(project)
    favorite = self.favorites.find_by(project_id: project.id)
    favorite.destroy if favorite
  end
  
  def liking?(project)
    self.likes.include?(project)
  end
end