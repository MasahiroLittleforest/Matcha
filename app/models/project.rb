class Project < ApplicationRecord
  belongs_to :user
  belongs_to :project_category
  
  validates :title, presence: true,
                    length: { maximum: 40 }
  validates :content, presence: true,
                      length: { maximum: 1000 }
  validates :deadline, presence: true
  validates :recruitment_numbers, presence: true
  
  has_many :reverses_of_project_favorite, class_name: 'Project_favorite', foreign_key: 'project_id'
  has_many :liked_users, through: :reverses_of_project_favorite, source: :user
  has_many :comment_to_projects
  has_many :reverses_of_applikation, class_name: 'Applikation', foreign_key: 'project_id'
  has_many :participants, through: :reverses_of_applikation, source: :user
end
