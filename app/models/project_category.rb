class ProjectCategory < ApplicationRecord
  validates :name, presence: true,
                   length: { maximum: 15 },
                   uniqueness: true
  
  has_many :projects
end
