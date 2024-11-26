class Employee < ApplicationRecord
 has_many :documents
 has_many :items

  validates :first_name, :last_name, presence: true
  validates :personal_email, presence: true, uniqueness: true
  validates :city, :state, :country, :address_line_1, :pincode, :address_line_2, presence: true
  validates :date_of_birth, :date_of_joining, :job_title, presence: true

  def name
    "#{first_name} #{last_name}".strip
  end
  def Address
    "#{city},#{state},#{country},#{address_line_1},#{address_line_2},#{pincode}"
  end
  def name_with_email
    "#{name}(#{personal_email})"
  end
end
