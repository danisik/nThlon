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
class FinalViewDelegate extends Ui.BehaviorDelegate {
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
    }
}

/** View ktere slouzi pro zobrazeni vsech dulezitych hodnot behem provadeni discpliny (napr. heartrate, rychlost atp.) */
class FinalView extends Ui.View {

    function initialize() {
        View.initialize();
    }


    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.TestLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	//dc.drawText(20, 20, Gfx.FONT_MEDIUM, elapsedtime, Gfx.TEXT_JUSTIFY_LEFT);
    }

    // Update the view
    function onUpdate(dc) {
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}