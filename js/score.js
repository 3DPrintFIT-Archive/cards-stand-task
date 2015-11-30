$(function () {
	$('#calculate').click( function() {
		  
		var array = document.getElementsByClassName("error");
		var numberOfErrors = 0;
		for(var ii = 0; ii < array.length; ii++) {
			if(array[ii].checked == true) {
				numberOfErrors++;	
			}
		}
		var result = 17 - (17/array.length)*numberOfErrors;
		document.getElementById('info').innerHTML =  ("Počet chyb: <strong>" + numberOfErrors + "</strong>");
		document.getElementById('result').innerHTML =  ("Výsledek je: <strong>" + result + "</strong> (+ 0 až 3 body podle kvality kódu)");

	});
});
