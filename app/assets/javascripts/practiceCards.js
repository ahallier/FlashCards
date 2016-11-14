PC = {
    currentCard: 0,
    cards: {},
    setup: (function(){
        console.log("in setup");
        $(".flip").flip({
            trigger: 'click'
        });
    
        $("table tbody").find('tr').each(function (i, el) {
            var hash = {};
            var $tds = $(this).find('td');
                hash["front"] = $tds.eq(2).text();
                hash["back"] = $tds.eq(3).text();
                PC.cards[i] = hash;
            
        });
        
        console.log(PC.cards);
        $(document.getElementById("nextButton")).click(PC.nextCard);
        $(document.getElementById("lastButton")).click(PC.lastCard);
        document.onkeydown = function() {
            switch (window.event.keyCode) {
                case 37:
                    PC.lastCard();
                    break
                case 39:
                    PC.nextCard();
            }
        };
    }),
    nextCard: function() {
        if(typeof PC.cards[PC.currentCard+1] != "undefined"){
            PC.currentCard++;
        }
        else{
            PC.currentCard = 0; 
        }
        console.log("next");
        console.log(PC.currentCard);
        document.getElementById("frontCard").innerHTML = PC.cards[PC.currentCard]["front"];
        document.getElementById("backCard").innerHTML = PC.cards[PC.currentCard]["back"];
        $(".flip").flip(false);
        
    },
    lastCard: function() {
        console.log("next");
        console.log(PC.currentCard);
        console.log(Object.keys(PC.cards).length);
        if(typeof PC.cards[PC.currentCard-1] != "undefined"){
            PC.currentCard--;
        }
        else{
            PC.currentCard = Object.keys(PC.cards).length-1; 
        }
        
        
        document.getElementById("frontCard").innerHTML = PC.cards[PC.currentCard]["front"];
        document.getElementById("backCard").innerHTML = PC.cards[PC.currentCard]["back"];
        $(".flip").flip(false);
    
    }
};
console.log("running js");
$(PC.setup);


