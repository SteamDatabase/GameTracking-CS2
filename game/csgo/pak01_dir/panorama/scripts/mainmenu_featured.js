'use strict';

var FeaturedSurvival = (function () {


	var _OnSurvivalPlayPressed = function()
	{
        if ( PartyListAPI.GetCount() <= 1 )
        {
            if ( PartyListAPI.GetPartySessionSetting( "game/mode" ) !== "survival" )
            {
                LobbyAPI.CloseSession();
            }
            
            GameInterfaceAPI.SetSettingString( 'ui_playsettings_mode_official', 'survival' );
        }

        $.DispatchEvent( 'OpenPlayMenu' );
	};

	return {
		OnSurvivalPlayPressed: _OnSurvivalPlayPressed
	};
})();


(function () {
})();