using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

class nThlonMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :item_1) {
        	AppData.disciplines[AppData.disciplines.size()] = "item1";
        	//Ui.pushView(new CheckBoxView(), new CheckBoxDelegate(), Ui.SLIDE_UP);
        	Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = "beh";
        } else if (item == :item_2) {
        	AppData.disciplines[AppData.disciplines.size()] = "item2";
            Sys.println(AppData.disciplines.size());
            Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            AppData.chosenDiscipline = "kolo";
            Sys.println(AppData.chosenDiscipline);
        } else if (item == :item_3) {
        	AppData.disciplines[AppData.disciplines.size()] = "item2";
        	Ui.pushView(new Rez.Menus.PickMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = "plavani";
            
        } else if (item == :pick_1) {
        	var chView = new CheckBoxView();
        	var chDel = new CheckBoxDelegate();
        	
        	chDel.list = chView.checkBoxes;
        	AppData.disciplines[AppData.disciplines.size()] = "item2";
        	Ui.pushView(chView, chDel, Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
            Sys.println(App.getApp().getProperty( AppData.behProperties[0]));
        } else if (item == :pick_2) {
        	AppData.disciplines[AppData.disciplines.size()] = "item2";
        	var picker = new LimitPicker();
        	Ui.pushView(picker, new LimitPickerDelegate(picker), Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
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