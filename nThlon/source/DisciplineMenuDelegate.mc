using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

class DisciplineMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :dis_1) {
        	AppData.disciplines[AppData.disciplinesOrder] = "beh";
        	//Ui.pushView(new CheckBoxView(), new CheckBoxDelegate(), Ui.SLIDE_UP);
        	Ui.pushView(new Rez.Menus.DisciplineMenu(), new DisciplineMenuDelegate(), Ui.SLIDE_UP);
            //Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = "beh";
        } else if (item == :dis_2) {
        	AppData.disciplines[AppData.disciplines.size()] = "kolo";
            Ui.pushView(new Rez.Menus.DisciplineMenu(), new DisciplineMenuDelegate(), Ui.SLIDE_UP);
            AppData.chosenDiscipline = "kolo";
            Sys.println(AppData.chosenDiscipline);
        } else if (item == :dis_3) {
        	AppData.disciplines[AppData.disciplines.size()] = "plavani";
        	Ui.pushView(new Rez.Menus.DisciplineMenu(), new DisciplineMenuDelegate(), Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = "plavani";
            
        }
    }
    
    function onBack() {
    	//Ui.popView(Ui.SLIDE_IMMEDIATE);
        Sys.println("ZMACKNUTO2");
        return true;
    }

}