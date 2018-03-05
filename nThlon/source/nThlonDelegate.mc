using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class nThlonDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
        //Sys.println("item 2");
        return true;
    }

	function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	Sys.println("ZMACKNUTO");
        }
    }

	function onBack() {
        // Do not quit if activity is running
        Sys.println("VYPNUTI");
        return false;
    }
}