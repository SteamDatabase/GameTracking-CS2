
'use-strict';

var TooltipProgress = ( function()
{
	function _Init()
	{

		var titleText = $.GetContextPanel().GetAttributeString( "titletext", "not-found" );
		var bodyText = $.GetContextPanel().GetAttributeString( "bodytext", "not-found" );
		var useXp = $.GetContextPanel().GetAttributeString( "usexp", "false" ) === 'true';
		var targetLevel = $.GetContextPanel().GetAttributeString( "targetlevel", 2 );
		var showBar = $.GetContextPanel().GetAttributeString( "showbar", "true" ) === 'true';
		var value = 0;
		
		if ( useXp )
		{
			const currentPoints = FriendsListAPI.GetFriendXp( MyPersonaAPI.GetXuid() );
			const pointsPerLevel = MyPersonaAPI.GetXpPerLevel();
			const levelsAttained = FriendsListAPI.GetFriendLevel( MyPersonaAPI.GetXuid() );
			const totalPointsAttained = ( levelsAttained ? ( levelsAttained - 1 ) : 0 ) * pointsPerLevel + currentPoints;
			const totalPointsRequired = ( targetLevel - 1 ) * pointsPerLevel;
			
			value = totalPointsAttained / totalPointsRequired * 100.0;
		}
		else
		{
			value = $.GetContextPanel().GetAttributeString( "barvalue", "0" );
		}

		                                            

		$( '#TitleLabel' ).text = $.Localize( titleText );
		$( '#TextLabel' ).text = $.Localize( bodyText );
		$( '#TextPercentage' ).text = Math.floor( value ) + '%';
		$( '#js-tooltip-progress-bar-inner' ).style.width = value + '%';
		$( '#ProgressBarContainer' ).visible = showBar;

	}

	return {
		Init: _Init
	}
} )();

( function()
{
	                          
	                                                                                                                                           
} )();