'use strict';

                                                                                                    
                                           
                                                                                                    
(function()
{  
    for (var i = 0; i < 200; i++)
    {
        var newPanel = $.CreatePanel( 'Panel', $('#JsContent'), '' , {
                    useglobalcontext: 'true'
                });
        newPanel.SetAttributeInt( 'id', i );
        newPanel.BLoadLayout( 'file://{resources}/layout/tests/perf/perf_item_jscontext.xml', false, false );
    }
})();