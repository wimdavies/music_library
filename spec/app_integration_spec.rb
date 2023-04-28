require_relative '../app.rb'
require 'album_repository'
require 'artist_repository'

RSpec.describe 'app integration' do
  it 'puts the welcome message and gets user choice' do
    io = double :io
    welcome_message = "Welcome to the music library manager!\n\nWhat would you like to do?\n 1 - List all albums\n 2 - List all artists\n\nEnter your choice:"

    expect(io).to receive(:puts).with(welcome_message).ordered
    expect(io).to receive(:gets).and_return("1").ordered

    app = Application.new( 
      'music_library_test',
      io,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app.run
  end

  context "user choice '1'" do
    it 'prints the album list header' do
      io = double :io
      welcome_message = "Welcome to the music library manager!\n\nWhat would you like to do?\n 1 - List all albums\n 2 - List all artists\n\nEnter your choice:"
      album_list_header = "Here is the list of albums:"

      expect(io).to receive(:puts).with(welcome_message).ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with(album_list_header).ordered

      app = Application.new( 
        'music_library_test',
        io,
        AlbumRepository.new,
        ArtistRepository.new
      )
      app.run
    end
  end

  context "user choice '2'" do
    xit 'prints the artist list header' do
      io = double :io
      welcome_message = "Welcome to the music library manager!\n\nWhat would you like to do?\n 1 - List all albums\n 2 - List all artists\n\nEnter your choice:"
      artist_list_header = "Here is the list of artists:"

      expect(io).to receive(:puts).with(welcome_message).ordered
      expect(io).to receive(:gets).and_return("1").ordered
      expect(io).to receive(:puts).with(artist_list_header).ordered

      app = Application.new( 
        'music_library_test',
        io,
        AlbumRepository.new,
        ArtistRepository.new
      )
      app.run
    end
  end
end