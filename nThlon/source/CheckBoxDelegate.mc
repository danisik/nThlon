using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

var keyToSelectable = false;

class CheckBoxDelegate extends Ui.BehaviorDelegate {
	var list = null;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelectable(event) {
        var instance = event.getInstance();

        if(instance instanceof Checkbox) {
            currentView.checkBoxes.handleEvent(instance, event.getPreviousState());
        }
        return true;
    }

    function onMenu() {
        keyToSelectable = !keyToSelectable;
        currentView.setKeyToSelectableInteraction(keyToSelectable);
        return true;
    }

    function onNextPage() {
        return pushMenu(Ui.SLIDE_IMMEDIATE);
    }

    function pushMenu(slideDir) {
        var view = new ButtonView();
        var delegate = new ButtonDelegate();
        Ui.pushView(view, delegate, slideDir);
        return true;
    }

    function onKey(evt) {
        var key = evt.getKey();

        if (key == KEY_ENTER) {
        	for( var i = 0; i < AppData.checkBoxes.size(); i += 1 ) {
        		if (AppData.checkBoxes[i].getState() == :stateSelected) {
        			App.getApp().setProperty( AppData.dict[AppData.chosenDiscipline][i], true );
        		} else {
        			App.getApp().setProperty( AppData.dict[AppData.chosenDiscipline][i], false );
        		}
			}
            Sys.println(App.getApp().getProperty( AppData.behProperties[0]));//return pushMenu(Ui.SLIDE_IMMEDIATE);
        }

        return false;
    }
    
    function onBack() {
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
        Sys.println("ZMACKNUTO1");
        return true;
    }
}
