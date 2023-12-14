'use strict';

var PlayerStatsMatchlisterMatchStats = ( function()
{


	function _Init ()
	{
		var oMatch = JSON.parse( $.GetContextPanel().GetAttributeString( "matchdata", "{}" ) );
		var additionalClass = $.GetContextPanel().GetAttributeString( "class", "" );
		$.GetContextPanel().AddClass( additionalClass );

		$.GetContextPanel().SetDialogVariable( 'matchid', MatchStats.GetMatchId( oMatch ) );
		

		$.GetContextPanel().SetDialogVariable('playerstat_value-a_0' ,MatchStats.GetTotalScore( oMatch));
		$.GetContextPanel().SetDialogVariable('playerstat_value-a_1' ,MatchStats.GetTotalKills( oMatch));
		$.GetContextPanel().SetDialogVariable('playerstat_value-a_2' ,MatchStats.GetTotalDamage( oMatch));
		$.GetContextPanel().SetDialogVariable('playerstat_value-a_3' , MatchStats.GetKillsPerDeath( oMatch));
		$.GetContextPanel().SetDialogVariable('playerstat_value-a_4' ,MatchStats.GetTotalHeadShotKills( oMatch) == 0 ? '' : MatchStats.GetTotalHeadShotKills( oMatch));
		$.GetContextPanel().SetDialogVariable('playerstat_value-a_5' ,MatchStats.GetTotal2Ks( oMatch ));
		$.GetContextPanel().SetDialogVariable('playerstat_value-a_6' ,MatchStats.GetTotal3ks( oMatch));
		$.GetContextPanel().SetDialogVariable( 'playerstat_value-a_7', MatchStats.GetTotal4Ks( oMatch ) );
		
		$.GetContextPanel().SetDialogVariable( 'playerstat_value-a_8', MatchStats.GetTotalHESuccesses( oMatch ) + '/' + MatchStats.GetTotalHEThrown( oMatch ) );
		$.GetContextPanel().SetDialogVariable( 'playerstat_value-a_9', MatchStats.GetTotalFBSuccesses( oMatch ) + '/' + MatchStats.GetTotalFBThrown( oMatch ) );
		$.GetContextPanel().SetDialogVariable( 'playerstat_value-a_10', MatchStats.GetTotal1v1Successes( oMatch ) + '/' + MatchStats.GetTotal1v1Engagements( oMatch ) );
		$.GetContextPanel().SetDialogVariable( 'playerstat_value-a_11', MatchStats.GetTotal1v2Successes( oMatch ) + '/' + MatchStats.GetTotal1v2Engagements( oMatch ) );
		$.GetContextPanel().SetDialogVariable('playerstat_value-a_12',MatchStats.GetTotalEntryKills( oMatch) + ':' + (MatchStats.GetTotalEntryDeaths( oMatch )));

		$.GetContextPanel().SetDialogVariable('playerstat_value-b_0' ,MatchStats.GetScorePerRound( oMatch) == "0.00" ? "" : MatchStats.GetScorePerRound( oMatch) + $.Localize( '#playerstats_suffix_per_round'));
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_1' ,MatchStats.GetKillsPerRound( oMatch) == "0.00" ? "" : MatchStats.GetKillsPerRound( oMatch) + $.Localize( '#playerstats_suffix_per_round'));
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_2' ,MatchStats.GetDamagePerRound( oMatch));
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_3' ,'' );
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_4' , MatchStats.GetHeadShotKillRate( oMatch) + $.Localize( '#playerstats_suffix_per_cent'));
		$.GetContextPanel().SetDialogVariable( 'playerstat_value-b_5', '' );
		$.GetContextPanel().SetDialogVariable( 'playerstat_value-b_6', '' );
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_7' ,'');
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_8' ,MatchStats.GetTotalHEThrown( oMatch) == 0 ? "" : MatchStats.GetHESuccessRate( oMatch) + $.Localize( '#playerstats_suffix_per_cent'));
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_9',MatchStats.GetTotalFBThrown( oMatch) == 0 ? ""  : MatchStats.GetFBSuccessRate( oMatch) + $.Localize( '#playerstats_suffix_per_cent'));
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_10',MatchStats.GetTotal1v1Engagements( oMatch) == 0 ? "" : MatchStats.Get1v1SuccessRate( oMatch) + $.Localize( '#playerstats_suffix_per_cent'));
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_11',MatchStats.GetTotal1v2Engagements( oMatch) == 0 ? "" : MatchStats.Get1v2SuccessRate( oMatch) + $.Localize( '#playerstats_suffix_per_cent'));
		$.GetContextPanel().SetDialogVariable('playerstat_value-b_12',MatchStats.GetEntryKillsPerDeath( oMatch) == "0.00" ? "" : MatchStats.GetEntryKillsPerDeath( oMatch));			
		
		$.GetContextPanel().SetDialogVariable( 'abandoned', ( oMatch.match_outcome & 0x4 ) ? $.Localize( '#matchstat_abandoned' ) : '' );	
		$.GetContextPanel().FindChildTraverse( 'Abandoned' ).visible = oMatch.match_outcome & 0x4;
	}

	return {
		Init: _Init,
	}


})();

(function()
{
} )();


