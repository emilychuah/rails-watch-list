# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "json"
require "open-uri"

puts "Cleaning database..."
Movie.destroy_all if Rails.env == 'development'

puts "Creating movies..."
url = "http://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)
top_20_movies = movies["results"].first(20)

top_20_movies.each do |movie|
  Movie.create(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "Finished!"
