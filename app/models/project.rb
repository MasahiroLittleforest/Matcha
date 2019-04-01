class Project < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 40 }
  validates :content, presence: true,
                      length: { maximum: 1000 }
  validates :deadline, presence: true
  validates :recruitment_numbers, presence: true
end
