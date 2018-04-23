using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

/** Picker pro vyber disciplin ktere uzivatel bude vykonavat */
class DisciplinePicker extends Ui.Picker {
    const mCharacterSet = "0123456789";
    hidden var mTitleText;
    hidden var mFactory;
	var order = 0;

    function initialize() {
    	var disciplines = ["Beh", "Kolo", "Plavani", "Depo"];
        //mFactory = new CharacterFactory(mCharacterSet, {:addOk=>true});
        mFactory = new WordFactory(disciplines, {:addOk=>true, :font=>Gfx.FONT_MEDIUM});
        mTitleText = "";

        var string = (order + 1) + ". disciplina";
        
        var defaults = null;
        var titleText = Rez.Strings.stringPickerTitle;

        if(string != null) {
            mTitleText = string;
            titleText = string;
            //defaults = [mFactory.getIndex(string.substring(string.length()-1, string.length()))];
        }

        mTitle = new Ui.Text({:text=>titleText, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});

        Picker.initialize({:title=>mTitle, :pattern=>[mFactory]});                        
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

    function addCharacter() {
    	order = order + 1;
        mTitleText = (order + 1) + ". disciplina";
        mTitle.setText(mTitleText);
    }

    function removeCharacter() {
    	order = order - 1;
        mTitleText = (order + 1) + ". disciplina";
		mTitle.setText(mTitleText);
        /*if(0 == mTitleText.length()) {
            mTitle.setText(Ui.loadResource(Rez.Strings.stringPickerTitle));
        }
        else {
            mTitle.setText(mTitleText);
        }*/
    }

    function getTitle() {
        return mTitleText.toString();
    }

    function getTitleLength() {
        return mTitleText.length();
    }

    function isDone(value) {
        return mFactory.isDone(value);
    }
    
    function getOrder() {
    	return order;
    }
}

/** Slouzi pro reakci na potvrzeni nebo zruseni vyberu v discipline pickeru*/
class DisciplinePickerDelegate extends Ui.PickerDelegate {
    hidden var mPicker;

    function initialize(picker) {
        PickerDelegate.initialize();
        mPicker = picker;
    }

    function onCancel() {
        if(0 == mPicker.getOrder()) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        }
        else {
            mPicker.removeCharacter();
        }
    }

    function onAccept(values) {
    	Sys.println(values[0]);
        if(!mPicker.isDone(values[0])) {
        	if (mPicker.order < 10) {
        		AppData.disciplines[mPicker.order] = new Discipline(values[0]);
            	mPicker.addCharacter();
            }
        }
        else {
        	if (mPicker.order != 0) {
        		Ui.popView(Ui.SLIDE_IMMEDIATE);
        		for( var i = 0; i < AppData.disciplines.size(); i += 1 ) {
    				Sys.println("Sport: " + AppData.disciplines[i].chosenSport);
				}
				Ui.pushView(new RecordingView(), new RecordingViewDelegate(), Ui.SLIDE_UP);
        	}
            /*if(mPicker.getTitle().length() == 0) {
                App.getApp().deleteProperty("string");
            }
            else {
            	App.getApp().setProperty(AppData.dict[AppData.chosenDiscipline][AppData.dict[AppData.chosenDiscipline].size() - 1], mPicker.getTitle());
                //App.getApp().setProperty("string", mPicker.getTitle());
            }*/
        }
        Sys.println("AHOOOJ");
    }

}
