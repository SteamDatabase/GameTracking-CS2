'use strict';

                                                                                                    
             
                                                                                                    

var activeTab;

function NavigateToTab( tab, PanelName, pressedBtnId )
{
    if ( activeTab )
    {
                                     
        $.DispatchEvent( 'DeletePanel', activeTab );
    }
    
    UiToolkitAPI.ProfilingScopeBegin( 'PerfNavigate' );

                           
    var newPanel = $.CreatePanel( PanelName, $.FindChildInContext('#JsPerfContent'), tab );

    var durationMS = UiToolkitAPI.ProfilingScopeEnd();

    $( '#JsPerfTime' ).text = durationMS.toFixed( 3 );

    activeTab = tab;
}

                                                                                                    
                                           
                                                                                                    
(function ()
{
    activeTab = "JsPerfIntro";
})();