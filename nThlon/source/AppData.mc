/** Modul pro ulozeni dat se kterymi aplikace pracuje */
module AppData {

	var actualDiscipline = 0;
	var biggerInfo = 1;
	
	var disciplines = {};
	var disciplinesOrder = 0;
	
	var discovered = [0, 0, 0];
	
	var chosenDiscipline = "plavani";
	var chosenSport = "";
	
	var checkBoxes;
	
	var behProperties = ["BehCas", "BehVzd", "BehNast", "BehRych", "BehTep", "BehLimH", "BehLimS"];
	var kolProperties = ["KolCas", "KolVzd", "KolNast", "KolRych", "KolTep", "KolLimH", "KolLimS"];
	var plavProperties = ["PlaCas", "PlaVzd", "PlaRych", "PlaTep", "PlaLimH", "PlaLimS"];
	
	
	var dict = {"beh"=>behProperties, "kolo"=>kolProperties, "plavani"=>plavProperties};
	
	/*var heartRate = null;
	var speed = 0;
	
	var currEl = 0.0;
	var beforeEl = 0;
	var ascent = 0.0;
	var avgSpeed = 0;
	var avgHrt = 0;
    var elpDist = 0;
    var elpTime = 0;*/
	
}