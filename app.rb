require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Creating new instances of the table repositories:
artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

# Printing out the artists from the repository:
# artist_repository.all.each do |artist|
#  p artist
# end

# Printing out the albums from the repository:
# album_repository.all.each do |album|
#   p album
# end

# Printing out one artist from the ArtistRepository:
# p artist_repository.find(1)

# Printing out the data of the record with id 3 
# from the Album Repository:
p artist_repository.find(3)