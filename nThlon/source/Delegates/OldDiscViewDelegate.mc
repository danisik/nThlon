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

class OldDiscViewDelegate extends Ui.BehaviorDelegate {
    var oldDiscView;
    
    function initialize(oldDiscView) {
        BehaviorDelegate.initialize();
        self.oldDiscView = oldDiscView;
        
        var disciplinesString = "discipline";
        var sizeOfListDisc = App.getApp().getProperty("sizeOfListDisc");
        var lastString = "";
        
        for (var i = 0; i < sizeOfListDisc; i++) {
            lastString = disciplinesString + "" + i;
            var disciplineName = App.getApp().getProperty(lastString);
            AppData.disciplines[i] = new Discipline(disciplineName); 
        }
    }

    function onMenu() {
        return true;
    }                             

	function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
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

    function onSwipe(swipeEvent) {
    	if (AppData.disciplines.size() > 5) {
    		if (swipeEvent.getDirection() == Ui.SWIPE_LEFT) {
    			oldDiscView.page = 1;
    		}
    		else if (swipeEvent.getDirection() == Ui.SWIPE_RIGHT) {
    			oldDiscView.page = 0;
    		}
    	}
    }
    
}