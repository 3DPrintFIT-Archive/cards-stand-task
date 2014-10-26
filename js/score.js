$(function () {
	$('#calculate').click( function() {
		  
		var array = document.getElementsByClassName("error");
		var numberOfErrors = 0;
		for(var ii = 0; ii < array.length; ii++) {
			if(array[ii].checked == true) {
				numberOfErrors++;	
			}
		}
		console.log ( "Pocet chyb " + numberOfErrors );
		var result = 20 - (20/array.length)*numberOfErrors;
		document.getElementById('info').innerHTML =  ("Pocet chyb <b>:" + numberOfErrors + "</b>");
		document.getElementById('result').innerHTML =  ("Vysledek je <b>:" + result + "</b>");

	});
});