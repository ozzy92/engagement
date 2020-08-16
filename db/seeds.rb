# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@board = Department.create(name: 'Board of Directors',
                            description: 'This is the top level department, representing the board of directors.',
                            cost_center: CostCentersController.new.new_cost_center)
