require 'artist_repository'

def reset_artists_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe ArtistRepository do
  before(:each) do 
    reset_artists_table
  end

  it 'returns list of all artists' do
    repo = ArtistRepository.new
    artists = repo.all 
    expect(artists.length).to eq 2
    expect(artists.first.id).to eq '1'
    expect(artists.first.name).to eq 'The Flaming Lips'
  end

  it 'returns The Flaming Lips as an artist' do
    repo = ArtistRepository.new
    artist = repo.find(1)
    expect(artist.id).to eq '1'
    expect(artist.name).to eq 'The Flaming Lips'
    expect(artist.genre).to eq 'Alternative Rock'
  end

  it 'returns Massive Attack as another artist' do
    repo = ArtistRepository.new
    artist = repo.find(2)
    expect(artist.id).to eq '2'
    expect(artist.name).to eq 'Massive Attack'
    expect(artist.genre).to eq 'Alternative'
  end
end

