# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

customer_1 = Customer.create(first_name: "Homer", last_name: "Simpson", address: "742 Evergreen Terrace", email: "BigHomie@doh.com")
customer_2 = Customer.create(first_name: "Ned", last_name: "Flanders", address: "744 Evergreen Terrace", email: "hididdlyho@neighbor.com")

tea_1 = Tea.create(title: "Green Tea", description: "Green tea make brain go brrrr", temperature: "140", brew_time: "3")
tea_2 = Tea.create(title: "Black Tea", description: "Black tea, stronger than other teas", temperature: "212", brew_time: "7")
tea_3 = Tea.create(title: "White Tea", description: "White Tea from Fuijan province of China", temperature: "180", brew_time: "5")

Subscription.create(tea_id: tea_1.id, customer_id: customer_1.id, title: "Green Tea Subscription", price: "15.00", status: "Active", frequency: "Monthly")
Subscription.create(tea_id: tea_3.id, customer_id: customer_2.id, title: "White Tea Subscription", price: "30.00", status: "Active", frequency: "Weekly")
Subscription.create(tea_id: tea_2.id, customer_id: customer_1.id, title: "Black Tea Subscription", price: "20.00", status: "Active", frequency: "Weekly")
Subscription.create(tea_id: tea_2.id, customer_id: customer_2.id, title: "Black Tea Subscription", price: "20.00", status: "Active", frequency: "Monthly")