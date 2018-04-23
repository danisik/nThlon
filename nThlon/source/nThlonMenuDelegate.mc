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
        	//AppData.disciplines[AppData.disciplines.size()] = "item1";
        	//Ui.pushView(new CheckBoxView(), new CheckBoxDelegate(), Ui.SLIDE_UP);
        	Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = "beh";
        } else if (item == :item_2) {
        	//AppData.disciplines[AppData.disciplines.size()] = "item2";
            Sys.println(AppData.disciplines.size());
            Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            AppData.chosenDiscipline = "kolo";
            Sys.println(AppData.chosenDiscipline);
        } else if (item == :item_3) {
        	//AppData.disciplines[AppData.disciplines.size()] = "item2";
        	Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = "plavani";
            
        } else if (item == :pick_1) {
        	var options = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
        	var picker = new OwnLimitPicker(options, 0);
        	Ui.pushView(picker, new OwnLimitDelegate(picker), Ui.SLIDE_UP);
        } else if (item == :pick_2) {
        	//AppData.disciplines[AppData.disciplines.size()] = "item2";
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
    	//Ui.popView(Ui.SLIDE_IMMEDIATE);
        Sys.println("ZMACKNUTO2");
        return true;
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	Sys.println("ZMACKNUTO");
        }
    }

}