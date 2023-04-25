require_relative './album'

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result = DatabaseConnection.exec_params(sql, [])
    
    # Returns an array of Album objects.
    albums = []

    result.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      
      albums << album
    end

    return albums
  end

  def find(id)
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    # Returns a single Album object.
    record = result[0]
    album = Album.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']

    return album
  end
end