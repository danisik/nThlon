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

/** Slouzi pro zpracovani zakladnich vstupu od uzivatele ve FinalView */
class FinalViewDelegate extends Ui.BehaviorDelegate {
	var finalView;

	function initialize(finalView) {
        BehaviorDelegate.initialize();
        self.finalView = finalView;
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	Ui.popView(Ui.SLIDE_RIGHT);
        }
        
    }
    
    function onSwipe(swipeEvent) {
    	if (AppData.disciplines.size() > 5) {
    		if (swipeEvent.getDirection() == Ui.SWIPE_LEFT) {
    			finalView.page = 1;
    		}
    		else if (swipeEvent.getDirection() == Ui.SWIPE_RIGHT) {
    			finalView.page = 0;
    		}
    	}
    }
}