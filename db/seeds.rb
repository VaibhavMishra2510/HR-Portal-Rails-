# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# employee = Employee.create(
#   first_name: 'Vaibhav',
#   last_name: 'Mishra',
#   personal_email: 'raghav@gmail.com',
#   city: 'Kanpur',
#   state: 'Uttar Pradesh',
#   country: 'India',
#   pincode: '208011',
#   address_line_1: 'fghfhfh',
#   address_line_2: 'fsfwfhs'
# )

# db/seeds.rb
# admin = User.create!(email: 'admin@example.com', password: 'password', role: 'admin')
# manager = User.create!(email: 'manager@example.com', password: 'password', role: 'manager')
# employee = User.create!(email: 'employee@example.com', password: 'password', role: 'employee')


# Clear existing data
Item.destroy_all

# Fetch sample employees from Employee model
employees = Employee.limit(5) # Adjust the limit based on available employees

if employees.any?
  puts "Seeding items..."
  # Create items
  items_data = [
    {
      sr_no: 1,
      name: "Laptop",
      price: 75000.50,
      issued_to: employees[0].name,
      issued_date: Date.today - 30,
      returned_date: Date.today - 10,
      employee_id: employees[0].id
    },
    {
      sr_no: 2,
      name: "Mobile Phone",
      price: 25000.99,
      issued_to: employees[1].name,
      issued_date: Date.today - 60,
      returned_date: Date.today - 15,
      employee_id: employees[1].id
    },
    {
      sr_no: 3,
      name: "Tablet",
      price: 35000.00,
      issued_to: employees[2].name,
      issued_date: Date.today - 90,
      returned_date: nil, # Still not returned
      employee_id: employees[2].id
    },
    {
      sr_no: 4,
      name: "Monitor",
      price: 15000.75,
      issued_to: employees[3].name,
      issued_date: Date.today - 20,
      returned_date: Date.today - 5,
      employee_id: employees[3].id
    },
    {
      sr_no: 5,
      name: "Headphones",
      price: 5000.25,
      issued_to: employees[4].name,
      issued_date: Date.today - 10,
      returned_date: nil, # Still not returned
      employee_id: employees[4].id
    }
  ]

  items_data.each do |item_data|
    Item.create!(item_data)
  end

  puts "Seeding completed successfully!"
else
  puts "No employees found. Please ensure there are records in the employees table before running this seed."
end

