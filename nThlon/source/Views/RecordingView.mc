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
using Toybox.Attention as Attention;

/** View ktere slouzi pro zobrazeni vsech dulezitych hodnot behem provadeni discpliny (napr. heartrate, rychlost atp.) */
class RecordingView extends Ui.View {
	var recordingtimer;
	var elapsedtime = 55;
	var actualDiscipline = 0;
	var activityInfo = Act.getActivityInfo();
	var test = [];
	var test1 = {0=>activityInfo.currentHeartRate};
	var lastVibration;

    function initialize() {
        View.initialize();
        lastVibration = Sys.getTimer();
    }

	function recordingtimercallback()
    {
        Ui.requestUpdate();
    }
    
    function position(info) {
    	Functions.pos = info.accuracy;
    }
    
    function heartrate(info) {
    	Functions.hr = info.heartRate;
    	var actualVibration = Sys.getTimer();
    	if (AppData.dict[AppData.chosenSport].size() == 0) {
    		return true;
    	}
    	var horniMez = App.getApp().getProperty(AppData.dict[AppData.chosenSport][AppData.dict[AppData.chosenSport].size() - 2]);
        var spodniMez = App.getApp().getProperty(AppData.dict[AppData.chosenSport][AppData.dict[AppData.chosenSport].size() - 1]);
    	
    	Sys.println(AppData.actualDiscipline);
    	if (info.heartRate == null) {
    		return true;
    	}
    	
    	if ((actualVibration - lastVibration) > 10000 && (info.heartRate < spodniMez.toNumber() || info.heartRate > horniMez.toNumber())) {
			if( Attention has :vibrate) {
            	var vibrateData = [ new Attention.VibeProfile(  25, 100 ),
                    new Attention.VibeProfile(  50, 100 ),
                    new Attention.VibeProfile(  75, 100 ),
                    new Attention.VibeProfile( 100, 100 ),
                    new Attention.VibeProfile(  75, 100 ),
                    new Attention.VibeProfile(  50, 100 ),
                    new Attention.VibeProfile(  25, 100 ) ];

            	Attention.vibrate( vibrateData );
            	lastVibration = actualVibration;
        	}
        	
		}
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.TestLayout(dc));
        dc.drawText(20, 20, Gfx.FONT_MEDIUM, "Ahojjjjjjjjjjj", Gfx.TEXT_JUSTIFY_LEFT);
        
        AppData.disciplines[0].startDiscipline();
        recordingtimer = new Timer.Timer();
		recordingtimer.start( method(:recordingtimercallback), 100, true );
		elapsedtime = 0;
		Pos.enableLocationEvents(Pos.LOCATION_CONTINUOUS, method(:position));
		Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    	Sensor.enableSensorEvents(method(:heartrate));
		
		switch (AppData.disciplines[0].chosenDiscipline) {
			case "beh":
				checkBeh();
				break;
			case "kolo":
				checkKolo();
				break;
			case "plavani":
				checkPlavani();
				break;
		}
    }
    
    function checkBeh() {
    
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][0])) {
    		test.add(activityInfo.elapsedTime);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][1])) {
    		test.add(activityInfo.elapsedDistance);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][2])) {
    		test.add(activityInfo.totalAscent);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][3])) {
    		test.add(activityInfo.currentSpeed);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][4])) {
    		test.add(activityInfo.currentHeartRate);
    	}
    }
    
    function checkKolo() {
    	if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][0])) {
    		test.add(activityInfo.elapsedTime);
    	}
    	else if (App.getApp().getProperty(AppData.dict[AppData.actualDiscipline][1])) {
    		test.add(activityInfo.elapsedDistance);
    	}
    	else if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][2])) {
    		test.add(activityInfo.ascent);
    	}
    	else if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][3])) {
    		test.add(activityInfo.currentSpeed);
    	}
    	else if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][4])) {
    		test.add(activityInfo.currentHeartRate);
    	}
    }
    
    function checkPlavani() {
    	if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][0])) {
    		test.add(activityInfo.elapsedTime);
    	}
    	else if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][1])) {
    		test.add(activityInfo.elapsedDistance);
    	}
    	else if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][2])) {
    		test.add(activityInfo.currentSpeed);
    	}
    	else if (App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][3])) {
    		test.add(activityInfo.currentHeartRate);
    	}
    }

    function onShow() {
    	
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
        
        
        
        var arr = [];
        for (var i = 0; i < 5; i += 1) {
        	arr.add(AppData.biggerInfo > i ? 0 : 1);
        }
        
        activityInfo = Act.getActivityInfo();
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(5);
        
        var actualDis = AppData.disciplines[AppData.actualDiscipline];
        
        if (actualDis instanceof Discipline) {
        	dc.drawText(50, 6, Gfx.FONT_MEDIUM, Functions.convertTime(Sys.getTimer() - AppData.disciplines[0].startTime)[1], Gfx.TEXT_JUSTIFY_LEFT);
        	actualDis.drawInfo(dc);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}