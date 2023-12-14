'use strict';

                                                                                                    
             
                                                                                                    

var g_activeTab;

function DestroyActiveTab()
{
    if (g_activeTab) {
                                     
        $.DispatchEvent('DeletePanel', g_activeTab);
    }
    g_activeTab = null;
}

function PanelTypeTab( panelType, layoutType )
{
    DestroyActiveTab();

    if (!layoutType)
        layoutType = 'square'

                    
    var panelId = "TypePanel_" + panelType;
    var container = $.CreatePanel("Panel", $.FindChildInContext('#TestContent'), panelId, { class: "debug-tester--" + layoutType });
    var debugControls = $.CreatePanel("Panel", container, "DebugControls", { class: "debug-tester-controls" });
    var testPanelContainer = $.CreatePanel("Panel", container, "", { class: "debug-tester-panelholder" });

                             
    var newPanel = $.CreatePanel(panelType, testPanelContainer, "PanelToTest");

                              
    if (newPanel && newPanel.BuildDebugPanel) {
        newPanel.BuildDebugPanel(debugControls);
    }

    g_activeTab = container;
}

function LayoutTab( testName, xml )
{
    DestroyActiveTab();

                           
    var panelId = "LayoutPanel_" + testName;
    var newPanel = $.CreatePanel( "Panel", $.FindChildInContext( '#TestContent' ), panelId );
    var xml = ( xml == "" || xml == undefined ) ? "file://{resources}/layout/tests/" + testName + ".xml" : xml;

    if (newPanel)
    {
        g_activeTab = panelId;
        newPanel.BLoadLayout( xml, false, false);
    }
}

                                                                                                    
                                           
                                                                                                    
(function ()
{
    g_activeTab = "TestIntro";
})();