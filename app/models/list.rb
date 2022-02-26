class List < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
