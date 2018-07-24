using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;
using Toybox.Attention;



class OldDiscView extends Ui.View {

	var page;
    function initialize() {
        View.initialize();
        self.page = 0;
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.TestLayout(dc));
    }

    function onShow() {
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    
    	var step;
    	
    	var toPage = 5;
    	
    	if (AppData.disciplines.size() < 6) {
    		toPage = AppData.disciplines.size();
    	}
    	
        if (page == 0) {
        	step = 0;
        }
        else {
        	step = 5;
        	toPage = AppData.disciplines.size();
        }
        
        dc.drawText(30, 6, Gfx.FONT_MEDIUM, "DISCIPLINY", Gfx.TEXT_JUSTIFY_LEFT);
        
        
        for (var i = step; i < toPage; i++) {
        	dc.drawText(65 , 40 + (i % 5) * (25), Gfx.FONT_TINY, Discipline.stageNames[AppData.disciplines[i].chosenDiscipline], Gfx.TEXT_JUSTIFY_LEFT);
        }
        
        
        dc.drawText(1, 180, Gfx.FONT_XTINY, "NOVY LIST", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(100, 180, Gfx.FONT_XTINY, "START", Gfx.TEXT_JUSTIFY_LEFT);
    }

    function onHide() {
    }

}
