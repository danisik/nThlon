using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.System as Sys;
using Toybox.Application;
using Toybox.ActivityRecording;
using Toybox.Sensor;
using Toybox.Activity as Act;

/** Slouzi pro zpracovani zakladnich vstupu od uzivatele v pohledu: 
 *	
 *							nThlonView
 *  
 *
 */ 
class nThlonDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return true;
    }

	
	function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
            var oldDiscView = new OldDiscView();
        	var sizeOfListDisc = App.getApp().getProperty("sizeOfListDisc");
        	if (sizeOfListDisc == null) {
        		var stages = Discipline.stageNames;
       			var options = [stages[DISC_RUNNING], stages[DISC_CYCLING], stages[DISC_SWIMMING], stages[DISC_DEPO]];
		       	var picker = new OwnDiscPicker(options);
		       	var menu = new Rez.Menus.MainMenu();
       			Ui.switchToView(picker, new OwnDiscDelegate(picker), Ui.SLIDE_UP);
        	}
        	else {
        		Ui.switchToView(oldDiscView, new OldDiscViewDelegate(oldDiscView), Ui.SLIDE_UP);
        	}
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