using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application;
using Toybox.ActivityRecording;
using Toybox.Sensor;
using Toybox.Activity as Act;

class nThlonDelegate extends Ui.BehaviorDelegate {

	var session = null;

    function initialize() {
        BehaviorDelegate.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    	Sensor.enableSensorEvents(method(:onSensor));
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

	function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	Sys.println("ZMACKNUTO");
        	var app = Application.getApp();
        	
        	var array = {};
        	array[0] = "Ahoj";
        	Sys.println(array[0]);
        	array[1] = "Testtttt";
        	Sys.println(array[1]);
        	Sys.println(array.size());
//        	app.setProperty("number", );
        	//Ui.pushView(new Rez.Menus.MainMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
        	//Ui.switchToView( new MyHRField(), new AprojectDelegate(), Ui.SLIDE_UP );
        	var menu = new Rez.Menus.MainMenu();
        	//menu.setTitle("Ahoj");
        	//Ui.draw("Ahoj");
        	Ui.pushView(menu, new nThlonMenuDelegate(), Ui.SLIDE_UP);
        	Ui.requestUpdate();
			return true;
        }
    }
    
    function onBack() {
        Sys.println("ZMACKNUTO3");
        if (Toybox has :ActivityRecording) {                          // check device for activity recording
       	if ((session == null) || (session.isRecording() == false)) {
           session = ActivityRecording.createSession(           // set up recording session
                {
                 :name=>"Generic",                              // set session name
                 :sport=>ActivityRecording.SPORT_CYCLING,       // set sport type
                 :subSport=>ActivityRecording.SUB_SPORT_MOUNTAIN // set sub sport type
                }
           );
           session.start();                                     // call start session
       	}
      	 else if ((session != null) && session.isRecording()) {
           //session.stop();                                      // stop the session
           //session.save();                                      // save the session
           //session = null;                                      // set session control variable to null
           //session.ge
       	}
   }	
        return true;
    }
    
    function onTest() {
        //Sys.println("ZMACKNUTO");
        Ui.pushView(new RecordingView(), new nThlonDelegate(), Ui.SLIDE_UP);
        Ui.requestUpdate();
        return true;
    }
    
    function onSwipe(swipeEvent) {
        Sys.println(swipeEvent.getDirection()); // e.g. SWIPE_RIGHT = 1
    }
    
    function onSensor(sensorInfo) {
    	AppData.heartRate = sensorInfo.heartRate;
    	var cursession = Act.getActivityInfo();
    	AppData.speed = cursession.currentSpeed;
    	AppData.ascent = cursession.totalAscent;
    	AppData.avgSpeed = cursession.averageSpeed;
    	AppData.avgHrt = cursession.averageHeartRate;
    	AppData.elpDist = cursession.elapsedDistance;
    	AppData.elpTime = cursession.elapsedTime;
    	AppData.currEl = cursession.altitude;
    	/*AppData.currEl = sensorInfo.altitude;
    	if (AppData.currEl > AppData.beforeEl) {
    		AppData.speed = AppData.speed + AppData.currEl - AppData.beforeEl;
    		AppData.beforeEl = AppData.currEl;
    	}*/
    	Ui.requestUpdate();
    	//Sys.println("Heart Rate: " + sensorInfo.heartRate);
	}
}