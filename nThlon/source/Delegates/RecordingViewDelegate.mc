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

/** Slouzi pro rekaci na tlacitka atp. v RecordingView */
class RecordingViewDelegate extends Ui.BehaviorDelegate {
	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	
        	AppData.disciplines[AppData.actualDiscipline].endDiscipline();
        	AppData.actualDiscipline += 1;
        	var sizeOfListDisc = App.getApp().getProperty("sizeOfListDisc");
        	if (sizeOfListDisc > AppData.actualDiscipline) {
        		AppData.disciplines[AppData.actualDiscipline].startDiscipline();
        	}
        	else {
        		var finalView = new FinalView();
        		
        		Ui.switchToView(finalView, new FinalViewDelegate(finalView), Ui.SLIDE_UP);
        		
        	}
        }
        
    }
    
    function onSwipe(swipeEvent) {
    	if (swipeEvent.getDirection() == Ui.SWIPE_DOWN) {
    		var arr = AppData.disciplines[AppData.actualDiscipline].arr;
    		var posun = AppData.disciplines[AppData.actualDiscipline].posun;
    		if (AppData.biggerInfo < arr.size() - 1) {
    			arr[AppData.biggerInfo] = 0;
    			posun[AppData.biggerInfo - 1] = Gfx.FONT_MEDIUM;
    			posun[AppData.biggerInfo] = Gfx.FONT_SYSTEM_NUMBER_MEDIUM;
    			AppData.biggerInfo += 1;
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
    		}
    	}
    }
}