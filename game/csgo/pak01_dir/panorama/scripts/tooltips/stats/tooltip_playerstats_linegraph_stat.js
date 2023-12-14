'use strict';

var PlayerStatsLineGraphStatTooltip = ( function()
{
	var _m_bInit = false;

	function _Init ()
	{
		var unixtime = Number( $.GetContextPanel().GetAttributeString( "timestamp", "" ) ) * 1000;
		var statvalue = $.GetContextPanel().GetAttributeString( "stat_value", "" );
		var stat_index = $.GetContextPanel().GetAttributeString( "stat_index", "" );
		var mapid = $.GetContextPanel().GetAttributeString( "mapid", "" );
		var rdwon = $.GetContextPanel().GetAttributeString( "rdwon", "" );
		var rdlost = $.GetContextPanel().GetAttributeString( "rdlost", "" );
		
		var date = new Date( unixtime );

		DateUtil.PopulateDateFormatStrings( $.GetContextPanel(), date );

		var statname = $.Localize( "#playerstat_name_" + stat_index ).toUpperCase();
		$.GetContextPanel().SetDialogVariable( 'statname', statname );
		$.GetContextPanel().SetDialogVariable( 'statvalue', statvalue );

		                           
		var elBg = $.GetContextPanel().FindChildTraverse( 'TTLineGraphStatBackground' );
		if ( elBg)
			elBg.SetImage( 'file://{images}/icons/ui/competitive.svg' );

		                     
		var elMatch = $.GetContextPanel().FindChildTraverse( "TTMatch" );

		elMatch.SetDialogVariable( 'map', DeepStatsAPI.MapIDToString( Number( mapid ) ) );
		elMatch.SetDialogVariable( 'myscore', rdwon );
		elMatch.SetDialogVariable( 'enemyscore', rdlost );

		                                
		var myScore = Number( rdwon );
		var enemyScore = Number( rdlost );

		elMatch.SetHasClass( 'playerstats-tt__match--win',  myScore > enemyScore );
		elMatch.SetHasClass( 'playerstats-tt__match--loss',  myScore < enemyScore );
		elMatch.SetHasClass( 'playerstats-tt__match--tie', myScore == enemyScore );
	}


	return {
		Init: _Init,
	}


})();

(function()
{
})();