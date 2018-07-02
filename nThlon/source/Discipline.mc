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

/** Trida reprezentujici disciplinu */
class Discipline {
	static var stageNames = [
		Ui.loadResource(Rez.Strings.disciplineRunning), 
		Ui.loadResource(Rez.Strings.disciplineCycling), 
		Ui.loadResource(Rez.Strings.disciplineSwimming), 
		Ui.loadResource(Rez.Strings.disciplineDepo) ];
		
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

	/** cas posledni vibrace - hr */
	var lastVibration;
	var chosenSport;
	var chosenDiscipline;
	
	/** cas kdy byla disciplina spustena */
	var startTime;
	/** cas kdy byla disciplina zastavena */
	var endTime;
	/** slouzi k posunu nezvetsenych informaci */
	var arr;
	/** uklada font pro danou informaci */
	var posun;
	
	var name = "";
	
	var disciplineSession;
	
	
	function initialize(sport) {
		self.arr = [];
		self.posun = [];
		self.startTime = 0;
		self.endTime = 0;
		self.lastVibration = 0;
	
		switch (sport) {
			case DISCIPLINE_RUNNING:
				chosenSport = DISC_RUNNING;
				chosenDiscipline = DISC_RUNNING;
				name = "DISCIPLINE_RUNNING";
				break;
			case DISCIPLINE_CYCLING:
				chosenSport = DISC_CYCLING;
				chosenDiscipline = DISC_CYCLING;
				name = "DISCIPLINE_CYCLING";
				break;
			case DISCIPLINE_SWIMMING:
				chosenSport = DISC_SWIMMING;
				chosenDiscipline = DISC_SWIMMING;
				name = "DISCIPLINE_SWIMMING";
				break;
			default:
				chosenSport = DISC_DEPO;
				chosenDiscipline = DISC_DEPO;
				name = "DISCIPLINE_DEPO";
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
		
		arr.add(1); // kvuli prumernym hodnotam
	}
	
	/** pusti disciplinu */
	function startDiscipline() {
		if (Toybox has :ActivityRecording) {
       		if ((disciplineSession == null) || (disciplineSession.isRecording() == false)) {
           		disciplineSession = ActivityRecording.createSession(
               		 {
                		:name=>stageNames[chosenSport],
                 		:sport=>stageSports[chosenSport],
                 		:subSport=>stageSubSports[chosenSport]
                	 }
           		);
           		disciplineSession.start();
           		startTime = Sys.getTimer();
           		AppData.chosenSport = self.chosenDiscipline;
       		}
       	}
	}
	
	/** zastavi aktualni disciplinu */
	function endDiscipline() {
		if ((disciplineSession != null) && disciplineSession.isRecording()) {
           disciplineSession.stop();
           disciplineSession = null;
           AppData.biggerInfo = 1;
           endTime = Sys.getTimer();
       	}
	}
	
	/** slouzi pro vykresleni hodnot v discipline - pouziva k tomu metody z modulu Functions */
	function drawInfo(dc) {
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