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

/** Modul ktery obsahuje dulezita data aplikace */	
module AppData {

	var actualDiscipline = 0;
	var biggerInfo = 1;
	
	var disciplines = {};
	//var disciplinesOrder = 0;
	
	//var discovered = [0, 0, 0];
	
	var chosenDiscipline = "plavani";
	var chosenSport = -1;
	
	var checkBoxes;
	
	var behProperties = ["BehCas", "BehVzd", "BehNast", "BehRych", "BehTep", "BehLimH", "BehLimS"];
	var kolProperties = ["KolCas", "KolVzd", "KolNast", "KolRych", "KolTep", "KolLimH", "KolLimS"];
	var plavProperties = ["PlaCas", "PlaVzd", "PlaRych", "PlaTep", "PlaLimH", "PlaLimS"];
	var depoProperties = [];
	
	/** slovnik kterej uchovava pro kazdou disciplinu jeji properties */
	var dict = {DISC_RUNNING=>behProperties, DISC_CYCLING=>kolProperties, DISC_SWIMMING=>plavProperties, DISC_DEPO=>depoProperties};
}