describe('practicing cards', function() {
    describe('setup', function() {
        it('sets the cards to be used', function() {
            expect(true).toBe(true); 
        });
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
    
    describe('surround word function', function() {
        it('should work for one word', function() {
            //spyOn(PC, 'surroundWord');
            expect(PC.surroundWord("word")).toEqual('<span id = "word", class="card-word">word</span>');
        });
    });
    describe('surround all words', function() {
       it('should work for one word', function () {
           expect(PC.surroundAllWords("word")).toEqual('<span id = "word", class="card-word">word</span>');
       });
        it('should work for two words', function () {
           expect(PC.surroundAllWords("word word")).toEqual('<span id = "word", class="card-word">word</span> <span id = "word", class="card-word">word</span>');
       });
        it('should work for three word', function () {
           expect(PC.surroundAllWords("word word word")).toEqual('<span id = "word", class="card-word">word</span> <span id = "word", class="card-word">word</span> <span id = "word", class="card-word">word</span>');
       });
       
       it('should remove side whitespace', function() {
            expect(PC.surroundAllWords("    word ")).toEqual('<span id = "word", class="card-word">word</span>');
       });
       
       it('should remove multiple inner whitespaces', function() {
            expect(PC.surroundAllWords("word     word")).toEqual('<span id = "word", class="card-word">word</span> <span id = "word", class="card-word">word</span>');
       })
    });
});


