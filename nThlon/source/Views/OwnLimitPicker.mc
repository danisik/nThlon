using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

/** Hlavni view */
class OwnLimitPicker extends Ui.View {

	/** moznosti vyberu - tedy cisla */
	var options;
	/** vybrane cislo */
	var chosenOne = 0;
	//var order = 0;
	var limit = "";
	var type = 0; // 0 = horni, 1 = spodni
	
    function initialize(options, type) {
        View.initialize();
        self.options = options;
        self.type = type;
        var properties = AppData.dict[AppData.chosenDiscipline];
    	var size = properties.size();
        if (type == 0) {
        	limit = App.getApp().getProperty(properties[size - 2]);
        } else if (type == 1) {
        	limit = App.getApp().getProperty(properties[size - 1]);
        }
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.SecondLayout(dc));
        
        /*recordingtimer = new Timer.Timer();
		recordingtimer.start( method(:recordingtimercallback), 100, true );
		elapsedtime = 0;*/
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
        
        var leftArrow = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.leftArrow,
            :locX=>3,
            :locY=>91
        });
        
        var rightArrow = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.rightArrow,
            :locX=>134,
            :locY=>91
        });
        
        var okButt = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.OK,
            :locX=>89,
            :locY=>155
        });
        
        var notOkButt = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.NOTOK,
            :locX=>15,
            :locY=>155
        });
        //myBitmap.draw(dc);
        leftArrow.draw(dc);
        rightArrow.draw(dc);
        okButt.draw(dc);
        notOkButt.draw(dc);
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 2, Gfx.FONT_MEDIUM, limit, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 14, Gfx.FONT_MEDIUM, options[chosenOne], Gfx.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}