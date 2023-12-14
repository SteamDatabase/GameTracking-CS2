'use strict';

var watchTile = ( function() {

    var TEAMS =[ 'CT', 'TERRORIST' ];

    function _SetParentActive( elTile, value )
    {
        if ( !elTile.markForDelete )
        {
            var elLogo = elTile.FindChildTraverse( 'gotvicon' );
            if ( elLogo )
            {
                if ( value )
                {
                    elLogo.AddClass( 'GOTV-Icon--ParentActive' );
                }
                else
                {
                    elLogo.RemoveClass( 'GOTV-Icon--ParentActive' );
                }
            }
        }
    }
    
    function _Delete( elTile )
    {
        $.DispatchEvent( 'DeletePanel', elTile );
	}

	function _CheckPlayerParticipatedInMatch( elTile )
	{
		var bPlayerParticipated = false;
		var myTeam = 0;

		for ( var t = 0; t < 2; t++ )
		{
            for ( var n = 0; n < 5; n++ )
            {
                var playerXuid = MatchInfoAPI.GetMatchPlayerXuidByIndexForTeam( elTile.matchId, t, n );
                if ( playerXuid === elTile.myXuid ) 
                {
                    bPlayerParticipated = true;
                    myTeam = t;
                }
			}
		}

		return { bPlayerParticipated: bPlayerParticipated, myTeam: myTeam };
	}

    function _Init( elTile )
    {
        var bPlayerParticipated = false;

        var matchState = MatchInfoAPI.GetMatchState( elTile.matchId );

        var matchTileDescriptor = 'player';

        var myTeam = 0;

        if ( elTile.id == 'live_gotv' ) matchTileDescriptor = 'gotv';

        var isLive = Boolean(MatchInfoAPI.IsLive(elTile.matchId));
        var tournamentName = MatchInfoAPI.GetMatchTournamentName( elTile.matchId );
        if ( ( tournamentName != undefined ) && ( tournamentName != "" ) )
        {
            matchTileDescriptor = 'tournament';
        }
        else if ( matchState == 'live' ) 
        {
            matchTileDescriptor = 'live';
        }

		var _multiresult = _CheckPlayerParticipatedInMatch( elTile );
		bPlayerParticipated = _multiresult.bPlayerParticipated;
		myTeam = _multiresult.myTeam;

        var rawModeName = MatchInfoAPI.GetMatchMode( elTile.matchId );
        var mapName = MatchInfoAPI.GetMatchMap( elTile.matchId );

		                                                                                                                                                    
        elTile.BLoadLayout( "file://{resources}/layout/matchtiles/"+matchTileDescriptor+".xml", true, false );
        var elTileMenu = elTile.FindChildTraverse( 'MatchTileMenu' );

        var elDownloadingButton = undefined;
        var elDownloadButton = undefined;
        var elShareButton = undefined;
        var elMoreButton = undefined;
        var elDownloadFailedButton = undefined;
        var elWatchButton = undefined;

        if ( elTileMenu )
        {
            if ( elTile.matchListDescriptor === 'live' )
            {
                elWatchButton = _AddButton( elTileMenu, elTile.matchListDescriptor + "_" + elTile.matchId, "watch", $.Localize( "#CSGO_Watch_Info_live"), _Watch.bind( "", elTile), false );
            }
            else
            {
                elShareButton =  _AddButton( elTileMenu, elTile.matchListDescriptor + "_" + elTile.matchId, "link", $.Localize( "#CSGO_Watch_Copy_Url" ), _ShareMatch.bind( "", elTile ), false );
                elDownloadButton = _AddButton( elTileMenu, elTile.matchListDescriptor + "_" + elTile.matchId, "downloaded", $.Localize( "#CSGO_Watch_Download" ), _DownloadMatch.bind( "", elTile ), false );
                elDownloadingButton = _AddButton( elTileMenu, elTile.matchListDescriptor + "_" + elTile.matchId, "downloading", $.Localize( "#SFUI_GameUI_MatchDlDownloading"), undefined, true );
                elDownloadFailedButton = _AddButton( elTileMenu, elTile.matchListDescriptor + "_" + elTile.matchId, "warning", $.Localize( "#WatchMenu_Info_Download_Failed" ), _UpdateFailedNotify.bind( "", elTile ), false );
                elMoreButton = _AddButton( elTileMenu, elTile.matchListDescriptor + "_" + elTile.matchId, "expand", $.Localize( "#WatchMenu_Expand_Match_Menu" ), _OpenContextMenu.bind( "", elTile ), false );
                                              
            }
        }

        var elMatchMapLabel = elTile.FindChildInLayoutFile('mapname');
        var elMatchMapIcon = elTile.FindChildInLayoutFile( 'mapicon' );
        var elMatchModeIcon = elTile.FindChildInLayoutFile( 'modeicon' );
		var elSkillGroupImg = elTile.FindChildInLayoutFile( 'skillgroup' );
        var elScore0Label = elTile.FindChildInLayoutFile('score_team0');
        var elVsLabel = elTile.FindChildInLayoutFile( 'vs' );
        var elScore1Label = elTile.FindChildInLayoutFile('score_team1');
        var elViewersLabel = elTile.FindChildInLayoutFile('viewers');
        var elOutcomeLabel = elTile.FindChildInLayoutFile('outcome');
        var elTimestampLabel = elTile.FindChildInLayoutFile('timestamp');

        if ( elMatchMapLabel )
        {
            var mapLabelText = "#SFUI_Map_"+mapName;
            var mapLabelLocalizedText = $.Localize( "#SFUI_Map_"+mapName );
            if ( mapLabelText === mapLabelLocalizedText )
            {
                elMatchMapLabel.text = mapName;
            }
            else
            {
                elMatchMapLabel.text = mapLabelLocalizedText;
            }
        }

                                                                                                                    
        var team0 = 0;
        var team1 = 1;
        if ( bPlayerParticipated && ( myTeam != 0 ) )
        {
            team0 = 1;
            team1 = 0;
        }

        var vsText = '-';
        if ( matchTileDescriptor === 'tournament' )
        {
            var elTournamentNameLabel = elTile.FindChildInLayoutFile('tournamentname');
            var elTournamentTeam0Icon = elTile.FindChildInLayoutFile('team0');
            var elTournamentTeam1Icon = elTile.FindChildInLayoutFile('team1');
            vsText = '-' + $.Localize( "#WatchMenu_Tournament_Versus" ) + '-';
            elTournamentNameLabel.text = $.Localize( MatchInfoAPI.GetMatchTournamentStageName( elTile.matchId ) );

            var setDefaultTeamImage = function ( teamIcon )
            {
                teamIcon.SetImage( "file://{images}/tournaments/teams/nologo.svg" );
            }

            $.RegisterEventHandler( 'ImageFailedLoad', elTournamentTeam0Icon, setDefaultTeamImage.bind( undefined, elTournamentTeam0Icon ) );
            $.RegisterEventHandler( 'ImageFailedLoad', elTournamentTeam1Icon, setDefaultTeamImage.bind( undefined, elTournamentTeam1Icon ) );

            var icon0Filename = 'file://{images}/tournaments/teams/'+MatchInfoAPI.GetMatchTournamentTeamTag( elTile.matchId, team0 ).toLowerCase()+'.svg';
            var icon1Filename = 'file://{images}/tournaments/teams/'+MatchInfoAPI.GetMatchTournamentTeamTag( elTile.matchId, team1 ).toLowerCase()+'.svg';

            
            if ( elTournamentTeam0Icon ) elTournamentTeam0Icon.SetImage( icon0Filename );
            if (elTournamentTeam1Icon) elTournamentTeam1Icon.SetImage(icon1Filename);

        }

        if ( elScore0Label )
        {
            elScore0Label.text = MatchInfoAPI.GetMatchRoundScoreForTeam( elTile.matchId, team0 );
            if ( matchTileDescriptor != 'tournament' )
            {
                elScore0Label.AddClass( 'tint--' + TEAMS[ team0 ] );
            }
        }

        if ( elVsLabel )
        {
            elVsLabel.text = vsText;
        }

        if ( elScore1Label )
        {
            elScore1Label.text =  MatchInfoAPI.GetMatchRoundScoreForTeam( elTile.matchId, team1 );
            if ( matchTileDescriptor != 'tournament' )
            {
                elScore1Label.AddClass( 'tint--' + TEAMS[ team1 ] );
            }
        }

        if ( elViewersLabel )
        {
            var spectatorCount = parseInt( MatchInfoAPI.GetMatchSpectators( elTile.matchId ) );
            if ( !spectatorCount )
            {
                spectatorCount = 0;
            }
            elTile.SetDialogVariableInt( 'spectatorCount', spectatorCount );
            elViewersLabel.SetHasClass( 'hide', spectatorCount === 0 );
        }

        
        if ( bPlayerParticipated )
        {
            if ( elOutcomeLabel )
            {
                var outcomeCode = MatchInfoAPI.GetMatchOutcome( elTile.matchId );
                
                if ( outcomeCode == undefined )
                {
                    elOutcomeLabel.AddClass( 'MatchInfo--Hide' );
                }
                else
                {
                    if ( myTeam != 0 )
                    {
                        if ( outcomeCode == 1 ) 
                            outcomeCode = 2;
                        else if ( outcomeCode == 2 )
                            outcomeCode = 1;
                    }
                    switch ( outcomeCode )
                    {
                        case 0:
							elTile.AddClass( 'MatchTied' );
							elOutcomeLabel.text = $.Localize( "#WatchMenu_Outcome_Tied", elOutcomeLabel );
                            break;
						case 1:
							elTile.AddClass( 'MatchVictory' );
                            elOutcomeLabel.text = $.Localize( "#WatchMenu_Outcome_Won", elOutcomeLabel );
                            break;
						case 2:
							elTile.AddClass( 'MatchLoss' );
                            elOutcomeLabel.text = $.Localize( "#WatchMenu_Outcome_Lost", elOutcomeLabel );
                            break;
                        case 3:
                            elOutcomeLabel.text = $.Localize( "#WatchMenu_Outcome_Abandon" );
                            break;
                    }
                }
            }
        }

        if ( elTimestampLabel )
        {
            if (isLive)
                elTimestampLabel.text = $.Localize( "#CSGO_Watch_Cat_LiveMatches" );
            else
                elTimestampLabel.text = MatchInfoAPI.GetMatchTimestamp( elTile.matchId );
        }
        
        var setDefaultMapImage = function ( mapIcon )
        {
            mapIcon.SetImage( "file://{images}/map_icons/map_icon_NONE.png" );
        }

        if ( elMatchMapIcon )
        {
            $.RegisterEventHandler( 'ImageFailedLoad', elMatchMapIcon, setDefaultMapImage.bind( undefined, elMatchMapIcon ) );
            elMatchMapIcon.SetImage( "file://{images}/map_icons/map_icon_"+mapName+".svg" );
		}
		
        var setDefaultModeImage = function ( mapIcon )
        {
            mapIcon.SetImage( "file://{images}/icons/ui/competitive.vsvg" );
        }

        if ( elMatchModeIcon )
        {
            $.RegisterEventHandler( 'ImageFailedLoad', elMatchModeIcon, setDefaultModeImage.bind( undefined, elMatchModeIcon ) );
            elMatchModeIcon.SetImage( "file://{images}/icons/ui/" + rawModeName + ".svg" );
        }

		if ( elSkillGroupImg )
		{
			var skillgroup = MatchInfoAPI.GetMatchSkillGroup( elTile.matchId );
			if ( skillgroup )
				elSkillGroupImg.SetImage( "file://{images}/icons/skillgroups/skillgroup"+skillgroup+".svg" );
		}
    }

    function _Refresh( elTile )
    {
        _Init( elTile );
    }

                      
	return {
        Init			: _Init,
		SetParentActive : _SetParentActive,
        Refresh         : _Refresh,
        Delete          : _Delete
	};

})();

        
                             
                            
                     
                                      