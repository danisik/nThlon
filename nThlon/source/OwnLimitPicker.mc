using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

class OwnLimitDelegate extends Ui.BehaviorDelegate {
	
	var ownLimitPicker;
	
    function initialize(ownLimitPicker) {
        BehaviorDelegate.initialize();
       	/*Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    	Sensor.enableSensorEvents(method(:onSensor));*/
    	self.ownLimitPicker = ownLimitPicker;
    }

    function onLeftArrow() {
    	if (ownLimitPicker.chosenOne > 0) {
    		ownLimitPicker.chosenOne--;
    	} else {
    		ownLimitPicker.chosenOne = ownLimitPicker.options.size() - 1;
    	}
        //Sys.println("LEFT");
        return true;
    }
    
    function onRightArrow() {
    	if (ownLimitPicker.chosenOne < ownLimitPicker.options.size() - 1) {
    		ownLimitPicker.chosenOne++;
    	} else {
    		ownLimitPicker.chosenOne = 0;
    	}
        return true;
    }
    
    function onOK() {
    	if (ownLimitPicker.limit.length() < 3) {
    		ownLimitPicker.limit += ownLimitPicker.options[ownLimitPicker.chosenOne];
    	}
    }
    
    function onNotOK() {
    	Sys.println("WHAT??");
    	if (ownLimitPicker.limit.length() > 0) {
    		Sys.println("WHAT1??");
    		ownLimitPicker.limit = ownLimitPicker.limit.substring(0, ownLimitPicker.limit.length() - 1);
    	}
    }
    
    function onBack() {
        Ui.popView(Ui.SLIDE_UP);
        return true;
    }
    
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	if(ownLimitPicker.limit.length() != 0) {
            	var horniMez = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 2]);
            	var spodniMez = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 1]);
            	if (ownLimitPicker.type == 0 && (ownLimitPicker.limit.toNumber() > spodniMez.toNumber())) {
            		App.getApp().setProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 2], ownLimitPicker.limit);
            		Ui.popView(Ui.SLIDE_IMMEDIATE);
            	}
            	else if (ownLimitPicker.type == 1 && (ownLimitPicker.limit.toNumber() < horniMez.toNumber())) {
            		App.getApp().setProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 1], ownLimitPicker.limit);
            		Ui.popView(Ui.SLIDE_IMMEDIATE);
            	}
                //App.getApp().deleteProperty("string");
            }
        }
    }
    
    function onDusk() {
    	Sys.println("FK");
    }
}

/** Hlavni view */
class OwnLimitPicker extends Ui.View {

	var options;
	var chosenOne = 0;
	var order = 0;
	var limit = "";
	var type = 0; // 0 = horni, 1 = spodni
	
    function initialize(options, type) {
        View.initialize();
        self.options = options;
        self.type = type;
        if (type == 0) {
        	limit = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 2]);
        } else if (type == 1) {
        	limit = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 1]);
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