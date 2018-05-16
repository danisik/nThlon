/** Modul pro ulozeni dat se kterymi aplikace pracuje */
const DISCIPLINE_RUNNING = "Beh";
const DISCIPLINE_CYCLING = "Kolo";
const DISCIPLINE_SWIMMING = "Plavani";
const DISCIPLINE_DEPO = "Depo";
const SPORT_NOT_CHOSEN_YET = -1;

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
	
	/** aktualne vybrana disciplina v menu, pro kterou uzivatel bude nastavovat properties */
	var chosenDiscipline = DISC_RUNNING;
	/** pri recordingu sport, ktery momentalne bezi */
	var chosenSport = SPORT_NOT_CHOSEN_YET;
	
	var checkBoxes;
	
	/** Mozno pridat nove informace, limity ale musi byt na poslednich pozicich v polich */
	var behProperties = ["BehCas", "BehVzd", "BehNast", "BehRych", "BehTep", "BehLimH", "BehLimS"];
	var kolProperties = ["KolCas", "KolVzd", "KolNast", "KolRych", "KolTep", "KolLimH", "KolLimS"];
	var plavProperties = ["PlaCas", "PlaVzd", "PlaRych", "PlaTep", "PlaLimH", "PlaLimS"];
	var depoProperties = [];
	
	/** slovnik kterej uchovava pro kazdou disciplinu jeji properties */
	var dict = {DISC_RUNNING=>behProperties, DISC_CYCLING=>kolProperties, DISC_SWIMMING=>plavProperties, DISC_DEPO=>depoProperties};
}