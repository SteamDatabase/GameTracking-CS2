'use strict';

var PerfItemJsContextSingle = ( function() {

                             
                
    
    var _Init = function()
    {
                                 
                                                                  
        $.GetContextPanel().Data()._m_Id = $.GetContextPanel().GetAttributeInt( "id", 1 );

        _SetButtonTextFromId( $.GetContextPanel().Data()._m_Id );
    }

    var _SetButtonTextFromId = function( id )
    {
        var buttonStr = 'Button_';
        if ( id < 10 )
        {
            buttonStr += '00';
        }
        else if ( id < 100 )
        {
            buttonStr += '0';
        }
        buttonStr += id.toString();
        $( '#buttonText' ).text = buttonStr;
    }

    var _OnMouseOver = function()
    {
        _SetButtonTextFromId( $.GetContextPanel().Data()._m_Id + 10 );
    }

    var _OnMouseOut = function()
    {
        _SetButtonTextFromId( $.GetContextPanel().Data()._m_Id );
    }


                          
    return {
        Init        : _Init,
        OnMouseOver : _OnMouseOver,
        OnMouseOut  : _OnMouseOut
    };

} )();

                                                                                                    
                                           
                                                                                                    
(function()
{  
    PerfItemJsContextSingle.Init();
})();