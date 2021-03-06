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

module Functions {
	var infoX = 1;
	var infoY = 40;
	
	/** heart rate */
	var hr = 0;
	/** position */
	var pos = 0;
	
	/** pro chybny vypis hodnot */
	var error = "---";
	
	/** prevede rychlost m/s na min/km */
	function convertSpeedRunning(speed) {
		var units = "min/km";
		if (speed == null) {
			return {0=>units, 1=>error, 2=>error};
		}
		if (speed == 0) {
			return {0=>units, 1=>error, 2=>error};
		}
		var tmpConvertedSpeed = 16.67 / speed;
		var convertedSpeed = tmpConvertedSpeed.toNumber();

		var tmpResidue = (tmpConvertedSpeed - convertedSpeed) * 100;

		var residue = tmpResidue.toLong() % 60;
		
		var addition = tmpResidue / 60;

		convertedSpeed += addition.toNumber();
		//convertedSpeed.toNumber()
		
		return 	{0=>units, 1=>convertedSpeed, 2=>residue.format("%02d")};
	}
	
	/** prevede m/s na km/h */
	function convertSpeedCycling(speed) {
		var units = "km/h";
		if (speed == null) {
			return {0=>units, 1=>error};
		}
		if (speed == 0) {
			return {0=>units, 1=>error};
		}
		var convertedSpeed = speed * 3.6;
		
		return 	{0=>units, 1=>convertedSpeed.format("%.2f")};
	}
	
	/** prevede m/s na m:s/100m */
	function convertSpeedSwimming(speed) {
		var units = "/100m";
		if (speed == null) {
			return {0=>units, 1=>error};
		}
		if (speed == 0) {
			return {0=>units, 1=>error};
		}
		var convertedSpeed = 100 / speed;
		
		var minutes = convertedSpeed / 60;
		minutes = minutes.toNumber();
		var seconds = (convertedSpeed - minutes * 60);
		seconds = seconds.toNumber();
		
		var myTime = Lang.format(
    	"$1$:$2$",
   		 [minutes.format("%02d"), seconds.format("%02d")]
		);
		
		return 	{0=>units, 1=>myTime};
	}
	
	/** prevede m na km */
	function convertDistance(distance) {
		var units = "km";
		if (distance == null) {
			return {0=>units, 1=>error};
		}
		if (distance == 0) {
			return {0=>units, 1=>error};
		}
		
		var convertedDist = distance / 1000;
		
		return {0=>units, 1=>convertedDist.format("%.2f")};
	}
	
	/** m na m - nejedna se tedy o prevod, jen kontrolu */
	function convertDistanceSwimming(distance) {
		var units = "m";
		if (distance == null) {
			return {0=>units, 1=>error};
		}
		if (distance == 0) {
			return {0=>units, 1=>error};
		}
		
		var convertedDist = distance;
		
		return {0=>units, 1=>convertedDist};
	}
	
	/** prevede ms na h:m:s */
	function convertTime(time) {
		var units = "";
		if (time == null) {
			return {0=>units, 1=>error};
		}
		if (time == 0) {
			return {0=>units, 1=>error};
		}
		
		time = time.toNumber();
		var convertedTime = time / 1000;
		
		time = time / 1000;
		time = time.toNumber();
		
		var hours = time / 3600;
		hours = hours.toNumber();
		var minutes = (time - hours * 3600) / 60;
		minutes = minutes.toNumber();
		var seconds = (time - hours * 3600 - minutes * 60);
		seconds = seconds.toNumber();
		
		var myTime = Lang.format(
    	"$1$:$2$:$3$",
   		 [hours.format("%02d"), minutes.format("%02d"), seconds.format("%02d")]
		);
		
		return {0=>units, 1=>myTime};
	}
	
	/** nastoupane metry neprevadi, jedna se jen o kontrolu */
	function convertAscent(ascent) {
		var units = "m";
		if (ascent == null) {
			return {0=>units, 1=>error};
		}
		if (ascent == 0) {
			return {0=>units, 1=>error};
		}
		
		return {0=>units, 1=>ascent.format("%.2f")};
	}
	
	/** neprevadi, jedna se jen o kontrolu */
	function convertHeartRate(heartRate) {
		var units = "bpm";
		
		if (heartRate == null) {
			return {0=>units, 1=>error};
		}
		if (heartRate == 0) {
			return {0=>units, 1=>error};
		}
		
		return {0=>units, 1=>heartRate};
	}
	
	function checkLimitRunning() {
		var horniMez = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 2]);
        var spodniMez = App.getApp().getProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 1]);	
	}
	
	function checkLimitCycling() {
		
	}
	function checkLimitSwimming() {
		
	}
	
	/** slouzi pro vykresleni hodnot behu */
	function drawInfoBeh(dc) {
		//Sys.println(Gfx.getFontHeight(Gfx.FONT_MEDIUM));
		var properties = AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline];
		
		var arr = AppData.disciplines[AppData.actualDiscipline].arr;
		var posun = AppData.disciplines[AppData.actualDiscipline].posun;
		var x = 1;
		var y = 29;
		var bigger = 1;
		
		var discipline = AppData.disciplines[AppData.actualDiscipline];
		dc.drawBitmap(1, 1, Ui.loadResource(discipline.stageIcons[0]));
		
		var vel1 = Gfx.getFontHeight(Gfx.FONT_SYSTEM_NUMBER_MEDIUM);
		var vel2 = Gfx.getFontHeight(Gfx.FONT_MEDIUM);
		
		var gpsinfo = Pos.getInfo();
		
		var activityInformations;
		var hodnota;
		var hodnotaFloat;
		var jednotka;
		
		var normalFont = Gfx.FONT_MEDIUM;
		var biggerFont;
		var offset;
		var textJustifyLeft = Gfx.TEXT_JUSTIFY_LEFT;
		var textJustifyRight = Gfx.TEXT_JUSTIFY_RIGHT;
		var fontShift = 21;
		var activity = Act.getActivityInfo();
		var displayWidth = dc.getWidth();
		var unitPosition = displayWidth - 1;
		var font;
		var averageActivityInformations;
		var averageHodnota;
		var averageOffset;
		
		if (App.getApp().getProperty(properties[0])) {
			activityInformations = Functions.convertTime(activity.elapsedTime);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		//dc.drawText(x, y + 25 * arr[bigger - 1], posun[bigger - 1], Functions.convertSpeedRunning(Act.getActivityInfo().currentSpeed)[1].format("%.2f"), Gfx.TEXT_JUSTIFY_LEFT);
    		y += fontShift;
    		bigger++;
    	}
		if (App.getApp().getProperty(properties[4])) {
			activityInformations = Functions.convertHeartRate(hr);
			averageActivityInformations = Functions.convertHeartRate(activity.averageHeartRate);
			hodnota = activityInformations[HODNOTA];
			averageHodnota = averageActivityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			averageOffset = 25 * arr[bigger];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		dc.drawText(x, y + averageOffset, normalFont, "prum.  ( " + averageHodnota + " )", textJustifyLeft);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[3])) {
    		activityInformations = Functions.convertSpeedRunning(activity.currentSpeed);
			averageActivityInformations = Functions.convertSpeedRunning(activity.averageSpeed);
			hodnota = activityInformations[HODNOTA];
			averageHodnota = averageActivityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			hodnotaFloat = activityInformations[2];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			averageOffset = 25 * arr[bigger];
		
    		dc.drawText(x, y + offset, font, hodnota + ":" + hodnotaFloat, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		dc.drawText(x, y + averageOffset, normalFont, "prum.  ( " + averageHodnota + " )", textJustifyLeft);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[1])) {
    		activityInformations = Functions.convertDistance(activity.elapsedDistance);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[2])) {
    		activityInformations = Functions.convertAscent(activity.totalAscent);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		bigger++;
    	}
    	
	}
	
	/** slouzi pro vykresleni hodnot kola */
	function drawInfoKolo(dc) {
		var properties = AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline];
		
		var arr = AppData.disciplines[AppData.actualDiscipline].arr;
		var posun = AppData.disciplines[AppData.actualDiscipline].posun;
		var x = 1;
		var y = 29;
		var bigger = 1;
		
		var discipline = AppData.disciplines[AppData.actualDiscipline];
		dc.drawBitmap(1, 1, Ui.loadResource(discipline.stageIcons[1]));
		
		var vel1 = Gfx.getFontHeight(Gfx.FONT_SYSTEM_NUMBER_MEDIUM);
		var vel2 = Gfx.getFontHeight(Gfx.FONT_MEDIUM);
		
		var gpsinfo = Pos.getInfo();
		
		var activityInformations;
		var hodnota;
		var jednotka;
		
		var normalFont = Gfx.FONT_MEDIUM;
		var biggerFont;
		var offset;
		var textJustifyLeft = Gfx.TEXT_JUSTIFY_LEFT;
		var textJustifyRight = Gfx.TEXT_JUSTIFY_RIGHT;
		var fontShift = 21;
		var activity = Act.getActivityInfo();
		var displayWidth = dc.getWidth();
		var unitPosition = displayWidth - 1;
		var font;
		var averageActivityInformations;
		var averageHodnota;
		var averageOffset;
		
		if (App.getApp().getProperty(properties[0])) {
			activityInformations = Functions.convertTime(activity.elapsedTime);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		//dc.drawText(x, y + 25 * arr[bigger - 1], posun[bigger - 1], Functions.convertSpeedRunning(Act.getActivityInfo().currentSpeed)[1].format("%.2f"), Gfx.TEXT_JUSTIFY_LEFT);
    		y += fontShift;
    		bigger++;
    	}
		if (App.getApp().getProperty(properties[4])) {
			activityInformations = Functions.convertHeartRate(hr);
			averageActivityInformations = Functions.convertHeartRate(activity.averageHeartRate);
			hodnota = activityInformations[HODNOTA];
			averageHodnota = averageActivityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			averageOffset = 25 * arr[bigger];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		dc.drawText(x, y + averageOffset, normalFont, "prum.  ( " + averageHodnota + " )", textJustifyLeft);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[3])) {
    		activityInformations = Functions.convertSpeedCycling(activity.currentSpeed);
			averageActivityInformations = Functions.convertSpeedCycling(activity.averageSpeed);
			hodnota = activityInformations[HODNOTA];
			averageHodnota = averageActivityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			averageOffset = 25 * arr[bigger];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		dc.drawText(x, y + averageOffset, normalFont, "prum.  ( " + averageHodnota + " )", textJustifyLeft);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[1])) {
    		activityInformations = Functions.convertDistance(activity.elapsedDistance);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[2])) {
    		activityInformations = Functions.convertAscent(activity.totalAscent);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		bigger++;
    	}
	}
	
	/** slouzi pro vykresleni hodnot plavani */
	function drawInfoPlavani(dc) {
		var properties = AppData.dict[AppData.disciplines[AppData.actualDiscipline].chosenDiscipline];
		
		var arr = AppData.disciplines[AppData.actualDiscipline].arr;
		var posun = AppData.disciplines[AppData.actualDiscipline].posun;
		var x = 1;
		var y = 29;
		var bigger = 1;
		
		var discipline = AppData.disciplines[AppData.actualDiscipline];
		dc.drawBitmap(1, 1, Ui.loadResource(discipline.stageIcons[2]));
		
		var vel1 = Gfx.getFontHeight(Gfx.FONT_SYSTEM_NUMBER_MEDIUM);
		var vel2 = Gfx.getFontHeight(Gfx.FONT_MEDIUM);
		
		var gpsinfo = Pos.getInfo();
		
		var activityInformations;
		var hodnota;
		var jednotka;
		
		var normalFont = Gfx.FONT_MEDIUM;
		var biggerFont;
		var offset;
		var textJustifyLeft = Gfx.TEXT_JUSTIFY_LEFT;
		var textJustifyRight = Gfx.TEXT_JUSTIFY_RIGHT;
		var fontShift = 21;
		var activity = Act.getActivityInfo();
		var displayWidth = dc.getWidth();
		var unitPosition = displayWidth - 1;
		var font;
		var averageActivityInformations;
		var averageHodnota;
		var averageOffset;
		
		if (App.getApp().getProperty(properties[0])) {
			activityInformations = Functions.convertTime(activity.elapsedTime);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		y += fontShift;
    		bigger++;
    	}
		if (App.getApp().getProperty(properties[3])) {
			activityInformations = Functions.convertHeartRate(hr);
			averageActivityInformations = Functions.convertHeartRate(activity.averageHeartRate);
			hodnota = activityInformations[HODNOTA];
			averageHodnota = averageActivityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			averageOffset = 25 * arr[bigger];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		dc.drawText(x, y + averageOffset, normalFont, "prum.  ( " + averageHodnota + " )", textJustifyLeft);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[2])) {
    		activityInformations = Functions.convertSpeedSwimming(activity.currentSpeed);
			averageActivityInformations = Functions.convertSpeedSwimming(activity.averageSpeed);
			hodnota = activityInformations[HODNOTA];
			averageHodnota = averageActivityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			Sys.println(posun.size());
			Sys.println(bigger - 1);
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
			averageOffset = 25 * arr[bigger];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		dc.drawText(x, y + averageOffset, normalFont, "prum.  ( " + averageHodnota + " )", textJustifyLeft);
    		y += fontShift;
    		bigger++;
    	}
    	if (App.getApp().getProperty(properties[1])) {
    		activityInformations = Functions.convertDistance(activity.elapsedDistance);
			hodnota = activityInformations[HODNOTA];
			jednotka = activityInformations[JEDNOTKA];
			font = posun[bigger - 1];
			offset = 25 * arr[bigger - 1];
		
    		dc.drawText(x, y + offset, font, hodnota, textJustifyLeft);
    		dc.drawText(unitPosition, y + offset, normalFont, jednotka, textJustifyRight);
    		y += fontShift;
    		bigger++;
    	}
	}
	
	/** slouzi pro vykresleni hodnot v depu */
	function drawInfoDepo(dc) {
		var discipline = AppData.disciplines[AppData.actualDiscipline];
		dc.drawBitmap(1, 1, Ui.loadResource(discipline.stageIcons[3]));
		
		var x = 1;
		var y = 40;
		
		dc.drawText(x, y,  Gfx.FONT_SYSTEM_NUMBER_MEDIUM, Functions.convertTime(Act.getActivityInfo().elapsedTime)[HODNOTA], Gfx.TEXT_JUSTIFY_LEFT);
	}
	
	/** vraci typ fontu */
	function getFont(step) {
		if (AppData.biggerInfo == step) {
			return Gfx.FONT_SYSTEM_NUMBER_MEDIUM;
		}
		else {
			return Gfx.FONT_MEDIUM;
		}
		 
	}
}