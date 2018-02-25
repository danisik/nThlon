using Toybox.WatchUi as Ui;

class nThlonDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new nThlonMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }

}