class Item < ApplicationRecord
  belongs_to :employee
  validates :name, presence: true
validates :price, numericality: { greater_than_or_equal_to: 0 }

end
