
PC = {
    currentCard: 0,
    cards: {},
    setup: $(function(){
    
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
        console.log(cards);
        $(document.getElementById("nextButton")).click(PC.nextCard);
    }),
    nextCard: function() {
    
    document.getElementById("frontCard").innerHTML = PC.cards[PC.currentCard]["front"];
    document.getElementById("backCard").innerHTML = PC.cards[PC.currentCard]["back"];
    $(".flip").flip(false);
    PC.currentCard++;
    }
}

$(PC.setup);