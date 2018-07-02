using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.System as Sys;
using Toybox.Application;
using Toybox.ActivityRecording;
using Toybox.Sensor;
using Toybox.Activity as Act;

class OldDiscViewDelegate extends Ui.BehaviorDelegate {
    
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return true;
    }                             

	function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
            //ukladani objektu vytazenych z OwnDiscPickeru ulozenych do promeny disciplineX, kde X je cislo aktualni discipliny, pocet disciplin je ulozen v promenne sizeOfListDisc
            var disciplinesString = "discipline";
            var sizeOfListDisc = App.getApp().getProperty("sizeOfListDisc");
            var lastString = "";
        
            for (var i = 0; i < sizeOfListDisc; i++) {
                lastString = disciplinesString + "" + i;
                var disciplineName = App.getApp().getProperty(lastString);
                AppData.disciplines[i] = new Discipline(disciplineName); 
            }
        
            Ui.switchToView(new RecordingView(), new RecordingViewDelegate(), Ui.SLIDE_UP);
        }
        
	}
	
	function onBack() {
		var stages = Discipline.stageNames;
       	var options = [stages[DISC_RUNNING], stages[DISC_CYCLING], stages[DISC_SWIMMING], stages[DISC_DEPO]];
       	var picker = new OwnDiscPicker(options);
       	var menu = new Rez.Menus.MainMenu();
       	Ui.switchToView(picker, new OwnDiscDelegate(picker), Ui.SLIDE_UP);
		return true;
	}
  
/*
	function onKey(key) {
  
        if (key.getKey() == Ui.KEY_ENTER) {
        	var stages = Discipline.stageNames;
        	var options = [stages[DISC_RUNNING], stages[DISC_CYCLING], stages[DISC_SWIMMING], stages[DISC_DEPO]];
        	var picker = new OwnDiscPicker(options);
        	var menu = new Rez.Menus.MainMenu();
        	Ui.switchToView(picker, new OwnDiscDelegate(picker), Ui.SLIDE_UP);
			    return true;
        }
        return false;
    }
    
    function onBack() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return true;
    }
*/    
    function onSwipe(swipeEvent) {
        Sys.println(swipeEvent.getDirection());
    }
    
}