'use strict';

var EOM_Win = ( function () {


	var _m_pauseBeforeEnd = 5.0;
	var _m_cP = $.GetContextPanel();

                                                     

	var _m_arrTopPlayerXuid = [];
	var _m_localPlayerScoreboardPosition;

	var _m_oMatchEndData = undefined;
	var _m_oScoreData = undefined;

	                                   
	                                   
	const _m_nT = 2;
	const _m_nCt = 3;

	function _SetVictoryStatement()
	{
		                                                                                
		if ( !_m_cP || !_m_cP.IsValid() )
			return;

		         
		var winningTeamNumber = _m_oMatchEndData[ "winning_team_number" ];
		var result = "#eom-result-tie3";
		var localPlayerTeamScore = _m_oScoreData[ "teamdata" ][ "TERRORIST" ][ 'score' ];
		var otherTeamNumber = _m_oScoreData[ "teamdata" ][ "CT" ][ 'score' ];
		_m_cP.RemoveClass( 'eom-win_won' );
		_m_cP.RemoveClass( 'eom-win_lost' );
		_m_cP.SetDialogVariable( "teamname", "" );

		if ( winningTeamNumber )
		{
			var localPlayerTeamNumber = MockAdapter.GetPlayerTeamNumber( MockAdapter.GetLocalPlayerXuid() );

			var mode = EOM_Characters.GetModeForEndOfMatchPurposes();
			var bForceShowWinningTeam = EOM_Characters.ShowWinningTeam( mode );

			if ( GameStateAPI.IsDemoOrHltv() || ( localPlayerTeamNumber != 2 && localPlayerTeamNumber != 3 ) || bForceShowWinningTeam )
			{
				localPlayerTeamScore = winningTeamNumber == _m_nT ? _m_oScoreData[ "teamdata" ][ "TERRORIST" ][ 'score' ] : _m_oScoreData[ "teamdata" ][ "CT" ][ 'score' ];
				otherTeamNumber = winningTeamNumber == _m_nT ? _m_oScoreData[ "teamdata" ][ "CT" ][ 'score' ] : _m_oScoreData[ "teamdata" ][ "TERRORIST" ][ 'score' ];
				result = "#eom-result-win3";
				_m_cP.SetHasClass( 'eom-win_won', true );

				                                                                                           
				                                                                                       
			}
			else
			{
				localPlayerTeamScore = localPlayerTeamNumber == _m_nT ? _m_oScoreData[ "teamdata" ][ "TERRORIST" ][ 'score' ] : _m_oScoreData[ "teamdata" ][ "CT" ][ 'score' ];
				otherTeamNumber = localPlayerTeamNumber == _m_nT ? _m_oScoreData[ "teamdata" ][ "CT" ][ 'score' ] : _m_oScoreData[ "teamdata" ][ "TERRORIST" ][ 'score' ];
				result = winningTeamNumber == localPlayerTeamNumber ? "#eom-result-win3" : "#eom-result-loss3";
				_m_cP.SetHasClass( 'eom-win_won', winningTeamNumber == localPlayerTeamNumber );
				_m_cP.SetHasClass( 'eom-win_lost', winningTeamNumber != localPlayerTeamNumber );

				                                                                                               
				                                                                                
				                                                              
			}
		}

		if ( _m_oMatchEndData.hasOwnProperty( 'match_cancelled' ) && _m_oMatchEndData.match_cancelled )
		{
			_m_cP.SetHasClass( 'eom-win_won', false );
			_m_cP.SetHasClass( 'eom-win_lost', false );
			result = '#SFUI_match_cancelled';
		}

		if ( _m_oMatchEndData.hasOwnProperty( 'cancel_reason_code' ) && _m_oMatchEndData.cancel_reason_code )
		{
			_ShowMatchCancelledEarlyWithReasonExplanation( _m_oMatchEndData.cancel_reason_code );
		}

		_m_cP.SetDialogVariable( "win-result", $.Localize( result ) );
		_m_cP.SetDialogVariableInt( "score_local_player", localPlayerTeamScore );
		_m_cP.SetDialogVariableInt( "score_other", otherTeamNumber );
		_AnimStart();
	}

	function _AnimStart ()
	{	
		var elPanel = $.GetContextPanel().FindChildTraverse( 'WinTeam' );	
		elPanel.TriggerClass( 'show' );
	}
	
	function _ShowMatchCancelledEarlyWithReasonExplanation( cancel_reason_code )
	{
		var elPanel = $.GetContextPanel().FindChildTraverse( 'EomCancelReason' + cancel_reason_code );
		if ( elPanel )
		{
			elPanel.AddClass( 'show' );
		}
	}

	function _DisplayMe()
	{
		_m_oMatchEndData = MockAdapter.GetMatchEndWinDataJSO();
		_m_oScoreData = MockAdapter.GetScoreDataJSO();

		if ( !_m_oMatchEndData )
			return false;
		
		if ( !_m_oScoreData ||
			!_m_oScoreData[ "teamdata" ] ||
			!_m_oScoreData[ "teamdata" ][ "CT" ] ||
			!_m_oScoreData[ "teamdata" ][ "TERRORIST" ] )
			return false;

		if ( _m_oMatchEndData.hasOwnProperty( 'winning_player' ) )
		{
			                                                 
			                                                                                                  

			                                                
		  	                                                             
			
			return false;
		}

		_SetVictoryStatement();

		return true;
	}

	                                                         
	                                                                      
	  
	  

	function _Start() 
	{
		                              

		if ( MockAdapter.GetMockData() && !MockAdapter.GetMockData().includes( 'EOM_WIN' ) )
		{
			_End();
			return;
		}

		if ( _DisplayMe( ) )
		{
			EndOfMatch.SwitchToPanel( 'eom-win' );
			EndOfMatch.StartDisplayTimer( _m_pauseBeforeEnd );
			
			$.Schedule( _m_pauseBeforeEnd, _End );
		}
		else
		{
			_End();
			return;
		}
	}

	function _End() 
	{
		                            

		EndOfMatch.ShowNextPanel();
	}

	function _Shutdown()
	{
	}

	                      
	return	{
        name: 'eom-win',
		Start									: _Start,
		Shutdown: _Shutdown,
	};
})();


                                                                                                    
                                           
                                                                                                    
(function () {

	if ( EndOfMatch )
		EndOfMatch.RegisterPanelObject( EOM_Win );


})();
