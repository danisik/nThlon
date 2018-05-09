using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

/** Slouzi pro reakci na itemy v menu slouzici pro prechod do nastaveni */
class nThlonMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }
	
    function onMenuItem(item) {
        if (item == :item_1) {
        	Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            AppData.chosenDiscipline = DISC_RUNNING;
        } else if (item == :item_2) {
            Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            AppData.chosenDiscipline = DISC_CYCLING;
        } else if (item == :item_3) {
        	Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            AppData.chosenDiscipline = DISC_SWIMMING;
            
        } else if (item == :pick_1) {
        	var options = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
        	var picker = new OwnLimitPicker(options, 0);
        	Ui.pushView(picker, new OwnLimitDelegate(picker), Ui.SLIDE_UP);
        } else if (item == :pick_2) {
        	var options = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
        	var picker = new OwnLimitPicker(options, 1);
        	Ui.pushView(picker, new OwnLimitDelegate(picker), Ui.SLIDE_UP);
        } else if (item == :pick_3) {
        	var chView = new CheckBoxView();
        	var chDel = new CheckBoxDelegate();
        	
        	chDel.list = chView.checkBoxes;
        	Ui.pushView(chView, chDel, Ui.SLIDE_UP);
        }
    }
    
    function onBack() {
        return true;
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	Sys.println("ZMACKNUTO");
        }
    }

}