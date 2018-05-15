using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

/** Slouzi pro zpracovani zakladnich vstupu od uzivatele v OwnDiscPickeru */
class OwnDiscDelegate extends Ui.BehaviorDelegate {
	
	var ownDiscPicker;
	
    function initialize(ownDiscPicker) {
        BehaviorDelegate.initialize();
    	self.ownDiscPicker = ownDiscPicker;
    }

    function onLeftArrow() {
    	if (ownDiscPicker.chosenOne > 0) {
    		ownDiscPicker.chosenOne--;
    	} else {
    		ownDiscPicker.chosenOne = ownDiscPicker.options.size() - 1;
    	}
        return true;
    }
    
    function onRightArrow() {
    	if (ownDiscPicker.chosenOne < ownDiscPicker.options.size() - 1) {
    		ownDiscPicker.chosenOne++;
    	} else {
    		ownDiscPicker.chosenOne = 0;
    	}
        return true;
    }
    
    function onOK() {
    	if (ownDiscPicker.order < 10) {
        		AppData.disciplines[ownDiscPicker.order] = new Discipline(ownDiscPicker.options[ownDiscPicker.chosenOne]);
        		ownDiscPicker.order++;
        }
    }
    
    function onNotOK() {
    	if (ownDiscPicker.order > 0) {
        		//AppData.disciplines[ownDiscPicker.order] = new Discipline(ownDiscPicker.options[ownDiscPicker.chosenOne]);
        		ownDiscPicker.order--;
        		AppData.disciplines.remove(ownDiscPicker.order); //= AppData.disciplines.slice(0, ownDiscPicker.order);
        }
    }
    
    function onBack() {
    	AppData.disciplines = {};
        Ui.switchToView(new nThlonView(), new nThlonDelegate(), Ui.SLIDE_UP);
        return true;
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER && ownDiscPicker.order > 0) {
        	Ui.switchToView(new RecordingView(), new RecordingViewDelegate(), Ui.SLIDE_UP);
        }
    }
}