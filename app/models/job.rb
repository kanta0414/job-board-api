class Job < ApplicationRecord
  validates :title, presence: true
  validates :category, presence: true
  validates :salary,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

