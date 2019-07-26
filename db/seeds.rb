require 'ffaker'

#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

=begin
Address.create(first_name: FFaker::Name.first_name,
               last_name: FFaker::Name.last_name,
               address: FFaker::AddressUS.street_address,
               city: FFaker::AddressUS.city,
               zip: FFaker::AddressUS.zip_code,
               country: FFaker::AddressUS.country,
               phone: FFaker::PhoneNumber.phone_calling_code + FFaker::PhoneNumber.phone_number,
               address_type: 0,
               user_id: 7)
=end

materials = ['hardcove', 'glossy paper', 'wood pulp', 'uncoated papper']

def rand_book_size(range)
  rand(range).round(1)
end

20.times do
    book = Book.create(title: FFaker::Book.title,
                       price: rand(10.00..99.99).round(2),
                       quantity: rand(0..30),
                       year: FFaker::Time.date.year,
                       description: FFaker::Book.description,
                       materials: materials.sample(2).join(', ').capitalize,
                       height: rand_book_size(5.0..7.0),
                       width: rand_book_size(3.0..4.0),
                       depth: rand_book_size(1.0..3.0),
                       images: [])
    rand(1..2).times do
      author = Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name)
      book.authors << author
    end
    Category.all.sample.books << book
  end