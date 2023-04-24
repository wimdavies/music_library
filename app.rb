require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Printing out the artists from the repository:

artist_repository = ArtistRepository.new

artist_repository.all.each do |artist|
  p artist
end

# Printing out the albums from the repository:
album_repository = AlbumRepository.new

album_repository.all.each do |album|
   p album
end