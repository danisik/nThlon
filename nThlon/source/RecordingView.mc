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

/** Slouzi pro rekaci na tlacitka atp. v RecordingView */
class RecordingViewDelegate extends Ui.BehaviorDelegate {
	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	
        	AppData.disciplines[AppData.actualDiscipline].endDiscipline();
        	AppData.actualDiscipline += 1;
        	if (AppData.disciplines.size() > AppData.actualDiscipline) {
        		AppData.disciplines[AppData.actualDiscipline].startDiscipline();
        	}
        	else {
        		//Ui.switchToView(new nThlonView(), new nThlonDelegate(), Ui.SLIDE_RIGHT);
        		Ui.popView(Ui.SLIDE_RIGHT);
        	}
        }
        
    }
    
    function onSwipe(swipeEvent) {
    	if (swipeEvent.getDirection() == Ui.SWIPE_DOWN) {
    		var arr = AppData.disciplines[AppData.actualDiscipline].arr;
    		var posun = AppData.disciplines[AppData.actualDiscipline].posun;
    		if (AppData.biggerInfo < arr.size() - 1) {
    			//var arr = AppData.disciplines[AppData.actualDiscipline].arr;
    			arr[AppData.biggerInfo] = 0;
    			posun[AppData.biggerInfo - 1] = Gfx.FONT_MEDIUM;
    			posun[AppData.biggerInfo] = Gfx.FONT_SYSTEM_NUMBER_MEDIUM;
    			AppData.biggerInfo += 1;
    			
    			/*Sys.println(AppData.biggerInfo);
    			var test = (0.4).toNumber();
    			Sys.println((0.4).toNumber());*/
    		}
    	}
    	else if (swipeEvent.getDirection() == Ui.SWIPE_UP) {
    		if (AppData.biggerInfo > 1) {
    			var arr = AppData.disciplines[AppData.actualDiscipline].arr;
    			var posun = AppData.disciplines[AppData.actualDiscipline].posun;
    			AppData.biggerInfo -= 1;
    			arr[AppData.biggerInfo] = 1;
    			posun[AppData.biggerInfo - 1] = Gfx.FONT_SYSTEM_NUMBER_MEDIUM;
    			posun[AppData.biggerInfo] = Gfx.FONT_MEDIUM;
    			//Sys.println(AppData.biggerInfo);
    		}
    	}
    	//return true;
    }
}

/** View ktere slouzi pro zobrazeni vsech dulezitych hodnot behem provadeni discpliny (napr. heartrate, rychlost atp.) */
class RecordingView extends Ui.View {
	var recordingtimer;
	var elapsedtime = 55;
	var actualDiscipline = 0;
	var activityInfo = Act.getActivityInfo();
	var test = [];
	var test1 = {0=>activityInfo.currentHeartRate};

    function initialize() {
        View.initialize();
    }

	function recordingtimercallback()
    {
    	/*elapsedtime++;
    	dc.drawText(20, 20, Gfx.FONT_MEDIUM, "Ahojjjjjjjjjjj", Gfx.TEXT_JUSTIFY_LEFT);
        Ui.requestUpdate();
        dc.drawText(20, 20, Gfx.FONT_MEDIUM, "Ahojjjjjjjjjjj", Gfx.TEXT_JUSTIFY_LEFT);*/
        //Functions.pos = info.accuracy;
        Ui.requestUpdate();
        //Gfx.Dc.drawText(100 - 1, 29, Gfx.FONT_SYSTEM_NUMBER_MEDIUM, info.accuracy, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    function position(info) {
    	Functions.pos = info.accuracy;
    }
    
    function heartrate(info) {
    	Functions.hr = info.heartRate;
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
    	/*Sys.println(App.getApp().getProperty("BehCas"));
    	Sys.println(App.getApp().getProperty("BehVzd"));
    	Sys.println(App.getApp().getProperty("BehNast"));
    	Sys.println(App.getApp().getProperty("BehRych"));
    	Sys.println(App.getApp().getProperty("BehTep"));*/
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

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	//dc.drawText(20, 20, Gfx.FONT_MEDIUM, elapsedtime, Gfx.TEXT_JUSTIFY_LEFT);
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        
        
        var arr = [];
        for (var i = 0; i < 5; i += 1) {
        	arr.add(AppData.biggerInfo > i ? 0 : 1);
        }
        
        activityInfo = Act.getActivityInfo();
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(5);
        /*dc.drawText(20, 20, AppData.biggerInfo == 1 ? Gfx.FONT_SYSTEM_NUMBER_MEDIUM : Gfx.FONT_MEDIUM, test[0], Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 40 + 25 * arr[1], AppData.biggerInfo == 2 ? Gfx.FONT_SYSTEM_NUMBER_MEDIUM : Gfx.FONT_MEDIUM, Act.getActivityInfo().averageHeartRate, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 60 + 25 * arr[2], AppData.biggerInfo == 3 ? Gfx.FONT_SYSTEM_NUMBER_MEDIUM : Gfx.FONT_MEDIUM, Act.getActivityInfo().elapsedTime / 1000, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 80 + 25 * arr[3], AppData.biggerInfo == 4 ? Gfx.FONT_SYSTEM_NUMBER_MEDIUM : Gfx.FONT_MEDIUM, Act.getActivityInfo().currentSpeed, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 100 + 25 * arr[4], AppData.biggerInfo == 5 ? Gfx.FONT_SYSTEM_NUMBER_MEDIUM : Gfx.FONT_MEDIUM, Act.getActivityInfo().averageSpeed, Gfx.TEXT_JUSTIFY_LEFT);*/
        //Sys.println(test1[0]);
        var actualDis = AppData.disciplines[AppData.actualDiscipline];
        
        if (actualDis instanceof Discipline) {
        	dc.drawText(50, 6, Gfx.FONT_MEDIUM, Functions.convertTime(Sys.getTimer() - AppData.disciplines[0].startTime)[1], Gfx.TEXT_JUSTIFY_LEFT);
        	actualDis.drawInfo(dc);
        }
        
        	//actualDis.drawInfo(dc);
        /*for (var i = 0; i < test.size(); i += 1) {
        	dc.drawText(20, 20*(i+1) + 25 * arr[i], AppData.biggerInfo == (i+1) ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertSpeed(test[i])[1], Gfx.TEXT_JUSTIFY_LEFT);
        }*/
        /*if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][0])) {
    		dc.drawText(20, 20 + 25 * arr[0], AppData.biggerInfo == 1 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertTime(Act.getActivityInfo().elapsedTime)[1], Gfx.TEXT_JUSTIFY_LEFT);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][1])) {
    		dc.drawText(20, 40 + 25 * arr[1], AppData.biggerInfo == 2 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertDistance(Act.getActivityInfo().elapsedDistance)[1].format("%.2f"), Gfx.TEXT_JUSTIFY_LEFT);
    		dc.drawText(dc.getWidth() - 1, 40 + 25 * arr[1], AppData.biggerInfo == 2 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertDistance(Act.getActivityInfo().elapsedDistance)[0], Gfx.TEXT_JUSTIFY_RIGHT);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][2])) {
    		dc.drawText(20, 60 + 25 * arr[2], AppData.biggerInfo == 3 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertAscent(Act.getActivityInfo().totalAscent)[1].format("%.2f"), Gfx.TEXT_JUSTIFY_LEFT);
    		dc.drawText(dc.getWidth() - 1, 60 + 25 * arr[2], AppData.biggerInfo == 3 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertAscent(Act.getActivityInfo().totalAscent)[0], Gfx.TEXT_JUSTIFY_RIGHT);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][3])) {
    		dc.drawText(20, 80 + 25 * arr[3], AppData.biggerInfo == 4 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertSpeed(Act.getActivityInfo().currentSpeed)[1].format("%.2f"), Gfx.TEXT_JUSTIFY_LEFT);
    		dc.drawText(dc.getWidth() - 1, 80 + 25 * arr[3], AppData.biggerInfo == 4 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, Functions.convertSpeed(Act.getActivityInfo().currentSpeed)[0], Gfx.TEXT_JUSTIFY_RIGHT);
    	}
    	if (App.getApp().getProperty(AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline][4])) {
    		dc.drawText(20, 100 + 25 * arr[4], AppData.biggerInfo == 5 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, (Act.getActivityInfo().currentHeartRate), Gfx.TEXT_JUSTIFY_LEFT);
    		dc.drawText(dc.getWidth() - 1, 100 + 25 * arr[4], AppData.biggerInfo == 5 ? Gfx.FONT_SYSTEM_LARGE : Gfx.FONT_MEDIUM, "bpm", Gfx.TEXT_JUSTIFY_RIGHT);
    	}*/
        /*dc.drawText(20, 120, Gfx.FONT_MEDIUM, Act.getActivityInfo().elapsedDistance, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 140, Gfx.FONT_MEDIUM, Act.getActivityInfo().totalAscent, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 160, Gfx.FONT_MEDIUM, Sensor.getInfo().speed, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 180, Gfx.FONT_MEDIUM, Position.getInfo().speed, Gfx.TEXT_JUSTIFY_LEFT);*/
        //Sys.println(Sys.getTimer());
        /*dc.drawText(20, 40, Gfx.FONT_MEDIUM, AppData.speed, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 60, Gfx.FONT_MEDIUM, AppData.avgSpeed, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 80, Gfx.FONT_MEDIUM, AppData.elpDist, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 100, Gfx.FONT_MEDIUM, AppData.heartRate, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 120, Gfx.FONT_MEDIUM, AppData.avgHrt, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 140, Gfx.FONT_MEDIUM, AppData.ascent, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 160, Gfx.FONT_MEDIUM, AppData.currEl, Gfx.TEXT_JUSTIFY_LEFT);*/
        /*dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_BLACK);
        dc.drawText(20, 20, Gfx.FONT_MEDIUM, AppData.heartRate, Gfx.TEXT_JUSTIFY_LEFT);*/
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}