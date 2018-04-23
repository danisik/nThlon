using Toybox.Lang;

module Functions {
	function convertSpeed(speed) {
		var units = "min/km";
		if (speed == null) {
			return {0=>units, 1=>-1.0};
		}
		if (speed == 0) {
			return {0=>units, 1=>-1.0};
		}
		var convertedSpeed = 16.67 / speed;
		
		return 	{0=>units, 1=>convertedSpeed};
	}
	
	function convertDistance(distance) {
		var units = "km";
		if (distance == null) {
			return {0=>units, 1=>-1.0};
		}
		if (distance == 0) {
			return {0=>units, 1=>-1.0};
		}
		
		var convertedDist = distance / 1000;
		
		return {0=>units, 1=>convertedDist};
	}
	
	function convertTime(time) {
		var units = "";
		if (time == null) {
			return {0=>units, 1=>-1.0};
		}
		if (time == 0) {
			return {0=>units, 1=>-1.0};
		}
		
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
	
	function convertAscent(ascent) {
		var units = "m";
		if (ascent == null) {
			return {0=>units, 1=>-1.0};
		}
		if (ascent == 0) {
			return {0=>units, 1=>-1.0};
		}
		
		return {0=>units, 1=>ascent};
	}
}