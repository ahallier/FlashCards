PC = {
    currentCard: -1,
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
        $( "#resetScore" ).hide();
        $(document.getElementById("nextButton")).click(PC.nextCard);
        $(document.getElementById("lastButton")).click(PC.lastCard);
        $(document.getElementById("correctButton")).click(PC.addToScore);
        $(document.getElementById("incorrectButton")).click(PC.addToScore);
        $( "#resetScore" ).click(PC.resetScore);
        document.onkeydown = function() {
            switch (window.event.keyCode) {
                case 37:
                    PC.lastCard();
                    break;
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
           
            $( "#resetScore" ).show();
        }
        
        $("#frontCard").html(PC.cards[PC.currentCard]["front"]);
        $("#backCard").html(PC.cards[PC.currentCard]["back"]);
        $(".flip").flip(false);
        
    },
    lastCard: function() {
        
        console.log(PC.currentCard);
        console.log(Object.keys(PC.cards).length);
        if(typeof PC.cards[PC.currentCard-1] != "undefined"){
            PC.currentCard--;
        }
        //else{
        //    PC.currentCard = Object.keys(PC.cards).length-1; 
        //}
        
        
        $("#frontCard").html(PC.cards[PC.currentCard]["front"]);
        $("#backCard").html(PC.cards[PC.currentCard]["back"]);
        $(".flip").flip(false);
    
    },
    addToScore: function(){
        console.log("adding to score");
        
        var score = $("#currentscore").html().split("/");
        if(Number(score[1])< Object.keys(PC.cards).length){
            if(this.id == "correctButton"){
                $("#currentscore").html(Number(score[0])+1+"/"+(Number(score[1])+1));
               
            }
            else{
                $("#currentscore").html(Number(score[0])+"/"+(Number(score[1])+1))
            }
             PC.nextCard();
        }
        
        
       
    },
    resetScore: function(){
        $("#currentscore").html("0/0");
        PC.currentCard = 0;
        $("#frontCard").html(PC.cards[PC.currentCard]["front"]);
        $("#backCard").html(PC.cards[PC.currentCard]["back"]);
        $( "#resetScore" ).hide();
    }
   
};
console.log("running js");
$(PC.setup);


