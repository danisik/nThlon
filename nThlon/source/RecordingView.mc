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

class RecordingView extends Ui.View {
	var recordingtimer;
	var elapsedtime = 55;

    function initialize() {
        View.initialize();
    }

	function recordingtimercallback()
    {
    	elapsedtime++;
    	dc.drawText(20, 20, Gfx.FONT_MEDIUM, "Ahojjjjjjjjjjj", Gfx.TEXT_JUSTIFY_LEFT);
        Ui.requestUpdate();
        dc.drawText(20, 20, Gfx.FONT_MEDIUM, "Ahojjjjjjjjjjj", Gfx.TEXT_JUSTIFY_LEFT);
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.SecondLayout(dc));
        dc.drawText(20, 20, Gfx.FONT_MEDIUM, "Ahojjjjjjjjjjj", Gfx.TEXT_JUSTIFY_LEFT);
        /*recordingtimer = new Timer.Timer();
		recordingtimer.start( method(:recordingtimercallback), 100, true );
		elapsedtime = 0;*/
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	//dc.drawText(20, 20, Gfx.FONT_MEDIUM, elapsedtime, Gfx.TEXT_JUSTIFY_LEFT);
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.drawText(20, 20, Gfx.FONT_MEDIUM, AppData.elpTime, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 40, Gfx.FONT_MEDIUM, AppData.speed, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 60, Gfx.FONT_MEDIUM, AppData.avgSpeed, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 80, Gfx.FONT_MEDIUM, AppData.elpDist, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 100, Gfx.FONT_MEDIUM, AppData.heartRate, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 120, Gfx.FONT_MEDIUM, AppData.avgHrt, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 140, Gfx.FONT_MEDIUM, AppData.ascent, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 160, Gfx.FONT_MEDIUM, AppData.currEl, Gfx.TEXT_JUSTIFY_LEFT);
        /*dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_BLACK);
        dc.drawText(20, 20, Gfx.FONT_MEDIUM, AppData.heartRate, Gfx.TEXT_JUSTIFY_LEFT);*/
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
}