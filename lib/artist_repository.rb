require_relative './artist'

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name, genre FROM artists;'
    records = DatabaseConnection.exec_params(sql, [])
    # Returns an array of Artist objects.

    artists = []

    records.each do |record|
      artist = Artist.new
      artist.id = record['id']      
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end

    return artists
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists WHERE id = $1;
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    params = [id]

    records = DatabaseConnection.exec_params(sql, params)

    # Returns a single Student object.
    record = records[0]
    artist = Artist.new
    artist.id = record['id']      
    artist.name = record['name']
    artist.genre = record['genre']

    return artist
  end
end