require_relative './artist'

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name, genre FROM artists;'
    result = DatabaseConnection.exec_params(sql, [])
    # Returns an array of Artist objects.

    artists = []

    result.each do |record|
      artist = Artist.new
      artist.id = record['id']      
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end

    return artists
  end
end