"use strict";

var gPanelName = "PanelA";

function OnLoadedA()
{
                                                             
}

function ButtonActivated()
{
    var parentPanel = $('#JSContextExperiment');
    $.GetContextPanel().Data().name_ = "parent";

    var newPanel = $.CreatePanel('Panel', parentPanel, "PanelB" );

    newPanel.Data().name_ = "PanelB";
    newPanel.Data().moo_ = OnLoadedA;

    newPanel.BLoadLayout('file://{resources}/layout/tests/perf/perf_jscontextexperiment_otherpanel.xml', false, false );
    
                                                                                      
                                                 
                                           
                                                                                                                                           
                                                                                           
}

                                                                                                    
                                           
                                                                                                    
(function ()
{
})();


