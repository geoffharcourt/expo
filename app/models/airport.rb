class Airport < ApplicationRecord
  validates :city, presence: true
  validates :code, presence: true
  validates :name, presence: true
  validates :opened_on, presence: true
end
