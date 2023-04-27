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

  def create(album)
    # Executes the SQL query
    # INSERT INTO albums (title, release_year) VALUES ($1, $2)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
    params = [album.title, album.release_year, album.artist_id]
    
    # No return value, creates the record on database
    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def delete(id)
    # Executes the SQL query
    # DELETE FROM albums WHERE id = $1
    sql = 'DELETE FROM albums WHERE id = $1;'
    param = [id]

    #No return value, deletes the record on database
    DatabaseConnection.exec_params(sql, param)
    
    return nil
  end

  def update(album)
    # Executes the SQL query
    # UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4
    sql = 'UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4;'
    params = [album.title, album.release_year, album.artist_id, album.id]
    
    DatabaseConnection.exec_params(sql, params)

    # No return value, updates the record on database
    return nil
  end
end