require 'ffaker'

materials = ['hardcove', 'glossy paper', 'wood pulp', 'uncoated papper']

def rand_book_size(range)
  rand(range).round(1)
end

['Mobile development', 'Photo', 'Web development', 'Web design'].each do |category|
  Category.create(title: category)
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
  