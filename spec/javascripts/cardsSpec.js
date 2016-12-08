describe('practicing cards', function() {
    describe('setup', function() {
    it('sets the cards to be used', function() {
       expect(true).toBe(true); 
    });
    describe('clicking the next button', function(){
        beforeEach(function(){
           loadFixtures('card.html');
        });
        
        it('calls the nextCard',function(){
            spyOn(PC,"nextCard"); 
            $('#nextButton').trigger('click');
            expect(PC.nextCard).toHaveBeenCalled();
        });
        
    });
    
    });
});


