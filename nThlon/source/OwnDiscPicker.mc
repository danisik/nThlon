using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

class OwnDiscDelegate extends Ui.BehaviorDelegate {
	
	var ownDiscPicker;
	
    function initialize(ownDiscPicker) {
        BehaviorDelegate.initialize();
       	/*Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    	Sensor.enableSensorEvents(method(:onSensor));*/
    	self.ownDiscPicker = ownDiscPicker;
    }

    function onLeftArrow() {
    	if (ownDiscPicker.chosenOne > 0) {
    		ownDiscPicker.chosenOne--;
    	} else {
    		ownDiscPicker.chosenOne = ownDiscPicker.options.size() - 1;
    	}
        //Sys.println("LEFT");
        return true;
    }
    
    function onRightArrow() {
    	if (ownDiscPicker.chosenOne < ownDiscPicker.options.size() - 1) {
    		ownDiscPicker.chosenOne++;
    	} else {
    		ownDiscPicker.chosenOne = 0;
    	}
        return true;
    }
    
    function onOK() {
    	if (ownDiscPicker.order < 10) {
        		AppData.disciplines[ownDiscPicker.order] = new Discipline(ownDiscPicker.options[ownDiscPicker.chosenOne]);
        		ownDiscPicker.order++;
        }
    }
    
    function onNotOK() {
    	if (ownDiscPicker.order > 0) {
        		//AppData.disciplines[ownDiscPicker.order] = new Discipline(ownDiscPicker.options[ownDiscPicker.chosenOne]);
        		ownDiscPicker.order--;
        		AppData.disciplines.remove(ownDiscPicker.order); //= AppData.disciplines.slice(0, ownDiscPicker.order);
        }
    }
    
    function onBack() {
    	AppData.disciplines = {};
        Ui.switchToView(new nThlonView(), new nThlonDelegate(), Ui.SLIDE_UP);
        return true;
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	Ui.switchToView(new RecordingView(), new RecordingViewDelegate(), Ui.SLIDE_UP);
        }
    }
}

/** Hlavni view */
class OwnDiscPicker extends Ui.View {

	var options;
	var chosenOne = 0;
	var order = 0;
	
    function initialize(options) {
        View.initialize();
        self.options = options;
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
        dc.drawText(dc.getWidth() / 2, 2, Gfx.FONT_MEDIUM, (order + 1) + ". disciplina", Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 14, Gfx.FONT_MEDIUM, options[chosenOne], Gfx.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}