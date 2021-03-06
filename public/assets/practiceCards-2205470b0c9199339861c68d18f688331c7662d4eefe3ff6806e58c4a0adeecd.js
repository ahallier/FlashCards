/* global $ */
/* global responsiveVoice */

var PC = {
    currentCard: -1,
    cards: [],
    frontfirst: true,
    surroundWord: function(word) {
        return '<span id = "word", class="card-word">'+word+'</span>';
    },
    surroundAllWords: function(text) {
        return text.trim().split(/\s+/).map(PC.surroundWord).join(' ');
    },
    setup: (function(){
        $.support.cors = true;
        console.log("in setup");
        $(".flip").flip({
            trigger: 'click'
        });
        $('.definition-dialog').hide(); 
        $('.definition-dialog button').click(function() {
            $('.definition-dialog').hide(); 
        });
        
        $("table tbody").find('tr').each(function (i, el) {
            var hash = {};
            var $tds = $(this).find('td');
            
            hash["front"] = PC.surroundAllWords($tds.eq(2).text());
            hash["back"] =  PC.surroundAllWords($tds.eq(3).text());
            PC.cards[i] = hash;
        });
        
        $('.front, .back').on('click', '.card-word', function(event) {
            var word = $(this).text().toLowerCase();
            console.log('card word clicked: '+word);
            /*
            $.get({
                url: 'https://od-api.oxforddictionaries.com:443/api/v1/entries/en/'+word,
                headers: {
                    app_id: '42e69aa5',
                    app_key: 'adfd2ac26b504ef517e97bb6fe0ad798'
                },
                crossOrigin: true,
                dataType: 'application/jsonp',
                success: function(data) {
                    console.log(data);
                }
            });*/
            $('.definition-dialog span').text('Loading definition for '+word+'...');
            $('.definition-dialog').show();
            $.get({
                url: 'https://owlbot.info/api/v1/dictionary/'+word+'?format=json',
                dataType: 'application/json',
                crossOrigin: true,
                success: function(data) {
                    try {
                        var json = $.parseJSON(data);
                        console.log(json);
                        // Owlbot misspelled definition.
                        $('.definition-dialog span').text(word+' - '+json[0].defenition);
                    } catch (e) {
                        $('.definition-dialog span').text("Definition not found.");
                    }
                }
            })
            event.stopPropagation();
        });
        
        $( "#resetScore" ).hide();
        $("#nextButton").click(PC.nextCard);
        $("#lastButton").click(PC.lastCard);
        $("#correctButton").click(PC.addToScore);
        $("#incorrectButton").click(PC.addToScore);
        $( "#resetScore" ).click(PC.resetScore);
        $( "#randomButton" ).click(PC.randomPracticeOrder);
        $( "#sideButton" ).click(PC.backFirst);
        $( "#speakFront" ).click(PC.sayWord);
        $( "#speakBack" ).click(PC.sayWord);
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
    backFirst: function(){
      PC.frontfirst = !$("#sideButton").is(':checked');  
    },
    nextCard: function() {
        if(typeof PC.cards[PC.currentCard+1] != "undefined"){
            PC.currentCard++;
        }
        else{
           
            $( "#resetScore" ).show();
        }
        PC.showCard();
        
        
    },
    lastCard: function() {
        
        if(typeof PC.cards[PC.currentCard-1] != "undefined"){
            PC.currentCard--;
        }
        PC.showCard();
    },
    showCard: function(){
        console.log(PC.frontfirst);
        if(PC.frontfirst){
            $("#frontCard").html(PC.cards[PC.currentCard]["front"]);
            $("#backCard").html(PC.cards[PC.currentCard]["back"]);
        }
        else{
            $("#frontCard").html(PC.cards[PC.currentCard]["back"]);
            $("#backCard").html(PC.cards[PC.currentCard]["front"]);
        }
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
        PC.showCard();
        $( "#resetScore" ).hide();
    },
    randomPracticeOrder: function(){
       PC.currentCard = -1;
       PC.cards.sort(function(a, b){return 0.5 - Math.random()});
       PC.resetScore();
    },
    sayWord: function(){
        var words = "";
        if($(this).val() == "sayFront"){
            words = $("#frontCard").html();
        }
        else if($(this).val() == "sayBack"){
            words = $("#backCard").html();
        }
        words = words.replace(/<span id="word" ,="" class="card-word">/g, "");
        words = words.replace(/<\/span>/g," ");
        words = words.replace(/ x /gi," times ");
        responsiveVoice.speak(words);
        
    }
   
};
console.log("running js");
$(PC.setup);
