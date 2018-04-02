using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
////
class nThlonView extends Ui.View {
	static var pom = -1;
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	pom++;
    	if (pom == 0) {
    		setLayout(Rez.Layouts.StartLayout(dc));
    	}
       	else if (pom == 1) {
       		setLayout(Rez.Layouts.MainLayout(dc));
       	}
       	else if (pom == 2) {
       		setLayout(Rez.Layouts.DepoLayout(dc));
       	}
       	else if (pom == 3) {
       		setLayout(Rez.Layouts.SecondLayout(dc));
       	}
       	else if (pom == 4) {
       		setLayout(Rez.Layouts.DepoLayout(dc));
       	}
       	else if (pom == 5) {
       		setLayout(Rez.Layouts.ThirdLayout(dc));
       	}
       	else if (pom == 6) {
       		setLayout(Rez.Layouts.FinalLayout(dc));
       		pom = -1;
       	}
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
