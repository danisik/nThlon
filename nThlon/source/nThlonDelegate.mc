using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application;

class nThlonDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

	function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	Sys.println("ZMACKNUTO");
        	var app = Application.getApp();
        	
        	var array = {};
        	array[0] = "Ahoj";
        	Sys.println(array[0]);
        	array[1] = "Testtttt";
        	Sys.println(array[1]);
        	Sys.println(array.size());
//        	app.setProperty("number", );
        	//Ui.pushView(new Rez.Menus.MainMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
        	//Ui.switchToView( new MyHRField(), new AprojectDelegate(), Ui.SLIDE_UP );
        	var menu = new Rez.Menus.MainMenu();
        	//menu.setTitle("Ahoj");
        	//Ui.draw("Ahoj");
        	Ui.pushView(menu, new nThlonMenuDelegate(), Ui.SLIDE_UP);
        	Ui.requestUpdate();
			return true;
        }
    }
    
    function onBack() {
        Sys.println("ZMACKNUTO3");
        return true;
    }
    
    function onTest() {
        Sys.println("ZMACKNUTO");
        return true;
    }
    
    function onSwipe(swipeEvent) {
        Sys.println(swipeEvent.getDirection()); // e.g. SWIPE_RIGHT = 1
    }
}