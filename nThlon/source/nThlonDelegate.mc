using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application;
using Toybox.ActivityRecording;
using Toybox.Sensor;
using Toybox.Activity as Act;

/** Slouzi pro rekaci na tlacitka atp. v hlavnim view (nthlonview) */
class nThlonDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
       	/*Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    	Sensor.enableSensorEvents(method(:onSensor));*/
    }

    function onMenu() {
        //Ui.pushView(new Rez.Menus.MainMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

	function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	//var app = Application.getApp();
        	var options = [DISCIPLINE_RUNNING, DISCIPLINE_CYCLING, DISCIPLINE_SWIMMING, DISCIPLINE_DEPO];
        	var picker = new OwnDiscPicker(options);
        	var menu = new Rez.Menus.MainMenu();
        	//Ui.pushView(menu, new nThlonMenuDelegate(), Ui.SLIDE_UP);
        	//Ui.popView(Ui.SLIDE_UP);
        	Ui.switchToView(picker, new OwnDiscDelegate(picker), Ui.SLIDE_UP);
        	//Ui.switchToView(picker, new DisciplinePickerDelegate(picker), Ui.SLIDE_UP);
        	//Ui.requestUpdate();
        	//Ui.requestUpdate();
        	//Ui.requestUpdate();
        	//Ui.requestUpdate();
			return true;
        }
        return false;
    }
    
    function onBack() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return true;
    }
    
    function onTest() {
        var menu = new Rez.Menus.MainMenu();
        Ui.pushView(menu, new nThlonMenuDelegate(), Ui.SLIDE_UP);
        Ui.requestUpdate();
		return true;
    }
    
    function onSwipe(swipeEvent) {
        Sys.println(swipeEvent.getDirection());
    }
    
}