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
end

