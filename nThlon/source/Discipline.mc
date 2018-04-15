using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Position as Pos;
using Toybox.ActivityRecording as Rec;
using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.Timer as Timer;

/** Trida reprezentujici jednu disciplinu */
class Discipline {
	static var stageNames = [
		"Beh", 
		"Kolo", 
		"Plavani", 
		"Depo" ];
		
	static var stageSports = [ 
		Rec.SPORT_RUNNING,
		Rec.SPORT_CYCLING,
		Rec.SPORT_SWIMMING,
		Rec.SPORT_TRANSITION ];
		
	static var stageSubSports = [ 
		Rec.SUB_SPORT_STREET,
		Rec.SUB_SPORT_ROAD,
		Rec.SUB_SPORT_OPEN_WATER,
		Rec.SUB_SPORT_GENERIC ];
		
	/*static var stageIcons = [ 
		Rez.Drawables.RunIcon,
		Rez.Drawables.CycleIcon,
		Rez.Drawables.SwimIcon,
		Rez.Drawables.TransIcon ];*/

	var chosenSport;
	
	var startTime = 0;
	var endTime = 0;
	
	var disciplineSession;
	
	
	function initialize(sport) {
		if (sport.equals("Beh")) {
			chosenSport = 0;
		}
		else if (sport.equals("Kolo")) {
			chosenSport = 1;
		}
		else if (sport.equals("Plavani")) {
			chosenSport = 2;
		}
		else {
			chosenSport = 3;
		}
	}
	
	function startDiscipline() {
		if (Toybox has :ActivityRecording) {
		Sys.println("ZACINAM");
       	if ((disciplineSession == null) || (disciplineSession.isRecording() == false)) {
       	Sys.println("SESNA");
           disciplineSession = ActivityRecording.createSession(
                {
                 :name=>stageNames[chosenSport],
                 :sport=>stageSports[chosenSport],
                 :subSport=>stageSubSports[chosenSport]
                }
           );
           disciplineSession.start();
       	}
       	}
	}
	
	function endDiscipline() {
		if ((disciplineSession != null) && disciplineSession.isRecording()) {
           disciplineSession.stop();
           //disciplineSession.discard();
           disciplineSession = null;
           //session.ge
       	}
	}
}