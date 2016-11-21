describe Deck do
    describe 'searching Deck by keyword' do
        context 'with keyword' do
            it 'should search Deck with keyword' do
                deck = Deck.create
                deck.title = "test"
                Deck.search('test')
            end
        end
    end
end

#describe Movie do
#  describe 'searching Tmdb by keyword' do
#    context 'with valid key' do
#      it 'should call Tmdb with title keywords' do
#        expect( Tmdb::Movie).to receive(:find).with('Inception')
#        Movie.find_in_tmdb('Inception')
#      end
#    end
#    context 'with invalid key' do
#      it 'should raise InvalidKeyError if key is missing or invalid' do
#        allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::InvalidApiKeyError)
#        expect {Movie.find_in_tmdb('Inception') }.to raise_error(Movie::InvalidKeyError)
#      end
#    end
#  end
#end