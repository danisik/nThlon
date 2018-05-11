using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

/** Slouzi pro reakci na itemy v menu pro vyber disciplin (Discipline picker) */
class DisciplineMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :dis_1) {
        	AppData.disciplines[AppData.disciplinesOrder] = DISC_RUNNING;
        	//Ui.pushView(new CheckBoxView(), new CheckBoxDelegate(), Ui.SLIDE_UP);
        	Ui.pushView(new Rez.Menus.DisciplineMenu(), new DisciplineMenuDelegate(), Ui.SLIDE_UP);
            //Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = DISC_RUNNING;
        } else if (item == :dis_2) {
        	AppData.disciplines[AppData.disciplines.size()] = DISC_CYCLING;
            Ui.pushView(new Rez.Menus.DisciplineMenu(), new DisciplineMenuDelegate(), Ui.SLIDE_UP);
            AppData.chosenDiscipline = DISC_CYCLING;
            Sys.println(AppData.chosenDiscipline);
        } else if (item == :dis_3) {
        	AppData.disciplines[AppData.disciplines.size()] = DISC_SWIMMING;
        	Ui.pushView(new Rez.Menus.DisciplineMenu(), new DisciplineMenuDelegate(), Ui.SLIDE_UP);
            Sys.println(AppData.disciplines.size());
            AppData.chosenDiscipline = DISC_SWIMMING;
            
        }
        Sys.println(AppData.chosenDiscipline);
    }
    
    function onBack() {
    	//Ui.popView(Ui.SLIDE_IMMEDIATE);
        Sys.println("ZMACKNUTO2");
        return true;
    }

}