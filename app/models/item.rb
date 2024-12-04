class Item < ApplicationRecord
   belongs_to :employee, optional: true
  has_many :item_histories, dependent: :destroy
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

end
