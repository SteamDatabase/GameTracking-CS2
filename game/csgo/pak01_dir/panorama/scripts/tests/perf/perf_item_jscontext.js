'use strict';

var PerfItemJsContext = ( function() {

    var _m_Id;
    
    var _Init = function()
    {
        _m_Id = $.GetContextPanel().GetAttributeInt( "id", 1 );

        _SetButtonTextFromId( _m_Id );
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
        _SetButtonTextFromId( _m_Id + 10 );
    }

    var _OnMouseOut = function()
    {
        _SetButtonTextFromId( _m_Id );
    }


                          
    return {
        Init        : _Init,
        OnMouseOver : _OnMouseOver,
        OnMouseOut  : _OnMouseOut
    };

} )();

                                                                                                    
                                           
                                                                                                    
(function()
{  
    PerfItemJsContext.Init();
})();