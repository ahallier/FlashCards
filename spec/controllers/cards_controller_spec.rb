require 'spec_helper'
require 'rails_helper'

describe CardsController do
    before :each do
      @card = Card.create!({:deck_id => 1, :front => 'FrontTest',  :back => 'BackTest'})
    end
    describe 'Adding new card' do
        it 'should call the Card.create! method' do
            expect(Card).to receive(:create!)
            post :create, {:card =>{:deck_id => 1, :front => 'FrontTest',  :back => 'BackTest'}}
        end
    end
    describe 'updating card' do
        it 'should call the Card.save method' do
            card_spy = spy(Card)
            allow(Card).to receive(:find).and_return card_spy
            expect(card_spy).to receive(:save)
            put :update, {:id=>1, :card =>{:deck_id => 1, :front => 'FrontTest',  :back => 'BackTest'}}
        end
    end
    describe 'deleting card' do
        it 'should call the Card.destroy method' do
            card_spy = spy(Card)
            allow(Card).to receive(:find).and_return card_spy
            expect(card_spy).to receive(:destroy)
            delete :destroy, {:id=>1}
        end
    end
end
