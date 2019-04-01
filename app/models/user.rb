class User < ApplicationRecord
  before_save { self.email.downcase! }
  belongs_to :university
  
  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 255 }
  
  has_secure_password
  
  has_many :projects
  has_many :user_relationships
  has_many :followings, through: :user_relationships, source: :follow
  has_many :reverse_of_user_relationships, class_name: 'User_relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_user_relationships, source: :user
end