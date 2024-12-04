class ItemHistory < ApplicationRecord
  # Establishes the relationship with the Item model
  belongs_to :item

  # Optional: You can add any validations if needed
  validates :employee_name, presence: true
  validates :issued_date, presence: true
  validates :returned_date, presence: true, allow_nil: true
end