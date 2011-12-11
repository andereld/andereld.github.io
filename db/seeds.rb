# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding posts table with galactic nonsense"
Post.find_or_create_by_title(title: 'A New Post',
                             body: 'A long time ago in a galaxy far, far away')
Post.find_or_create_by_title(title: 'The Post Strikes Back',
                             body: 'Oh no!!!11!1one')
