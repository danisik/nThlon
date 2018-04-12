
module AppData {
	var disciplines = {};
	var disciplinesOrder = 0;
	
	var discovered = [0, 0, 0];
	
	var chosenDiscipline = "plavani";
	var checkBoxes = new[5];
	
	var behProperties = ["BehCas", "BehVzd", "BehNast", "BehRych", "BehTep", "BehLim"];
	var kolProperties = ["KolCas", "KolVzd", "KolNast", "KolRych", "KolTep", "KolLim"];
	var plavProperties = ["PlaCas", "PlaVzd", "PlaRych", "PlaTep", "PlaLim"];
	
	
	var dict = {"beh"=>behProperties, "kolo"=>kolProperties, "plavani"=>plavProperties};
	
	var heartRate = null;
	var speed = 0;
	
	var currEl = 0.0;
	var beforeEl = 0;
	var ascent = 0.0;
	var avgSpeed = 0;
	var avgHrt = 0;
    var elpDist = 0;
    var elpTime = 0;
	
}