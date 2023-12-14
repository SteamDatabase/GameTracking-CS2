'use strict';

                 
               
                                   
                             
     

                     
             

var matchInfo = ( function() {

    var PLAYERSTATS = [ 'kills', 'assists', 'deaths', 'mvps', 'score' ];
    var TEAMS =[ 'CT', 'TERRORIST' ];
    var TEAMSIZE = 5;
    
    function _ShowMatchSpinner( value, tab )
    {
        if ( tab )
        {
            var elSpinner = tab.FindChildInLayoutFile( "id-match-spinner" );
            if ( elSpinner )
            {
                if ( value )
                {
                    elSpinner.RemoveClass( 'hide' );
                }
                else
                {
                    elSpinner.AddClass( 'hide' );
                }
            }
        }
    }
    
    function _SetMatchMessage( value, show, tab )
    {
        if ( tab )
        {
            var elMessage = tab.FindChildInLayoutFile( "id-match-message" );
            if ( elMessage )
            {
                elMessage.text = value;
            }
            var elMessageContainer = tab.FindChildInLayoutFile( "id-match-message-container" );
            if ( elMessageContainer )
            {
                if ( show )
                {
                    elMessageContainer.RemoveClass( 'hide' );
                }
                else
                {
                    elMessageContainer.AddClass( 'hide' );
                }
            }
        }
    }

    function _IsMatchMetadataFullyLoaded( elParentPanel )
    {
        return ( ( ( elParentPanel.matchListDescriptor == 'live' ) && ( elParentPanel.matchId != 'gotv' ) ) || ( MatchInfoAPI.GetMatchMetadataFullState( elParentPanel.matchId ) ) );
    }

    function _DownloadMatch( elParentPanel )
    {
        MatchInfoAPI.Delete( elParentPanel.matchId );
        MatchInfoAPI.Download( elParentPanel.matchId );
        _UpdateMatchMenu( elParentPanel );
    }

    function _DownloadFailedNotify( elParentPanel )
    {
        var canDownload = !( elParentPanel.matchListDescriptor === 'downloaded' )
                          && ( ( MatchInfoAPI.GetMatchState( elParentPanel.matchInfo ) === 'recent' ) || ( elParentPanel.isTournament ) );
        if ( canDownload )
        {
            UiToolkitAPI.ShowGenericPopupYesNo( $.Localize( "#WatchMenu_Info_Download_Failed" ), $.Localize( "#WatchMenu_Info_Download_Failed_Retry" ), '', function() { _DownloadMatch( elParentPanel ) }, function() {} );
        }
        else
        {
            UiToolkitAPI.ShowGenericPopupOk( $.Localize( "#WatchMenu_Info_Download_Failed" ), $.Localize( "#WatchMenu_Info_Download_Failed_Info" ), '', function() {} );
        }
    }

    function _DeleteDemo( elParentPanel )
    {
        MatchInfoAPI.Delete( elParentPanel.matchId )
        if ( elParentPanel.matchListDescriptor === 'downloaded' )
        {
            mainmenu_watch.UpdateActiveTab();
        }
        else
        {
            _UpdateMatchMenu( elParentPanel );
        }
    }

    function _Watch( elParentPanel )
    {
        MatchInfoAPI.Watch( elParentPanel.matchId, 0 );
    }

    function _WatchHighlights( elParentPanel )
    {
        MatchInfoAPI.WatchHighlights( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid );
	}
	
	function _WatchLowlights( elParentPanel )
    {
        MatchInfoAPI.WatchLowlights( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid );
    }
    
    function _ShareMatch( elParentPanel )
    {
        SteamOverlayAPI.CopyTextToClipboard( MatchInfoAPI.GetMatchShareToken( elParentPanel.matchId, "copyurl" ) );
        var elShareLinkButton = elParentPanel.FindChildInLayoutFile( 'id-mi-copy' );
        UiToolkitAPI.HideTextTooltip();
        UiToolkitAPI.ShowTextTooltipOnPanel( elShareLinkButton, $.Localize("#WatchMenu_Share_Link_Copied") );
    }

    var _CanRedeem = function ( elParentPanel )
    {
        if ( !elParentPanel.tournamentIndex )
        {
            return;
        }

        var id = InventoryAPI.GetActiveTournamentCoinItemId( elParentPanel.tournamentIndex );
        if( !id || id === '0' )
        {
            return false;
        }
        else
        {
			var coinLevel = InventoryAPI.GetItemAttributeValue( id, "upgrade level" );
			
			var coinRedeemsPurchased = InventoryAPI.GetItemAttributeValue( id, "operation drops awarded 1" );
			if ( coinRedeemsPurchased )                                                                          
				coinLevel += coinRedeemsPurchased;

            var redeemed = InventoryAPI.GetItemAttributeValue( id, "operation drops awarded 0" );
			var redeemsAvailable = coinLevel - redeemed;
			
			                                                                                                             
			if ( ( elParentPanel.tournamentIndex == g_ActiveTournamentInfo.eventid ) &&
				g_ActiveTournamentInfo.itemid_charge &&
				ItemInfo.GetStoreSalePrice( InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( g_ActiveTournamentInfo.itemid_charge, 0 ), 1, '' )
			) {
				++ redeemsAvailable;
			}

            var tournamentName = MatchInfoAPI.GetMatchTournamentName( elParentPanel.matchId );
            return redeemsAvailable > 0 &&
                ( ( tournamentName != undefined ) && ( tournamentName != "" ) );
        }
    };

    function _RedeemSouvenir( tournamentIndex, matchId )
    {        
        UiToolkitAPI.ShowCustomLayoutPopupParameters(
            '',
            'file://{resources}/layout/popups/popup_redeem_souvenir.xml',
            'matchid=' + matchId + 
            '&' + 'tournamentindex=' + tournamentIndex
        );
    }

    function _RefreshRoundWatchEnabled( elParentPanel )
    {
        var isLive = Boolean(MatchInfoAPI.IsLive(elParentPanel.matchId));
        
        if ( isLive )
        {
            return;
        }

        var elStatsContainer = elParentPanel.FindChildInLayoutFile( 'id-mi-round-stats__container' );

        var totalBars = elStatsContainer.Children().length;
        
        if ( totalBars == 0 )
        {
            return;
        }

        var canWatch = MatchInfoAPI.CanWatch( elParentPanel.matchId );

        for ( var i = 1; i <= totalBars; i++ )
        {
            var elRoundStats = elStatsContainer.GetChild( i-1 );

            if ( !canWatch ) 
            {
                elRoundStats.AddClass( 'no-hover' );
            }
            else
            {
                elRoundStats.RemoveClass( 'no-hover' );
                elRoundStats.style.tooltipPosition = "bottom";
                elRoundStats.style.tooltipBodyPosition = "50% 0%";
                function _OnRoundMouseOver( elButton )
                {
                    UiToolkitAPI.ShowTextTooltipOnPanel( elButton, $.Localize( "#CSGO_Watch_Round" ) );
                }

                function _OnRoundActivate( nMatch, nRound )
                {
                    MatchInfoAPI.Watch( nMatch, nRound );
                }

                elRoundStats.SetPanelEvent( 'onmouseover', _OnRoundMouseOver.bind( undefined, elRoundStats ) );
                elRoundStats.SetPanelEvent( 'onmouseout', function(){ UiToolkitAPI.HideTextTooltip(); } );
                elRoundStats.SetPanelEvent( 'onactivate', _OnRoundActivate.bind( undefined, elParentPanel.matchId, i ) );
                
            }
        }
    }

    function _UpdateMatchMenu( elParentPanel )
    {   
        var matchState = MatchInfoAPI.GetMatchState( elParentPanel.matchId );

        var elDownloadButton = elParentPanel.FindChildInLayoutFile( 'id-mi-download' );
        var elShareLinkButton = elParentPanel.FindChildInLayoutFile( 'id-mi-copy' );
        var elWatchButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch' );
        var elSouvenirButton = elParentPanel.FindChildInLayoutFile( 'id-mi-souvenir' );
		var elWatchHighlightsButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch-highlights' );
		var elWatchLowlightsButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch-lowlights' );
        var elDeleteButton = elParentPanel.FindChildInLayoutFile( 'id-mi-delete' );
        var elDownloadingButton = elParentPanel.FindChildInLayoutFile( 'id-mi-downloading' );
        var elDownloadFailedButton = elParentPanel.FindChildInLayoutFile( 'id-mi-error-delete' );

        function _ShowButton( elButton, value )
        {
            if ( elButton )
            {
                if ( value )
                {
                    elButton.RemoveClass( 'hide' );
                }
                else
                {
                    elButton.AddClass( 'hide' );
                }
            }
        }

        function _EnableButton( elButton, value )
        {
            if ( elButton )
            {
                if ( value )
                {
                    elButton.enabled = true;
                }
                else
                {
                    elButton.enabled = false;
                }
            }
        }

        var canWatch = MatchInfoAPI.CanWatch( elParentPanel.matchId );
		_EnableButton( elWatchButton, canWatch );

		                                                                                                         
		
        if ( elParentPanel.matchListDescriptor != 'live' )
        {
			_ShowButton( elWatchButton, canWatch );
			_ShowButton( elWatchHighlightsButton, canWatch );
			_ShowButton( elWatchLowlightsButton, canWatch );
            _ShowButton( elDownloadButton, !canWatch );
            _ShowButton( elSouvenirButton, ( matchState !== "live" ) && _CanRedeem( elParentPanel ));

            var szSouvenirButtonHint = '#popup_redeem_souvenir_title';
            elSouvenirButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elSouvenirButton, szSouvenirButtonHint ); } );
            elSouvenirButton.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideTextTooltip(); } );

			if ( elParentPanel.matchListDescriptor != 'downloaded' )
            {
				var szDownloadButtonHint = '#WatchMenu_Download_Demo';

                if ( matchState === "downloaded" )
                {
                    _EnableButton( elDownloadButton, false );
                    _ShowButton( elDownloadingButton, false );
					_ShowButton( elDownloadFailedButton, false );
                }
                else if ( matchState === "downloading" )
                {
                    _EnableButton( elDownloadButton, false );
                    _ShowButton( elDownloadingButton, true );
					_ShowButton( elDownloadFailedButton, false );
					_ShowButton( elWatchHighlightsButton, false );
					_ShowButton( elWatchLowlightsButton, false );
					_ShowButton( elWatchButton, false );
                }
                else if ( MatchInfoAPI.CanDownload( elParentPanel.matchId ) )
                {
                    _EnableButton( elDownloadButton, true );
                    _ShowButton( elDownloadingButton, false );
                    _ShowButton( elDownloadFailedButton, false );
                }
                else
                {
					szDownloadButtonHint = '#WatchMenu_Download_Disabled_Hint';
                    _EnableButton( elDownloadButton, false );
                    _ShowButton( elDownloadingButton, false );
                    _ShowButton( elDownloadFailedButton, false );
				}
				
                _EnableButton( elShareLinkButton, ( elParentPanel.matchShareToken != "" ) && ( elParentPanel.matchShareToken != undefined ) );
                
				
				elDownloadButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elDownloadButton, szDownloadButtonHint ); } );
                elDownloadButton.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideTextTooltip(); } );
            }
            else
            {
                _ShowButton( elDownloadButton, false );
                _ShowButton( elDownloadingButton, false );
                _ShowButton( elDownloadFailedButton, false );
            }

			var bEnabledReelLightsButton = ( ( elParentPanel.activePlayerRow ) && ( MatchInfoAPI.CanWatchHighlights( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid ) ) );
			_EnableButton( elWatchHighlightsButton, bEnabledReelLightsButton );
			_EnableButton( elWatchLowlightsButton, bEnabledReelLightsButton );

            var canDelete = MatchInfoAPI.CanDelete( elParentPanel.matchId );
            _EnableButton( elDeleteButton, canDelete );
            
            if ( !canWatch && canDelete )
            {
                _ShowButton( elDownloadFailedButton, true );
            }
        }
        else
        {
            _ShowButton( elDownloadButton, false );
            _ShowButton( elDownloadingButton, false );
            _ShowButton( elDownloadFailedButton, false );
			_ShowButton( elWatchHighlightsButton, false );
			_ShowButton( elWatchLowlightsButton, false );
            _ShowButton( elShareLinkButton, false );
            _ShowButton( elDeleteButton, false );
            _ShowButton( elSouvenirButton, false );
        }

        _RefreshRoundWatchEnabled( elParentPanel );
    }

    function _Refresh( elParentPanel )
    {
        function _ShowLoadingError( elBoundParentPanel )
        {
            _ShowMatchSpinner( false, elBoundParentPanel );
            _SetMatchMessage( $.Localize( '#CSGO_Watch_NoMatchData'), true, elBoundParentPanel );
            if ( elBoundParentPanel.updateMatchInfoHandler )
            {
                $.UnregisterForUnhandledEvent( 'PanoramaComponent_MatchInfo_StateChange', elBoundParentPanel.updateMatchInfoHandler );
            }
            elParentPanel.downloadFailedHandler = undefined;
        }
        
        if ( _IsMatchMetadataFullyLoaded( elParentPanel ) )
        {
            _PopulateMatchInfo( elParentPanel );
        }
        else if ( MatchInfoAPI.IsServerLogTournamentMatch( elParentPanel.matchId ) )
        {
            _PopulateServerLogTournamentMatchInfo( elParentPanel );
        }
        else if ( !elParentPanel.downloadFailedHandler )
        {
            MatchInfoAPI.DownloadWithShareToken( elParentPanel.matchId );
            elParentPanel.downloadFailedHandler = $.Schedule(  3.0, _ShowLoadingError.bind( undefined, elParentPanel ) );
            elParentPanel.updateMatchInfoHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_MatchInfo_StateChange', _PopulateMatchInfo.bind( undefined, elParentPanel ) );
        }

    }

    function _PopulateMatchInfo( elParentPanel )
    {  
        if ( elParentPanel.downloadFailedHandler )
        {
            $.CancelScheduled( elParentPanel.downloadFailedHandler )
            elParentPanel.downloadFailedHandler = undefined;
        }
        _FillScoreboard( elParentPanel );
        _UpdateMatchMenu( elParentPanel );
        if ( elParentPanel.matchListDescriptor != 'live' )
        {
            _FillRoundStats( elParentPanel, elParentPanel.activePlayerRow );
        }
        _Show( elParentPanel );
    }
    
    function _PopulateServerLogTournamentMatchInfo( elParentPanel )
    {
        _FillServerLogTournamentInfo( elParentPanel );
        _UpdateMatchMenu( elParentPanel );
        _Show( elParentPanel );
    }

    function _UpdateName( elParentPanel, elPlayerName )
    {
        if ( elParentPanel.isTournament )
        {
            elPlayerName.text = MatchInfoAPI.GetMatchPlayerStat( elParentPanel.matchId, elPlayerName.playerXuid, 'name' );
        }
        else
        {
            elPlayerName.text = FriendsListAPI.GetFriendName( elPlayerName.playerXuid );
        }
    }

    function _UpdateTitle( elParentPanel, playerXuid )
    {
        if ( elParentPanel.isTournament )
        {
            elParentPanel.SetDialogVariable( 'playerNameTitle', MatchInfoAPI.GetMatchPlayerStat( elParentPanel.matchId, playerXuid, 'name' ) );
        }
        else
        {
            elParentPanel.SetDialogVariable( 'playerNameTitle', FriendsListAPI.GetFriendName( playerXuid ) );
        }

		var elWatchHighlightsButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch-highlights' );
		var elWatchLowlightsButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch-lowlights' );
        if ( elWatchHighlightsButton )
        {
			elWatchHighlightsButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elWatchHighlightsButton, UiToolkitAPI.MakeStringSafe( $.Localize( '#WatchMenu_Watch_Highlights_Player_Selected', elParentPanel) ) ); } );
			elWatchLowlightsButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elWatchLowlightsButton, UiToolkitAPI.MakeStringSafe( $.Localize( '#WatchMenu_Watch_Lowlights_Player_Selected', elParentPanel) ) ); } );
        }
    }

    function _Show( elParentPanel )
    {
        elParentPanel.SetReadyForDisplay( true );
        elParentPanel.visible = true;
        elParentPanel.RemoveClass( 'mi-sb--hidden' );

        elParentPanel.updateMatchMenuHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_MatchInfo_StateChange', _UpdateMatchMenu.bind( undefined, elParentPanel) );

    }

    function _OnFadeOutEnd( elParentPanel, propertyName )
    {
        if( elParentPanel.visible === true && elParentPanel.BIsTransparent() )
        {
                                                           
            elParentPanel.visible = false;
            elParentPanel.SetReadyForDisplay( false );
        }
    }

    function _Hide( elParentPanel )
    {
        for ( var teamId in TEAMS )
        {
            var elTeam = elParentPanel.FindChildInLayoutFile( 'players-table-' + TEAMS[teamId] );
            for ( var i = 0; i < TEAMSIZE; i++ )
            {
                var elPlayerName = elTeam.GetChild( i ).FindChildTraverse( 'name__label' );
                
                if ( elPlayerName.nameUpdateHandler )
                {
                    $.UnregisterForUnhandledEvent( 'PanoramaComponent_FriendsList_NameChanged', elPlayerName.nameUpdateHandler );
                    elPlayerName.nameUpdateHandler = undefined;
                }
            }
        }
        if ( elParentPanel.downloadFailedHandler )
        {
            $.CancelScheduled( elParentPanel.downloadFailedHandler );
            elParentPanel.downloadFailedHandler = undefined;
        }

        if ( elParentPanel.updateMatchInfoHandler )
        {
            $.UnregisterForUnhandledEvent( 'PanoramaComponent_MatchInfo_StateChange', elParentPanel.updateMatchInfoHandler );
            elParentPanel.updateMatchInfoHandler = undefined;
        }

        var elTitle = elParentPanel.FindChildInLayoutFile( 'id-mi-player-stats-title' );
        if ( elTitle.nameUpdateHandler )
        {
            $.UnregisterForUnhandledEvent( 'PanoramaComponent_FriendsList_NameChanged', elTitle.nameUpdateHandler );
            elTitle.nameUpdateHandler = undefined;
        }

        elParentPanel.AddClass( 'mi-sb--hidden' );
    }

    function _FillRoundStats( elParentPanel, elPlayerRow )
    {
        var tickPatternOvertime = [
            'mi-round-tick--right-of-team-switch',
            'mi-round-tick--sub',
            'mi-round-tick--sub',
            'mi-round-tick--sub',
            'mi-round-tick--sub',
            'mi-round-tick--major'
        ]

        function flipBit( n )
        {
            if ( n == 0 ) return 1;
            return 0;
        }

        var elTitle = elParentPanel.FindChildInLayoutFile( 'id-mi-player-stats-title' );
        if ( elTitle.nameUpdateHandler == undefined )
        {
            elTitle.nameUpdateHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_FriendsList_NameChanged', _UpdateTitle.bind( undefined, elParentPanel, elPlayerRow.playerXuid ) );
        }
        _UpdateTitle( elParentPanel, elPlayerRow.playerXuid );

        var currentTeamId = elPlayerRow.teamId;
        
        if ( elParentPanel.activePlayerRow )
        {
            elParentPanel.activePlayerRow.checked = false;
            elParentPanel.activePlayerRow.RemoveClass( 'no-hover' );
        }
        elPlayerRow.checked = true;
        elPlayerRow.AddClass( 'no-hover' );
        elParentPanel.activePlayerRow = elPlayerRow;

        var isLive = Boolean(MatchInfoAPI.IsLive(elParentPanel.matchId));
        if (isLive == false)
        {
            elParentPanel.FindChildInLayoutFile('id-mi-player-stats').RemoveClass('mi-player-stats__collapse');
        }

        var elStatsContainer = elParentPanel.FindChildInLayoutFile( 'id-mi-round-stats__container' );
        var elTickLabels = elParentPanel.FindChildInLayoutFile( 'id-mi-round-stats__tick-labels' );

        var team0Score = MatchInfoAPI.GetMatchRoundScoreForTeam( elParentPanel.matchId, 0 );
        if ( team0Score === undefined )
            team0Score = 0;
        
        var team1Score = MatchInfoAPI.GetMatchRoundScoreForTeam( elParentPanel.matchId, 1 );
        if ( team1Score === undefined )
            team1Score = 0;
        
        var playedRounds = team0Score + team1Score;
        var maxRounds = MatchInfoAPI.GetMatchMaxRounds( elParentPanel.matchId );
        var totalRounds = Math.max( playedRounds, maxRounds );
        
        var nOvertime = Math.ceil( ( totalRounds - maxRounds ) / 6 );
        if ( nOvertime > 0 )
        {
            totalRounds = maxRounds + 6 * nOvertime;
        }
        var totalBars = elStatsContainer.Children().length;

        elStatsContainer.SetHasClass( "horizontal-center", nOvertime == 0 );
                                                                                                                                         


		                        
		var roundWins = MatchInfoAPI.GetMatchPlayerRoundStats( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid, "round_wins" );
		roundWins = roundWins ? roundWins.split( ',' ) : Array( totalRounds ).fill( 0 );
		var mvps = MatchInfoAPI.GetMatchPlayerRoundStats( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid, "mvps" );
		mvps = mvps ? mvps.split( ',' ) : Array( totalRounds ).fill( 0 );
		var kills = MatchInfoAPI.GetMatchPlayerRoundStats( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid, "enemy_kills" );
		kills = kills ? kills.split( ',' ) : Array( totalRounds ).fill( 0 );
		var headshots = MatchInfoAPI.GetMatchPlayerRoundStats( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid, "enemy_headshots" );
		headshots = headshots ? headshots.split( ',' ) : Array( totalRounds ).fill( 0 );
		var deaths = MatchInfoAPI.GetMatchPlayerRoundStats( elParentPanel.matchId, elParentPanel.activePlayerRow.playerXuid, "deaths" );
		deaths = deaths ? deaths.split( ',' ) : Array( totalRounds ).fill( 0 );

                   
        function _IsMajorTick ( n )
        {
                          
            if ( n == 1 )
                return true;
            
                                     
            if ( n == maxRounds )
                return true;
            
                                                         
            if ( n == totalRounds )
                return true;
            
                           
            if ( n > maxRounds && ( ( n - maxRounds ) % 6 == 0 ) )
                return true;

            return false;
        }

        function _IsMinorTick ( n )
        {
            if ( n < maxRounds )
            {
                if ( maxRounds % 5 == 0 )
                    return ( n % 5 == 0 );
                else if ( maxRounds % 4 == 0 )
                    return ( n % 4 == 0 );
                else if ( maxRounds <= 12 && maxRounds % 3 == 0 )
                    return ( n % 3 == 0 );
                else if ( maxRounds <= 8 && maxRounds % 2 == 0 )
                    return ( n % 2 == 0 );
            }
            else            
            {
                                       
            }

            return false;
        }

        function _IsRightOfHalftime ( n )
        {
            if ( n == ( maxRounds / 2 + 1 ) )
                return true;
        }

        function _IsLeftOfHalftime ( n )
        {
            if ( n == ( maxRounds / 2 ) )
                return true;
        }

        function _GetTickStyleForRound ( n )
        {
            if ( _IsRightOfHalftime( n ) )
                return 'mi-round-tick--right-of-team-switch';
            else if ( _IsLeftOfHalftime( n ) )
                return 'mi-round-tick--left-of-team-switch';
            else if ( _IsMajorTick( n ) )
                return 'mi-round-tick--major';
            else if ( _IsMinorTick( n ) )
                return 'mi-round-tick--minor';
            else
                return 'mi-round-tick--sub';
        }

        function _IsOvertime ( n )
        {
            return ( n > maxRounds );
        }

        function _OverTimeLabel ( n )
        {
            if ( n <= maxRounds )
                return '';
            
            let ot = Math.ceil( n - maxRounds ) / 6;
            
            if ( nOvertime > 1 )
            {
                return $.Localize( '#MatchInfo_Overtime' ) + ' ' + ( ot );
            }
            else
            {
                return $.Localize( '#MatchInfo_Overtime' );
            }
        }

        function _GetLabelForTick ( n )
        {
            if ( _IsRightOfHalftime( n ) )
                return '<>';
            else if ( _IsRightOfHalftime( n ) || _IsLeftOfHalftime( n ) )
                return '';
            else if ( _IsMajorTick( n ) || _IsMinorTick( n ))
                return n;
            else
                return '';
        }

                                                                                                  
                                                                                                       
        var numTimesPlayersChangedSides = 0;
        numTimesPlayersChangedSides += ( ( totalRounds > (maxRounds / 2) ) ? 1 : 0 );                           
        if ( totalRounds > maxRounds )
        {
            var numRoundsPlayedInLastOvertime = ( totalRounds - maxRounds ) % 6;
            var numFullOvertimesPlayed = ( totalRounds - maxRounds - numRoundsPlayedInLastOvertime ) / 6;
                                                                                                                            
            numTimesPlayersChangedSides += numFullOvertimesPlayed + ( ( numRoundsPlayedInLastOvertime > 3 ) ? 1 : 0 );
        }
                                                                                          
        if ( numTimesPlayersChangedSides % 2 == 1 )
        {
            currentTeamId = flipBit( currentTeamId );
        }

                                                                   
        for ( var i = 1; i <= totalRounds; i++ )
        {
            var elRoundStats = undefined;
            if ( i > totalBars )
            {
                elRoundStats = $.CreatePanel( 'Button', elStatsContainer, 'id-stat-bar-round' + i );
                elRoundStats.BLoadLayoutSnippet( 'snippet_mi-round-summary-bar' );
                elRoundStats.AddClass( 'round-selection-button' );
            }
            else
            {
               elRoundStats = elStatsContainer.GetChild( i-1 );
            }
            
            var elRoundBar = elRoundStats.FindChildTraverse( 'id-mi-round-summary-bar__container' );
            var elIconContainer = elRoundStats.FindChildTraverse( 'id-mi-icons__container');

            if ( i > totalBars )
            {                
                var elTick = elRoundBar.GetChild( 2 ).GetChild( 1 );
                {
                    elTick.AddClass( _GetTickStyleForRound( i ) );
                }
                
            }
            else
            {
                elRoundBar.RemoveClass( 'hide' );
            }
            var elWinBar = elRoundBar.GetChild( 0 ).GetChild( 0 );
            var elWinLossBorder = elRoundBar.GetChild( 1 );
            var elLossBar = elRoundBar.GetChild( 2 ).GetChild( 0 );
            if ( i > playedRounds )
            {
                elWinLossBorder.RemoveClass( 'sb-tint--CT' )
                elWinLossBorder.RemoveClass( 'sb-tint--TERRORIST' )
                elWinBar.AddClass( 'mi-round-summary-bar--EMPTY' );
                elLossBar.AddClass( 'mi-round-summary-bar--EMPTY' );
                elIconContainer.AddClass( 'hide' );
                elRoundStats.AddClass( 'no-hover' );
            }
            else
            {
                _RefreshRoundWatchEnabled( elParentPanel )
                elIconContainer.RemoveClass( 'hide' );

                var n = i-1;

                var elMVPStarImg = elRoundStats.FindChildTraverse( 'id-mvp-star' );
                                                
                if ( mvps[n] != 0)
                {
                    elMVPStarImg.RemoveClass( 'hide' );
                    elMVPStarImg.RemoveClass( 'sb-tint--' + TEAMS[ flipBit( currentTeamId ) ] );
                    elMVPStarImg.AddClass( 'sb-tint--' + TEAMS[ currentTeamId ] );
                }
                else
                {
                    elMVPStarImg.AddClass( 'hide' );
                }

                                     
                var nKills = parseInt( kills[n] );
                var nHeadshots = parseInt( headshots[n] );

                var elEliminationWinIcons = elRoundStats.FindChildTraverse( 'id-mi-eliminations-win' );
                for ( var k = 0; k < 5; k++ )
                {
                    var kIcon = elEliminationWinIcons.FindChildTraverse( 'id-mi-icon-elimination_' + k );
                    var hIcon = elEliminationWinIcons.FindChildTraverse( 'id-mi-icon-elimination--headshot_' + k );
                    if ( k >= ( nKills ) )
                    {
                        kIcon.AddClass( 'hide' );
                        hIcon.AddClass( 'hide' );
                    }
                    else if ( k >= nHeadshots )
                    {
                        kIcon.RemoveClass( 'hide' );
                        hIcon.AddClass( 'hide' );
                    }
                    else
                    {
                        kIcon.AddClass( 'hide' );
                        hIcon.RemoveClass( 'hide' );
                    }
                }

                        
                var elDeathIcon = elIconContainer.FindChildTraverse( 'id-mi-elimination-death' );
                if ( deaths[n] == 1 )
                {
                    elDeathIcon.RemoveClass( 'hide' );
                }
                else
                {
                    elDeathIcon.AddClass( 'hide' );
                }

                if ( roundWins[n] == 1 )
                {
                    elWinBar.RemoveClass( 'mi-round-summary-bar--EMPTY' );
                    elLossBar.AddClass( 'mi-round-summary-bar--EMPTY' );
                }
                else
                {
                    elWinBar.AddClass( 'mi-round-summary-bar--EMPTY' );
                    elLossBar.RemoveClass( 'mi-round-summary-bar--EMPTY' );
                }
                elWinBar.RemoveClass( 'sb-tint--' + TEAMS[ flipBit( currentTeamId ) ] );
                elWinBar.AddClass( 'sb-tint--' + TEAMS[ currentTeamId ] );
                elWinLossBorder.RemoveClass( 'sb-tint--' + TEAMS[ flipBit( currentTeamId ) ] );
                elWinLossBorder.AddClass( 'sb-tint--' + TEAMS[ currentTeamId ] );
                elEliminationWinIcons.RemoveClass( 'sb-tint--' + TEAMS[ flipBit( currentTeamId ) ] );
                elEliminationWinIcons.AddClass( 'sb-tint--' + TEAMS[ currentTeamId ] );
            }
            if ( ( i == maxRounds / 2 ) || ( ( i > maxRounds ) && ( ( ( i - maxRounds ) % 6 ) == 3 ) ) )
            {
                currentTeamId = flipBit( currentTeamId );
            }
        }
       
                          
        var elTickLabels = elParentPanel.FindChildInLayoutFile( 'id-mi-round-stats__tick-labels' );
        elTickLabels.RemoveAndDeleteChildren();

        for ( var i = 1; i <= totalRounds; i++ )
        {
            var elTick = $.CreatePanel( 'Panel', elTickLabels, 'id-tick' + i );
            elTick.BLoadLayoutSnippet( 'snippet-tick' );

            let strLabelForTick = _GetLabelForTick( i );
            elTick.SetDialogVariable( 'n', strLabelForTick );
            elTick.SetHasClass( 'mi-tick-class-halftime-align', strLabelForTick === '<>' );
        }



	}
	
	function _OpenPlayerCard( xuid )
	{
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.sidemenu_select', 'MOUSE' );
		var elPlayerCardContextMenu = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(
			'id-player-' + xuid,
			'',
			'file://{resources}/layout/context_menus/context_menu_playercard.xml', 
			'xuid='+xuid,
			function(){}
		)

		elPlayerCardContextMenu.AddClass( "ContextMenu_NoArrow" );
	}

    function _FillScoreboard( elParentPanel )                              
    {

        var elScoreboard = elParentPanel.FindChildInLayoutFile( 'Scoreboard' );
        elScoreboard.visible = true;
        _ShowMatchSpinner( false, elParentPanel );                           
        _SetMatchMessage( "", false, elParentPanel );                           

                                                                                                                       
        var currentTopPanelTeamId = MatchInfoAPI.GetMatchTournamentTeamID( elParentPanel.matchId, 0 );
        if ( elParentPanel.teamsFilled )
        {
            if ( currentTopPanelTeamId != elParentPanel.cachedTopPanelTeamId )
            {
                elParentPanel.teamsFilled = false;
            }
        }
        elParentPanel.cachedTopPanelTeamId = currentTopPanelTeamId;

        function Helper_FillTeamStats( teamId )
        {
            var elTeam = elParentPanel.FindChildInLayoutFile( 'players-table-' + TEAMS[teamId] );
            var elScoreboxBackdrop = elParentPanel.FindChildInLayoutFile( 'id-sb-scorebox_backdrop--' + TEAMS[teamId] );
            if ( elParentPanel.isTournament )
            {
				var tag = MatchInfoAPI.GetMatchTournamentTeamTag( elParentPanel.matchId, teamId );
				if ( !tag )
				{
					tag = '';
				}
                elScoreboxBackdrop.SetImage( 'file://{images}/tournaments/teams/' + tag.toLowerCase() + '.svg' );
                elScoreboxBackdrop.AddClass( 'scorebox_backdrop--tournament' );
                elParentPanel.SetDialogVariable( 'sb_team_name--' + TEAMS[teamId], MatchInfoAPI.GetMatchTournamentTeamName( elParentPanel.matchId, teamId ) );
            }
            else
            {
                elParentPanel.SetDialogVariable( 'sb_team_name--' + TEAMS[teamId], $.Localize( '#teamname_' + TEAMS[teamId] ) );
            }
            elParentPanel.SetDialogVariable( 'score_' + TEAMS[teamId], MatchInfoAPI.GetMatchRoundScoreForTeam( elParentPanel.matchId, teamId ) );
            for ( var i = 0; i < TEAMSIZE; i++ )
            {
                var elPlayerRow = elTeam.GetChild( i );
                if ( !elParentPanel.teamsFilled )
                {
                    elPlayerRow.playerXuid = MatchInfoAPI.GetMatchPlayerXuidByIndexForTeam( elParentPanel.matchId, teamId, i );
                }
                var playerXuid = elPlayerRow.playerXuid;
                var elPlayerName = elPlayerRow.FindChildTraverse( 'name__label');
				var elAvatarImage = elPlayerRow.FindChildTraverse( 'avatar' );
				var elAvatarTeamLogo = elPlayerRow.FindChildTraverse( 'avatarteamlogo' );
                if ( !elParentPanel.teamsFilled )
                {
                    elPlayerName.matchId = elParentPanel.matchId;
                    elPlayerName.playerXuid = playerXuid;
					elAvatarImage.SetPanelEvent( 'onactivate', _OpenPlayerCard.bind( undefined, playerXuid ) );
					elAvatarTeamLogo.SetPanelEvent( 'onactivate', _OpenPlayerCard.bind( undefined, playerXuid ) );
                }
                if ( elPlayerName.nameUpdateHandler == undefined )
                {
                    elPlayerName.nameUpdateHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_FriendsList_NameChanged', _UpdateName.bind( undefined, elParentPanel, elPlayerName ) );
                }
                _UpdateName( elParentPanel, elPlayerName );
                
                    
                if ( !elParentPanel.teamsFilled )
                {
					var tag = MatchInfoAPI.GetMatchTournamentTeamTag( elParentPanel.matchId, teamId );
					if ( !tag )
					{
						tag = '';
					}

					elAvatarImage.visible = !elParentPanel.isTournament;
					elAvatarTeamLogo.visible = elParentPanel.isTournament;
					if ( elParentPanel.isTournament )
					{
						elAvatarTeamLogo.SetImage( 'file://{images}/tournaments/teams/' + tag.toLowerCase() + '.svg' );
					}
                    else if ( elAvatarImage.steamid !== playerXuid )
                    {
                        elAvatarImage.PopulateFromSteamID(playerXuid);
                    }
                }

                for ( var p in PLAYERSTATS )
                {
                    var elStat = elPlayerRow.FindChildTraverse( PLAYERSTATS[p] )
                    var elStatData = MatchInfoAPI.GetMatchPlayerStat( elParentPanel.matchId, playerXuid, PLAYERSTATS[p] );
                    elStat.text = elStatData;
                    if ( PLAYERSTATS[p] === 'mvps' )
                    {
                        if ( elStatData == 0 )
                        {
                            elPlayerRow.FindChildTraverse( 'mvps__panel' ).AddClass( 'hide-mvps' );
                        }
                        else
                        {
                            elPlayerRow.FindChildTraverse( 'mvps__panel' ).RemoveClass( 'hide-mvps' );
                        }
                    }
                }
            }
        }

        Helper_FillTeamStats( 0 );
        Helper_FillTeamStats( 1 );
        elParentPanel.teamsFilled = true;

        var rawModeName = MatchInfoAPI.GetMatchMode( elParentPanel.matchId );
        var rawMapName = MatchInfoAPI.GetMatchMap( elParentPanel.matchId );
        var mapStringPrefix = '#SFUI_Map_';
        var mapName = $.Localize( mapStringPrefix + rawMapName );
        if ( mapName === mapStringPrefix + rawMapName ) mapName = rawMapName;
        elParentPanel.SetDialogVariable( 'map_name', mapName );

          
                   
          
        var elMatchMapIcon = elParentPanel.FindChildTraverse( "id-mi-map-icon" );

        var setDefaultMapImage = function ( mapIcon )
        {
            mapIcon.SetImage( "file://{images}/map_icons/map_icon_NONE.png" );
        }

        if ( elMatchMapIcon )
        {
            $.RegisterEventHandler( 'ImageFailedLoad', elMatchMapIcon, setDefaultMapImage.bind( undefined, elMatchMapIcon ) );
            elMatchMapIcon.SetImage( "file://{images}/map_icons/map_icon_"+rawMapName+".svg" );
        }

          
                    
          
        var elMatchModeIcon = elParentPanel.FindChildTraverse( "id-mi-mode-icon" );

        var setDefaultModeImage = function ( mapIcon )
        {
            mapIcon.SetImage( "file://{images}/icons/ui/competitive.vsvg" );
        }

        if ( elMatchModeIcon )
        {
            $.RegisterEventHandler( 'ImageFailedLoad', elMatchModeIcon, setDefaultModeImage.bind( undefined, elMatchModeIcon ) );
            elMatchModeIcon.SetImage( "file://{images}/icons/ui/" + rawModeName + ".svg" );
        }

          
                                
          
        var matchDuration = MatchInfoAPI.GetMatchDuration( elParentPanel.matchId );
        matchDuration = Math.max( Math.floor( matchDuration / 60 ), 1 );
        elParentPanel.SetDialogVariable( 'duration', FormatText.FormatPluralLoc( '#CSGO_Watch_Minute:p', matchDuration ) );
        
        if ( elParentPanel.matchListDescriptor === 'live' )
        {
            var round = 1 + MatchInfoAPI.GetMatchRoundScoreForTeam( elParentPanel.matchId, 0 ) + MatchInfoAPI.GetMatchRoundScoreForTeam( elParentPanel.matchId, 1 );
			var progressionStateString = '#WatchMenu_FirstHalf';
			if ( round > 31 )
            {
                progressionStateString = '#WatchMenu_Overtime';
            }
            else if ( round > 15 )
            {
                progressionStateString = '#WatchMenu_SecondHalf';
            }
            elParentPanel.SetDialogVariable( 'dateOrRound', $.Localize( progressionStateString ) );
            elParentPanel.SetDialogVariable( 'dateOrRoundLabel', $.Localize( '#CSGO_Watch_Info_4' ) );
            elParentPanel.SetDialogVariable( 'durationLabel', $.Localize( "#CSGO_Watch_Info_5" ) );
        }
        else
        {
            elParentPanel.SetDialogVariable( 'dateOrRound', MatchInfoAPI.IsLive( elParentPanel.matchId ) ? $.Localize( '#CSGO_Watch_Cat_LiveMatches' ) : MatchInfoAPI.GetMatchTimestamp( elParentPanel.matchId ) );
            elParentPanel.SetDialogVariable( 'dateOrRoundLabel', $.Localize( '#CSGO_Watch_Info_2' ) );
            elParentPanel.SetDialogVariable( 'durationLabel', $.Localize( "#CSGO_Watch_Info_1" ) );
        }
    }

    function _FillServerLogTournamentInfo( elParentPanel )
    {
        PopulateForTeam( 0 );
        PopulateForTeam( 1 );

        function PopulateForTeam( nTeam )
        {
            var tag = MatchInfoAPI.GetMatchTournamentTeamTag( elParentPanel.matchId, nTeam );
            if ( tag )
            {
                var strFilename= 'file://{images}/tournaments/teams/' + tag.toLowerCase() + '.svg';
                var img = elParentPanel.FindChildTraverse( 'team_image' + nTeam );
                img.SetImage( strFilename );
            }

            elParentPanel.SetDialogVariable( 'teamname' + nTeam, MatchInfoAPI.GetMatchTournamentTeamName( elParentPanel.matchId, nTeam ) );
            elParentPanel.SetDialogVariable( 'score' + nTeam, MatchInfoAPI.GetMatchRoundScoreForTeam( elParentPanel.matchId, nTeam ) );
        }

        var rawMapName = MatchInfoAPI.GetMatchMap( elParentPanel.matchId );
        var mapStringPrefix = '#SFUI_Map_';
        var mapName = $.Localize( mapStringPrefix + rawMapName );
        if ( mapName === mapStringPrefix + rawMapName ) mapName = rawMapName;
        elParentPanel.SetDialogVariable( 'mapname', mapName );
        var elMatchMapIcon = elParentPanel.FindChildTraverse( "map_image" );
        if ( elMatchMapIcon )
        {
            elMatchMapIcon.SetImage( "file://{images}/map_icons/map_icon_"+rawMapName+".svg" );
        }
        
        var elTournamentLogo = elParentPanel.FindChildTraverse( "tournament_logo" );
        elTournamentLogo.SetImage( 'file://{images}/tournaments/events/tournament_logo_' + elParentPanel.tournamentIndex + '.svg' );

        elParentPanel.SetDialogVariable( 'tournamentphase', $.Localize( MatchInfoAPI.GetMatchTournamentStageName( elParentPanel.matchId ) ) );
        elParentPanel.SetDialogVariable( 'matchphase', MatchInfoAPI.IsLive( elParentPanel.matchId ) ? $.Localize( '#CSGO_Watch_Cat_LiveMatches' ) : MatchInfoAPI.GetMatchTimestamp( elParentPanel.matchId ) );
    }

    function _Init( elParentPanel )
    {
        _ShowMatchSpinner( true, elParentPanel );                           
        _SetMatchMessage( "", false, elParentPanel );                           

        var bIsMinimalMatchInfo = MatchInfoAPI.IsServerLogTournamentMatch( elParentPanel.matchId );
        elParentPanel.SetHasClass( 'matchinfo--minimal', bIsMinimalMatchInfo );
        if ( bIsMinimalMatchInfo )
        {
            var minimalInfoBody = $.CreatePanel( 'Panel', elParentPanel, 'minimal-match-info' );
            minimalInfoBody.BLoadLayoutSnippet( 'matchinfo_serverlogtournament_minimal');
        }

        var myXuid = MyPersonaAPI.GetXuid();

        function Helper_CreateScoreboard( teamId )
        {
            var elRowToActivate = undefined;
            var elTeam = elParentPanel.FindChildInLayoutFile( 'players-table-' + TEAMS[teamId] );
            for ( var i = 0; i < TEAMSIZE; i++ )
            {   
                var playerXuid = MatchInfoAPI.GetMatchPlayerXuidByIndexForTeam( elParentPanel.matchId, teamId, i );
                var elPlayerRow = $.CreatePanel('Panel', elTeam, 'id-player-' + playerXuid);
                if ( !playerXuid )
                {
                    elTeam.AddClass( 'with-empty-rows' );
                }
                elPlayerRow.playerXuid = playerXuid;
                elPlayerRow.teamId = teamId;
                if ( elParentPanel.matchListDescriptor != 'live' )
                {
                    elPlayerRow.SetPanelEvent( 'onactivate', _FillRoundStats.bind( undefined, elParentPanel, elPlayerRow ) );
                    if ( ( ( i == 0 ) && ( teamId == 0 ) ) || ( myXuid === playerXuid ) )
                    {
                        elParentPanel.activePlayerRow = elPlayerRow;
                    }
                }
                elPlayerRow.BLoadLayoutSnippet( 'snippet_scoreboard-classic__row--comp' );
                var elAvatarImage = elPlayerRow.FindChildTraverse( 'avatar' );
				elAvatarImage.AddClass( 'sb-row__cell--avatar--' + TEAMS[teamId] );
				
				var elPlayerNameLabel = elPlayerRow.FindChildTraverse( 'name__label' );
				elPlayerNameLabel.AddClass( 'sb-tint--' + TEAMS[teamId] );
				elPlayerNameLabel.SetPanelEvent( 'onactivate',
					function( elParentPanel, elPlayerRow, playerXuid )
					{	                                                  
						if ( elParentPanel.matchListDescriptor != 'live' )
							_FillRoundStats( elParentPanel, elPlayerRow );
						_OpenPlayerCard( playerXuid );
					}
					.bind( undefined, elParentPanel, elPlayerRow, playerXuid ) );

                var elStatsContainer = elPlayerRow.FindChildTraverse( 'id-sb-row-stats' );

                for ( var p in PLAYERSTATS )
                {
                    var elStat;
                    if ( PLAYERSTATS[p] ==='mvps' )
                    {
                        var elMvpsPanel = $.CreatePanel( 'Panel', elStatsContainer, 'mvps__panel' );
                        var elStar = $.CreatePanel( "Image", elMvpsPanel, 'mvps--image' );
                        elStar.SetImage( 'file://{images}/icons/ui/star.svg' );
						elStar.text = $.Localize( '#Scoreboard_MVP_Star' );
                        elStat = $.CreatePanel( 'Label', elMvpsPanel, PLAYERSTATS[p] );
                        elStat.AddClass( 'mi-mvps-shrink-overflow' );
                        elMvpsPanel.AddClass( 'sb-row__cell' );
                        elMvpsPanel.AddClass( 'sb-row__cell--mvps' );
                        elStar.AddClass( 'sb-row__cell--mvps__star' );
						elStat.AddClass( 'sb-row__cell--mvps__count'  );
						elStat = elMvpsPanel;                                                   
                    }
                    else
                    {
                        elStat = $.CreatePanel( 'Panel', elStatsContainer, "" );
                        elStat.AddClass( 'sb-row__cell' );
                        elStat.AddClass( 'sb-row__cell--' + PLAYERSTATS[p] );
                        elStat = $.CreatePanel( 'Label', elStat, PLAYERSTATS[p] );
					}
					
					elStat.AddClass( 'sb-tint--' + TEAMS[teamId] );
                }
            }
        }
        
        Helper_CreateScoreboard( 0 );
        Helper_CreateScoreboard( 1 );

        var tournamentName = MatchInfoAPI.GetMatchTournamentName( elParentPanel.matchId );
        elParentPanel.isTournament = ( ( tournamentName != "" ) && ( tournamentName != undefined ) );
        elParentPanel.matchShareToken = MatchInfoAPI.GetMatchShareToken( elParentPanel.matchId, "text" );

        elParentPanel.downloadFailedTest = undefined;
        elParentPanel.updateMatchInfoHandler = undefined;
        elParentPanel.teamsFilled = false;
        var elColumnLabels = elParentPanel.FindChildInLayoutFile( 'players-table__labels-row' )
        for ( var p in PLAYERSTATS )
        {
            var elStatContainter = $.CreatePanel( 'Panel', elColumnLabels, "" );
            elStatContainter.AddClass( 'sb-row__cell' );
			elStatContainter.AddClass( 'sb-row__cell--' + PLAYERSTATS[p] );
			elStatContainter.AddClass( 'matchinfo-scoreboard-header-stat-cell' );
            var elStatLabel = $.CreatePanel( 'Label', elStatContainter, PLAYERSTATS[p] );
            elStatLabel.text = $.Localize( '#Scoreboard_' + PLAYERSTATS[p] + '_header' );
        }

        $.RegisterEventHandler( 'PropertyTransitionEnd', elParentPanel, _OnFadeOutEnd.bind( undefined, elParentPanel ) );

        var elDownloadButton = elParentPanel.FindChildInLayoutFile( 'id-mi-download' );
        var elShareLinkButton = elParentPanel.FindChildInLayoutFile( 'id-mi-copy' );
        var elWatchButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch' );
		var elWatchHighlightsButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch-highlights' );
		var elWatchLowlightsButton = elParentPanel.FindChildInLayoutFile( 'id-mi-watch-lowlights' );
        var elDeleteButton = elParentPanel.FindChildInLayoutFile( 'id-mi-delete' );
        var elDownloadingButton = elParentPanel.FindChildInLayoutFile( 'id-mi-downloading' );
        var elDownloadFailedButton = elParentPanel.FindChildInLayoutFile( 'id-mi-error-delete' );
        var elSouvenirButton = elParentPanel.FindChildInLayoutFile( 'id-mi-souvenir' );


        if ( elWatchButton && ( elParentPanel.matchListDescriptor == 'live' ) )
        {
            var elWatchLabel = elWatchButton.GetChild( 0 );
            elWatchLabel.text = $.Localize(  "#WatchMenu_Watch_Live" );
            elWatchLabel.style.textTransform = "uppercase";
        }

        elDownloadButton.SetPanelEvent( 'onactivate', _DownloadMatch.bind( undefined, elParentPanel ) );
        elShareLinkButton.SetPanelEvent( 'onactivate', _ShareMatch.bind( undefined, elParentPanel ) );
        elShareLinkButton.SetDialogVariable( 'matchcode', elParentPanel.matchShareToken );
        elShareLinkButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elShareLinkButton, $.Localize( '#WatchMenu_Get_Share_Link') ); } );
        elShareLinkButton.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideTextTooltip(); } );
        elWatchButton.SetPanelEvent( 'onactivate', _Watch.bind( undefined, elParentPanel ) );
        elWatchHighlightsButton.SetPanelEvent( 'onactivate', _WatchHighlights.bind( undefined, elParentPanel ) );
        elWatchHighlightsButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elWatchHighlightsButton, $.Localize( '#WatchMenu_Watch_Highlights') ); } );
        elWatchHighlightsButton.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideTextTooltip(); } );
        elWatchLowlightsButton.SetPanelEvent( 'onactivate', _WatchLowlights.bind( undefined, elParentPanel ) );
        elWatchLowlightsButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elWatchLowlightsButton, $.Localize( '#WatchMenu_Watch_Lowlights') ); } );
        elWatchLowlightsButton.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideTextTooltip(); } );
        elDeleteButton.SetPanelEvent( 'onactivate', _DeleteDemo.bind( undefined, elParentPanel ) );
        elDeleteButton.SetPanelEvent( 'onmouseover', function(){ UiToolkitAPI.ShowTextTooltipOnPanel( elDeleteButton, $.Localize( '#WatchMenu_Delete') ); } );
        elDeleteButton.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideTextTooltip(); } );
        elDownloadFailedButton.SetPanelEvent( 'onactivate', _DownloadFailedNotify.bind( undefined, elParentPanel ) );
        elSouvenirButton.SetPanelEvent( 'onactivate', _RedeemSouvenir.bind( undefined, elParentPanel.tournamentIndex, elParentPanel.matchId ) );

        

        _Refresh( elParentPanel );
    }

                          
	return {
        Init                    : _Init,
        Hide                    : _Hide,
        Refresh                 : _Refresh,
    };

})();

                                                                                                    
                                           
                                                                                                    
(function()
{
})();

