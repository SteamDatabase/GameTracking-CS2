'use strict';

var PlayerStatsCalendarDayTooltip = ( function()
{

	                                                  
	    
	   	                                     

	   	                       
	   	                        
	   	                           

	   	                                 
	    

	function _Init ()
	{
		var arrMatches = JSON.parse( $.GetContextPanel().GetAttributeString( "data", "[]" ));
		var mode = $.GetContextPanel().GetAttributeString( "mode", "" );
		var timestamp = $.GetContextPanel().GetAttributeString( "timestamp", "" );

		var date = new Date( timestamp*1000 );
		
		                           
		var elBg = $.GetContextPanel().FindChildTraverse( 'TTCalendarDayBackground' );
		if ( elBg)
			elBg.SetImage( 'file://{images}/icons/ui/competitive.svg' );

		                 
		$.GetContextPanel().SetDialogVariable( 'date', DateUtil.UUU_MMM_dd( date ) );
		
		                            
		var elMatchList = $.GetContextPanel().FindChildTraverse( "TTCalendarDayMatchList" );
		elMatchList.RemoveAndDeleteChildren();

		arrMatches.forEach( function( oMatch, index )
		{
			var elMatch = $.CreatePanel( 'Panel', elMatchList, 'Match-' + index );
			elMatch.BLoadLayoutSnippet( 'snippet-match' );

			              
			var mapid = oMatch[ 'mapid' ];

			var myScore = Number( oMatch[ 'rounds_won' ] ? oMatch[ 'rounds_won' ] : 0 );
			var enemyScore = Number( oMatch[ 'rounds_lost' ] ? oMatch[ 'rounds_lost' ] : 0 );

			var mapName = $.Localize( '#SFUI_Map_' + DeepStatsAPI.MapIDToString( mapid ) );
			elMatch.SetDialogVariable( 'map', mapName );
			elMatch.SetDialogVariable( 'myscore', myScore);
			elMatch.SetDialogVariable( 'enemyscore', enemyScore );

			                                


			elMatch.SetHasClass( 'playerstats-tt__match--win',  ( oMatch.match_outcome & 0x3 ) == 1 );
			elMatch.SetHasClass( 'playerstats-tt__match--loss',  (oMatch.match_outcome & 0x3 ) == 2 );
			elMatch.SetHasClass( 'playerstats-tt__match--tie',   (oMatch.match_outcome & 0x3 ) == 0 );

			elMatch.SetHasClass( 'playerstats-tt__match--dnf', ( oMatch.match_outcome & 0x4 ) );
				

		} );

	}


	return {
		Init: _Init,
	}


})();

(function()
{
})();