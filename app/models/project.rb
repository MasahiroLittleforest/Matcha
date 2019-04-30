class Project < ApplicationRecord
  include SessionsHelper
  
  belongs_to :user
  belongs_to :project_category
  
  validates :title, presence: true,
                    length: { maximum: 40 }
  validates :content, presence: true,
                      length: { maximum: 1000 }
  validates :deadline, presence: true
  validate :deadline_cannot_be_in_the_past
  validates :recruitment_numbers, presence: true
  
  has_many :reverses_of_project_favorite, class_name: 'Project_favorite', foreign_key: 'project_id', dependent: :destroy
  has_many :liked_users, through: :reverses_of_project_favorite, source: :user, dependent: :destroy
  has_many :comment_to_projects, dependent: :destroy
  has_many :reverses_of_applikation, class_name: 'Applikation', foreign_key: 'project_id', dependent: :destroy
  has_many :participants, through: :reverses_of_applikation, source: :user, dependent: :destroy
  
  
  mount_uploader :image, ImageUploader  #carrierwave
  

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline.past?
      errors.add(:deadline, "can not specify your past date as your deadline.")
    end
  end
  
  #def self.get_canceled_participants_in(project)
  #  User.joins(:applikations).includes(:applikations).where(applikations: { project_id: project.id, cancel: true })
  #end
  
  def get_not_canceled_participants
    User.joins(:applikations).includes(:applikations).where(applikations: { project_id: self.id, cancel: false }).order("applikations.updated_at ASC")
  end
  
  def get_canceled_participants
    User.joins(:applikations).includes(:applikations).where(applikations: { project_id: self.id, cancel: true }).order("applikations.canceled_at ASC")
  end
end
