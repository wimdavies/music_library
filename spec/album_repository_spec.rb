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
end