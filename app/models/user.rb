class User < ApplicationRecord
  before_save { self.email.downcase! }
  before_save :find_or_create_university
  
  
  belongs_to :university, optional: true
  attr_accessor :university_name
  
  
  validates :name, presence: true,
                   length: { maximum: 30 },
                   uniqueness: true
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 255 }
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, length: {minimum: 8}, on: :update, allow_blank: true
  validates :university_name, presence: true, on: :create
  validates :university_name, presence: true, on: :update, allow_blank: true
  
  
  has_secure_password
  
  
  has_many :projects, dependent: :destroy
  has_many :user_relationships, dependent: :destroy
  has_many :followings, through: :user_relationships, source: :follow, dependent: :destroy
  has_many :reverses_of_user_relationship, class_name: 'UserRelationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_user_relationship, source: :user, dependent: :destroy
  has_many :project_favorites, dependent: :destroy
  has_many :likes, through: :project_favorites, source: :project, dependent: :destroy
  has_many :applikations, dependent: :destroy
  has_many :participatings, through: :applikations, source: :project, dependent: :destroy
  has_many :comment_to_projects, dependent: :destroy
  
  
  mount_uploader :image, ImageUploader
  
  
  #大学名検索&登録
  def find_or_create_university
    if university_name.present?
      self.university = University.find_or_create_by!(name: university_name)
    end
  end
  
  
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
    self.project_favorites.find_or_create_by(project_id: project.id)
  end
  
  def unlike(project)
    project_favorite = self.project_favorites.find_by(project_id: project.id)
    project_favorite.destroy if project_favorite
  end
  
  def liking?(project)
    self.likes.include?(project)
  end
  
  
  #プロジェクト参加/キャンセル機能
  def participate(project)
    self.applikations.find_or_create_by(project_id: project.id)
  end
  
  def cancel(project)
    applikation = self.applikations.find_by(project_id: project.id)
    applikation.update(cancel: true, canceled_at: DateTime.now) if applikation
  end
  
  def rejoin(project)
    applikation = self.applikations.find_by(project_id: project.id)
    applikation.update(cancel: false, canceled_at: nil) if applikation.cancel = true
  end
  
  def participating?(project)
    self.participatings.include?(project)
  end
end