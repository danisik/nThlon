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
	//var elapsedtime = 55;
	//var actualDiscipline = 0;
	var activityInfo = Act.getActivityInfo();
	//var test = [];
	//var test1 = {0=>activityInfo.currentHeartRate};
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
    	var properties = AppData.dict[AppData.chosenSport];
    	var size = properties.size();
    	var horniMez = App.getApp().getProperty(properties[size - 2]);
        var spodniMez = App.getApp().getProperty(properties[size - 1]);
    	
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
        
        AppData.disciplines[0].startDiscipline();
        recordingtimer = new Timer.Timer();
		recordingtimer.start( method(:recordingtimercallback), 100, true );
		//elapsedtime = 0;
		Pos.enableLocationEvents(Pos.LOCATION_CONTINUOUS, method(:position));
		Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    	Sensor.enableSensorEvents(method(:heartrate));
		
		/*switch (AppData.disciplines[0].chosenDiscipline) {
			case "beh":
				checkBeh();
				break;
			case "kolo":
				checkKolo();
				break;
			case "plavani":
				checkPlavani();
				break;
		}*/
    }

    function onShow() {
    	
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
        
        activityInfo = Act.getActivityInfo();
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(5);
        
        var actualDis = AppData.disciplines[AppData.actualDiscipline];
        
        if (actualDis instanceof Discipline) {
        	/** vypis casu u discipliny */
        	dc.drawText(50, 6, Gfx.FONT_MEDIUM, Functions.convertTime(Sys.getTimer() - AppData.disciplines[0].startTime)[1], Gfx.TEXT_JUSTIFY_LEFT);
        	/** vypis ostatnich informaci */
        	actualDis.drawInfo(dc);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}