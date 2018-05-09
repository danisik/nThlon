/** Modul pro ulozeni dat se kterymi aplikace pracuje */
const DISCIPLINE_RUNNING = "Beh";
const DISCIPLINE_CYCLING = "Kolo";
const DISCIPLINE_SWIMMING = "Plavani";
const DISCIPLINE_DEPO = "Depo";

enum {
	JEDNOTKA,
	HODNOTA
}

enum {
	DISC_RUNNING,
	DISC_CYCLING,
	DISC_SWIMMING,
	DISC_DEPO
}
	
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
	var depoProperties = [];
	
	
	var dict = {DISC_RUNNING=>behProperties, DISC_CYCLING=>kolProperties, DISC_SWIMMING=>plavProperties, DISC_DEPO=>depoProperties};
	
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