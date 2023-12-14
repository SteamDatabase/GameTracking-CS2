
'use-strict';

var TooltipPlayerXp = ( function()
{
	function _Init()
	{
		                                                                              
		                                                                             

		var xuid = $.GetContextPanel().GetAttributeString( "xuid", "not-found" );
		var rawBonuses = MyPersonaAPI.GetActiveXpBonuses(),
			bonusesArray = rawBonuses.split(","),
			maxLevel = InventoryAPI.GetMaxLevel(),
			currentPoints = FriendsListAPI.GetFriendXp( xuid ),
			pointsPerLevel = MyPersonaAPI.GetXpPerLevel(),
			currentLvl = FriendsListAPI.GetFriendLevel( xuid ),
			isDueServiceMedal = currentLvl >= maxLevel ? true : false;

		$.GetContextPanel().SetDialogVariable( "xpcurrent", currentPoints );
		$.GetContextPanel().SetDialogVariable( "xptonext", pointsPerLevel - currentPoints);

		$( "#JsTooltip_Xp_Current" ).text = isDueServiceMedal ? "#tooltip_xp_have_max_current" : "#tooltip_xp_current";
		$( "#JsTooltip_Xp_Needed" ).text = isDueServiceMedal ? "#tooltip_xp_have_max_rank" : "#tooltip_xp_for_next_rank";

		if( bonusesArray.length > 0 )
		{
			                                                             
			                                                              
			if( isDueServiceMedal )
			{
				for( var i = 0; i < bonusesArray.length; i++ )
				{
					if ( bonusesArray[i] === 2 )
						bonusesArray.splice( i, 1 );
				}
			}
		}

		var numBonusesAdded = 0;
		if( bonusesArray.length > 0 )
		{
			                                                             
			                                                              

			$( '#JsTooltipXpSection' ).RemoveClass( 'hidden' );
			$( "#JsTooltipXpBonuses" ).RemoveAndDeleteChildren();

			for( var i = 0; i < bonusesArray.length; i++ )
			{
				if ( !bonusesArray[i] )
					continue;

				++ numBonusesAdded;
				                                                   
				var newTile = $.CreatePanel( "Label", $( "#JsTooltipXpBonuses" ), 'JsTooltipBonus' + i );

				let secRemaining = StoreAPI.GetSecondsUntilXpRollover();
				newTile.SetDialogVariable( 'time-to-week-rollover', ( secRemaining > 0 ) ? FormatText.SecondsToSignificantTimeString( secRemaining ) : '' );
				
				newTile.AddClass( 'tooltip-player-xp__subtitle' );
				newTile.text = $.Localize( "#tooltip_xp_bonus_" + bonusesArray[ i ], newTile );
			}
		}

		if ( !numBonusesAdded )
		{
			$( '#JsTooltipXpSection' ).AddClass( 'hidden' );
		}
	}

	return {
		Init: _Init
	}
} )();

( function()
{
	                                                                                                                                           
} )();