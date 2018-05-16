using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;
using Toybox.System as Sys;
using Toybox.Attention;



/** Pohled ktery se nacte pri spusteni aplikace, k osetreni vstupu slouzi: 
 *	
 *							nThlonDelegate
 *  
 *
 */
class nThlonView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    function onShow() {
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
    }

    function onHide() {
    }

}
