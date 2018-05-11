using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.Activity as Act;
using Toybox.ActivityRecording as Rec;
using Toybox.Position as Pos;
using Toybox.System as Sys;
using Toybox.Timer as Timer;
using Toybox.Sensor as Sensor;

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
		
	static var stageIcons = [ 
		Rez.Drawables.RunIcon,
		Rez.Drawables.CycleIcon,
		Rez.Drawables.SwimIcon,
		Rez.Drawables.TransIcon ];

	var lastVibration = 0;
	var chosenSport;
	var chosenDiscipline;
	
	var startTime = 0;
	var endTime = 0;
	var arr = [];
	var posun = [];
	
	var disciplineSession;
	
	
	function initialize(sport) {
		/*if (sport.equals("Beh")) {
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
		}*/
		
		switch (sport) {
			case DISCIPLINE_RUNNING:
				chosenSport = 0;
				chosenDiscipline = DISC_RUNNING;
				break;
			case DISCIPLINE_CYCLING:
				chosenSport = 1;
				chosenDiscipline = DISC_CYCLING;
				break;
			case DISCIPLINE_SWIMMING:
				chosenSport = 2;
				chosenDiscipline = DISC_SWIMMING;
				break;
			default:
				chosenSport = 3;
				chosenDiscipline = DISC_DEPO;
				break;
		}
		
		var properties = AppData.dict[chosenDiscipline];
		for (var i = 0; i < properties.size(); i += 1) {
			if (App.getApp().getProperty(properties[i]) == true) {
				arr.add(1);
				posun.add(Gfx.FONT_MEDIUM);
			}
		}
		if (arr.size() > 0) {
			arr[0] = 0;
			posun[0] = Gfx.FONT_SYSTEM_NUMBER_MEDIUM;
		}
		
		arr.add(1); // pro average hodnotu
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
           startTime = Sys.getTimer();
           //AppData.actualDiscipline = self.chosenDiscipline;
           AppData.chosenSport = self.chosenDiscipline;
       	}
       	}
	}
	
	function endDiscipline() {
		if ((disciplineSession != null) && disciplineSession.isRecording()) {
           disciplineSession.stop();
           //disciplineSession.discard();
           disciplineSession = null;
           AppData.biggerInfo = 1;
           endTime = Sys.getTimer();
           //session.ge
       	}
	}
	
	function drawInfo(dc) {
		//var chosenDiscipline = AppData.disciplines[AppData.actualDiscipline].chosenDiscipline;
		switch (chosenDiscipline) {
			case DISC_RUNNING:
				Functions.drawInfoBeh(dc);
				break;
			case DISC_CYCLING:
				Functions.drawInfoKolo(dc);
				break;
			case DISC_SWIMMING:
				Functions.drawInfoPlavani(dc);
				break;
			case DISC_DEPO:
				Functions.drawInfoDepo(dc);
				break;
		}
	}
	
}