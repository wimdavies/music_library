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

  context '#create' do
    it 'creates a new artist at the end of the line' do
      repo = ArtistRepository.new
      artist = Artist.new
      artist.name = 'Fleetwood Mac'
      artist.genre = 'Rock'
      repo.create(artist)
      artists = repo.all
      last_artist = artists.last 

      expect(last_artist.id).to eq '3'
      expect(last_artist.name).to eq 'Fleetwood Mac'
      expect(last_artist.genre).to eq 'Rock'
    end

    context "#delete" do
      it "deletes the first artist" do
        repo = ArtistRepository.new
        repo.delete(1)
        artists = repo.all
        first_artist = artists.first
        expect(first_artist.id).to eq '2'
        expect(first_artist.name).to eq 'Massive Attack'
        expect(first_artist.genre).to eq 'Alternative'
      end
    end
  end
end

