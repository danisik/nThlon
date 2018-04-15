using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.System as Sys;

var currentView = null;

/** Trida reprezentujici jeden checkbox */
class Checkbox extends Ui.Selectable {
    var stateHighlightedSelected;

    function initialize(options) {
        Selectable.initialize(options);

        stateHighlightedSelected = options.get(:stateHighlightedSelected);
    }

    function unHighlight() {
        if(getState() == :stateHighlighted) {
            setState(:stateDefault);
        }
        else if(getState() == :stateHighlightedSelected) {
            setState(:stateSelected);
        }
    }

    function reset(previousState) {
        if(previousState == :stateSelected) {
            setState(:stateSelected);
        }
        else if(previousState == :stateHighlightedSelected) {
            setState(:stateSelected);
        }
    }

    function highlight(previousState) {
        if(previousState == :stateSelected) {
            setState(:stateHighlightedSelected);
        }
    }

    function select(previousState) {
        if(previousState == :stateHighlighted) {
            setState(:stateHighlightedSelected);
        }
        else if(previousState == :stateHighlightedSelected) {
            setState(:stateHighlighted);
        }
        else if(previousState == :stateSelected) {
            setState(:stateDefault);
        }
    }
}

/** List checkboxu, ktere budou zobrazeny ve view */
class CheckBoxList {
    hidden var list;

    hidden var currentHighlight;

    //! Constructor
    function initialize(dc) {
        currentHighlight = null;

		Sys.println(App.getApp().getProperty("BehCas"));
        var BORDER_PAD = 2;

        var checkBoxDefault = new Ui.Bitmap({:rezId=>Rez.Drawables.checkBoxDefault});
        var checkBoxHighlighted = new Ui.Bitmap({:rezId=>Rez.Drawables.checkBoxHighlighted});
        var checkBoxSelected = new Ui.Bitmap({:rezId=>Rez.Drawables.checkBoxSelected});
        var checkBoxHighlightedSelected = new Ui.Bitmap({:rezId=>Rez.Drawables.checkBoxHighlightedSelected});
        var checkBoxDisabled = Gfx.COLOR_BLACK;

        var dims = checkBoxDefault.getDimensions();
        list = new[5];

        var slideSymbol, spacing, offset, initX, initY;
        if (dc.getHeight() > dc.getWidth()) {
            slideSymbol = :locY;
            spacing = (dc.getHeight() / 4);
            offset = (dims[1] / 2);
            initY = 10;
            initX = 5;
        } else {
            slideSymbol = :locX;
            spacing = (dc.getWidth() / 4);
            offset = (dims[0] / 2);
            initX = spacing - offset - BORDER_PAD;
            initY = (dc.getHeight() / 2) - (dims[1] / 2);
        }

        var options = {
            :stateDefault=>checkBoxDefault,
            :stateHighlighted=>checkBoxHighlighted,
            :stateSelected=>checkBoxSelected,
            :stateDisabled=>checkBoxDisabled,
            :stateHighlightedSelected=>checkBoxHighlightedSelected,
            :locX=>initX,
            :locY=>initY,
            :width=>dims[0],
            :height=>dims[1]
            };
        /*list[0] = new Checkbox(options);

        // Create the second check-box
        options.put(slideSymbol, initY + dims[1] + offset);//2 * spacing - offset);
        list[1] = new Checkbox(options);
        if (AppData.discovered[0] == 0) {
        	list[1].setState(:stateSelected);
        }

        // Create the third check-box
        options.put(slideSymbol, initY + 2 * (dims[1] + offset));//3 * spacing - offset + BORDER_PAD);
        list[2] = new Checkbox(options);
        
        options.put(slideSymbol, initY + 3 * (dims[1] + offset));
        list[3] = new Checkbox(options);
        options.put(slideSymbol, initY + 4 * (dims[1] + offset));
        list[4] = new Checkbox(options);*/
        
        /* ZDE BUDE ZMENA V KODU */
        if (AppData.chosenDiscipline.equals("beh")) {
        	list = new[5];
        	list[0] = new Checkbox(options);
        	options.put(slideSymbol, initY + dims[1] + offset);
        	list[1] = new Checkbox(options);
        	options.put(slideSymbol, initY + 2 * (dims[1] + offset));
        	list[2] = new Checkbox(options);
        	options.put(slideSymbol, initY + 3 * (dims[1] + offset));
        	list[3] = new Checkbox(options);
        	options.put(slideSymbol, initY + 4 * (dims[1] + offset));
        	list[4] = new Checkbox(options);
        } else if (AppData.chosenDiscipline.equals("kolo")) {
        	list = new[5];
        	list[0] = new Checkbox(options);
        	options.put(slideSymbol, initY + dims[1] + offset);
        	list[1] = new Checkbox(options);
        	options.put(slideSymbol, initY + 2 * (dims[1] + offset));
        	list[2] = new Checkbox(options);
        	options.put(slideSymbol, initY + 3 * (dims[1] + offset));
        	list[3] = new Checkbox(options);
        	options.put(slideSymbol, initY + 4 * (dims[1] + offset));
        	list[4] = new Checkbox(options);
        } else if (AppData.chosenDiscipline.equals("plavani")) {
        	list = new[4];
        	list[0] = new Checkbox(options);
        	options.put(slideSymbol, initY + dims[1] + offset);
        	list[1] = new Checkbox(options);
        	options.put(slideSymbol, initY + 2 * (dims[1] + offset));
        	list[2] = new Checkbox(options);
        	options.put(slideSymbol, initY + 3 * (dims[1] + offset));
        	list[3] = new Checkbox(options);
        }
        
        for (var i = 0; i < list.size(); i += 1) {
        	Sys.println(i);
        	Sys.println(App.getApp().getProperty( AppData.behProperties[0]));
        	if (App.getApp().getProperty( AppData.dict[AppData.chosenDiscipline][i])) {//AppData.behProperties[i])) {
        		list[i].setState(:stateSelected);
        	}
        }
        
    }

    function getList() {
        return list;
    }

    function handleEvent(instance, previousState) {
        if(instance.getState() == :stateHighlighted) {
            if((null != currentHighlight) && !currentHighlight.equals(instance)) {
                currentHighlight.unHighlight();
            }

            currentHighlight = instance;
            instance.highlight(previousState);
        }
        else if(instance.getState() == :stateSelected) {
            instance.select(previousState);
        }
        else if(instance.getState() == :stateDefault) {
            instance.reset(previousState);
        }
    }
}

/** View ktere slouzi pro vyber hodnot, ktere budou zobrazeny v dane discipline */
class CheckBoxView extends Ui.View {

    var checkBoxes = null;

    function initialize() {
        View.initialize();

        currentView = self;
    }

    function onLayout(dc) {
        checkBoxes = new CheckBoxList(dc);
        setLayout(checkBoxes.getList());
        AppData.checkBoxes = checkBoxes.getList();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
    }
}
