using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.Activity as Act;
using Toybox.ActivityRecording as Rec;
using Toybox.Position as Pos;
using Toybox.System as Sys;
using Toybox.Timer as Timer;
using Toybox.Sensor as Sensor;

/** View ktere slouzi pro zobrazeni vsech dulezitych hodnot behem provadeni discpliny (napr. heartrate, rychlost atp.) */
class FinalView extends Ui.View {
	var page;
	
    function initialize() {
        View.initialize();
        self.page = 0;
    }


    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.TestLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	//dc.drawText(20, 20, Gfx.FONT_MEDIUM, elapsedtime, Gfx.TEXT_JUSTIFY_LEFT);
    }

    // Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    	
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    
    	var sizeOfListDisc = App.getApp().getProperty("sizeOfListDisc");
    
    	var step;
    	
    	var toPage = 5;
    	
    	if (sizeOfListDisc < 6) {
    		toPage = sizeOfListDisc;
    	}
    	
        if (page == 0) {
        	step = 0;
        }
        else {
        	step = 5;
        	toPage = sizeOfListDisc;
        }
        
        dc.drawBitmap(1, 1, Ui.loadResource(Rez.Drawables.FinalIcon));
        dc.drawText(50, 6, Gfx.FONT_MEDIUM, "FINISH", Gfx.TEXT_JUSTIFY_LEFT);
        
        for (var i = step; i < toPage; i++) {
        	dc.drawText(1 , 50 + (i % 5) * (30), Gfx.FONT_MEDIUM, Discipline.stageNames[AppData.disciplines[i].chosenDiscipline] + ": " +Functions.convertTime(AppData.disciplines[i].endTime - AppData.disciplines[i].startTime)[1], Gfx.TEXT_JUSTIFY_LEFT);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}