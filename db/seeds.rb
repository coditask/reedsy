# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
store = Store.create name: 'Store 1'
store2 = Store.create name: 'Store 2'
Item.create([ { code: 'MUG', name: 'Reedsy Mug', price: 600, store_id: store.id },
	          { code: 'MUG', name: 'Reedsy Mug', price: 600, store_id: store2.id },
	          { code: 'TSHIRT', name: 'Reedsy T-shirt', price: 1500, store_id: store.id },
	          { code: 'HOODIE', name: 'Reedsy Hoodie', price: 2000, store_id: store2.id }])
