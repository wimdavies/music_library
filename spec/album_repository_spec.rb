require 'album_repository'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  it 'returns list of all albums' do
    repo = AlbumRepository.new
    albums = repo.all

    expect(albums.length).to eq 2
    expect(albums[0].id).to eq '1'
    expect(albums[0].title).to eq 'The Soft Bulletin'
    expect(albums[0].release_year).to eq '1999'
    expect(albums[0].artist_id).to eq '1'

    expect(albums[1].id).to eq '2'
    expect(albums[1].title).to eq 'Mezzanine'
    expect(albums[1].release_year).to eq '1998'
    expect(albums[1].artist_id).to eq '2'
  end

  it 'returns The Soft Bulletin as an album' do
    repo = AlbumRepository.new
    album = repo.find(1)
    expect(album.id).to eq '1'
    expect(album.title).to eq 'The Soft Bulletin'
    expect(album.release_year).to eq '1999'
    expect(album.artist_id).to eq '1'
  end

  it 'returns Mezzanine as an album' do
    repo = AlbumRepository.new    
    album = repo.find(2)
    expect(album.id).to eq '2'
    expect(album.title).to eq 'Mezzanine'
    expect(album.release_year).to eq '1998'
    expect(album.artist_id).to eq '2'
  end

  context '#create method' do
    it 'adds a new album to the database' do
      repo = AlbumRepository.new

      album = Album.new
      album.title = 'Rumours'
      album.release_year = 1977
      album.artist_id = '3'

      repo.create(album) # => nil

      albums = repo.all
      last_album = albums.last 

      expect(last_album.title).to eq 'Rumours'
      expect(last_album.release_year).to eq '1977'
      expect(last_album.artist_id).to eq '3'
    end
  end

  context '#delete' do
    it 'deletes the album from the database' do
      repo = AlbumRepository.new

      repo.delete(1)

      albums = repo.all
      first_album = albums.first

      expect(first_album.title).to eq 'Mezzanine'
      expect(first_album.release_year).to eq '1998'
    end
  end

  context "#update" do
    it "updates an album with new values" do
      repo = AlbumRepository.new

      album = repo.find(1)

      album.title = "Blue Lines"
      album.release_year = "1991"
      album.artist_id = "2"

      repo.update(album)

      updated_album = repo.find(1)

      expect(updated_album.title).to eq "Blue Lines"
      expect(updated_album.release_year).to eq "1991"
      expect(updated_album.artist_id).to eq "2"
    end

    it "updates an album with one new value" do
      repo = AlbumRepository.new

      album = repo.find(1)

      album.title = "Blue Lines"

      repo.update(album)

      updated_album = repo.find(1)

      expect(updated_album.title).to eq "Blue Lines"
      expect(updated_album.release_year).to eq "1999"
      expect(updated_album.artist_id).to eq "1"
    end
  end
end