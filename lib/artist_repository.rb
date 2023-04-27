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

  def create(artist)
    # Executes the SQL query
    # INSERT INTO artists (name, genre) VALUES ($1, $2);
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    params = [artist.name, artist.genre]

    DatabaseConnection.exec_params(sql, params)

    # No return value, creates the record on database
    return nil
  end

  def delete(id)
    # Executes the SQL query
    # DELETE FROM artists WHERE id = $1;
    sql = 'DELETE FROM artists WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)

    #No return value, deletes the record on database
    return nil
  end

  def update(artist)
    # Executes the SQL query
    # UPDATE artists SET name = $1, genre = $2 WHERE id = $3;
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
    params = [artist.name, artist.genre, artist.id]

    DatabaseConnection.exec_params(sql, params)

    # No return value, updates the record on database
    return nil
  end
end