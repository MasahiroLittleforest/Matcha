class University < ApplicationRecord
  has_many :users
  has_many :projects, through: :users
  has_many :reverses_of_applikation, through: :projects
end
