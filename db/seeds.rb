# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GigPayment.destroy_all
Gig.destroy_all
Creator.destroy_all

gig_payment_1 = GigPayment.create(state: 'pending')
gig_payment_2 = GigPayment.create(state: 'pending')
gig_payment_3 = GigPayment.create(state: 'pending')

gig_1 = Gig.create(brand_name: 'Marvel', gig_payment: gig_payment_1)
gig_2 = Gig.create(brand_name: 'DC ', gig_payment: gig_payment_2)
gig_3 = Gig.create(brand_name: 'Disney', gig_payment: gig_payment_3)

creator_1 = Creator.create(first_name: 'C Tor', last_name: 'A Shtirbu Huber', gigs: [gig_1])
creator_2 = Creator.create(first_name: 'B Idan', last_name: 'B Huber', gigs: [gig_2])
creator_3 = Creator.create(first_name: 'A Yo', last_name: 'C Huber', gigs: [gig_3])
