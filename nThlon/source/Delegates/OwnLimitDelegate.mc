using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

/** Slouzi pro zpracovani zakladnich vstupu od uzivatele v OwnLimitPickeru */
class OwnLimitDelegate extends Ui.BehaviorDelegate {
	
	var ownLimitPicker;
	
    function initialize(ownLimitPicker) {
        BehaviorDelegate.initialize();
    	self.ownLimitPicker = ownLimitPicker;
    }

    function onLeftArrow() {
    	if (ownLimitPicker.chosenOne > 0) {
    		ownLimitPicker.chosenOne--;
    	} else {
    		ownLimitPicker.chosenOne = ownLimitPicker.options.size() - 1;
    	}
        return true;
    }
    
    function onRightArrow() {
    	if (ownLimitPicker.chosenOne < ownLimitPicker.options.size() - 1) {
    		ownLimitPicker.chosenOne++;
    	} else {
    		ownLimitPicker.chosenOne = 0;
    	}
        return true;
    }
    
    function onOK() {
    	if (ownLimitPicker.limit.length() < 3) {
    		ownLimitPicker.limit += ownLimitPicker.options[ownLimitPicker.chosenOne];
    	}
    }
    
    function onNotOK() {
    	if (ownLimitPicker.limit.length() > 0) {
    		ownLimitPicker.limit = ownLimitPicker.limit.substring(0, ownLimitPicker.limit.length() - 1);
    	}
    }
    
    function onBack() {
        Ui.popView(Ui.SLIDE_UP);
        return true;
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	if(ownLimitPicker.limit.length() != 0) {
            	var horniMez = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 2]);
            	var spodniMez = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 1]);
            	if (ownLimitPicker.type == 0 && (ownLimitPicker.limit.toNumber() > spodniMez.toNumber())) {
            		App.getApp().setProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 2], ownLimitPicker.limit);
            		Ui.popView(Ui.SLIDE_IMMEDIATE);
            	}
            	else if (ownLimitPicker.type == 1 && (ownLimitPicker.limit.toNumber() < horniMez.toNumber())) {
            		App.getApp().setProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 1], ownLimitPicker.limit);
            		Ui.popView(Ui.SLIDE_IMMEDIATE);
            	}
            }
        }
    }
}