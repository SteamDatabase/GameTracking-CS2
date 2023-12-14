'use strict';

var SurvivalZoneTimer = ( function()
{
    var _init = function()
    {
        var mode = GameStateAPI.GetGameModeInternalName( false );

        if ( mode === 'survival' )
        {
            _GetTime();
        }
    };

    var _GetTime = function()
    {
        if ( !$.GetContextPanel().IsValid() )
        {
            return;
        }
        
        var time = GameStateAPI.GetSurvivalTimeUntilNextWave();
        if (time > 0 && time && GameStateAPI.ShouldShowHudElements())
        {
            if ( !$.GetContextPanel().BHasClass( 'show' ) )
            {
                $.GetContextPanel().AddClass( 'show' );
            }
 
            $.GetContextPanel().SetHasClass( 'lowtime', time < 20 );
            $.GetContextPanel().SetDialogVariable( 'time', FormatText.SecondsToDDHHMMSSWithSymbolSeperator( Math.floor(time ) ));
        }
        else
        {
            if ( $.GetContextPanel().BHasClass( 'show' ) )
            {
                $.GetContextPanel().RemoveClass( 'show' );
            }
        }

        $.Schedule( 1, _GetTime );
    };


    return {
        init: _init
    };

} )();

                                                                                                    
                                            
                                                                                                    
( function()
{
    SurvivalZoneTimer.init();
} )();