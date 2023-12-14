'use strict';

var matchList = ( function ()
{

    var _m_myXuid = MyPersonaAPI.GetXuid();

    function _ShowListSpinner ( value, tab )
    {
        if ( tab )
        {
            var elSpinner = tab.FindChildInLayoutFile( "id-list-spinner" );
            _ShowInfoPanel( false, tab );
            _ShowListPanel( false, tab );
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

    function _SetListMessage ( value, show, tab = undefined )
    {
        if ( tab )
        {
            var elMessage = tab.FindChildInLayoutFile( "id-list-message" );
            if ( elMessage )
            {
                elMessage.text = value;
            }
            var elMessageContainer = tab.FindChildInLayoutFile( "id-list-message-container" );
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

    function _ShowInfoPanel ( value, tab = undefined )
    {
        if ( tab )
        {
            var elInfoPanel = tab.FindChildInLayoutFile( "Info" );
            var elMatchList = tab.FindChildInLayoutFile( "JsMatchList" );
            if ( elInfoPanel )
            {
                if ( value )
                {
                    elInfoPanel.AddClass( 'subsection-content__background-color--dark' );
                    if ( tab.activeMatchInfoPanel )
                    {
                        matchInfo.Refresh( tab.activeMatchInfoPanel );
                    }
                }
                else
                {
                    elInfoPanel.RemoveClass( 'subsection-content__background-color--dark' );
                    if ( tab.activeMatchInfoPanel )
                    {
                        matchInfo.Hide( tab.activeMatchInfoPanel );
                    }
                }
            }
            if ( elMatchList )
            {
                if ( value )
                {
                    elMatchList.AddClass( "MatchList--Filled" );
                }
                else
                {
                    elMatchList.RemoveClass( "MatchList--Filled" );
                }
            }
        }
    }

    function _ShowListPanel ( value, tab = undefined )
    {
        if ( tab )
        {
            var elMatchList = tab.FindChildInLayoutFile( "JsMatchList" );

            if ( elMatchList )
            {
                if ( !value )
                {
                    elMatchList.AddClass( 'hide' );
                }
                else
                {
                    elMatchList.RemoveClass( 'hide' );
                }
            }
        }
    }

    function _ClearList ( elListPanel, tournament_id )
    {
        var activeTiles = elListPanel.Children();
        for ( var i = activeTiles.length - 1; i >= 0; i-- )
        {
            if ( activeTiles[i].markForDelete )
            {
                if ( elListPanel.activeButton === activeTiles[i] )
                {
                    elListPanel.activeButton = undefined;
                }
                activeTiles[i].checked = false;
                if ( watchTile.downloadStateHandler )
                {
                    $.UnregisterForUnhandledEvent( 'PanoramaComponent_MatchInfo_StateChange', watchTile.downloadStateHandler );
                    watchTile.downloadStateHandler = undefined;
                }
                if ( tournament_id )
                {
                    activeTiles[i].AddClass( 'MatchTile--Collapse' );
                }
                else
                {
                    watchTile.Delete( activeTiles[i] );
                }
            }
        }
    }

    function _SelectFirstTile ( parentPanel, elMatchList, matchListDescriptor )
    {
        if ( elMatchList && !( elMatchList.activeButton ) && ( elMatchList.GetChildCount() > 0 ) )
        {
            var tileIsVisible = false;
            var elFirstTile = undefined;
            var n = 0;                                               
            do
            {
                var elFirstTile = elMatchList.GetChild( n );
                tileIsVisible = ( elFirstTile && !elFirstTile.BHasClass( 'MatchTile--Collapse' ) );
                n = n + 1;
            } while ( ( !tileIsVisible ) && ( elFirstTile != undefined ) );
            if ( elFirstTile )
            {
                elFirstTile.checked = true;
                elMatchList.activeButton = elFirstTile;
                elFirstTile.ScrollParentToMakePanelFit( 2, false );
                _PopulateMatchInfo( parentPanel, matchListDescriptor, elFirstTile.matchId );
            }
        }
    }

    function _ReselectActiveTile ( elListRoot )
    {
        var elMatchList = elListRoot.FindChildTraverse( "JsMatchList" );
        if ( elMatchList && elMatchList.activeButton )
        {
            elMatchList.activeButton.checked = true;
            _PopulateMatchInfo( elListRoot, elListRoot.matchListDescriptor, elMatchList.activeButton.matchId );
        }
        else
        {
            _SelectFirstTile( elListRoot, elMatchList, elListRoot.matchListDescriptor );
        }
    }

    var _OnTournamentTeamSelected = function ( elParentPanel, elMatchList, matchListDescriptor )
    {
        elParentPanel.matchListIsPopulated = false;
        _UpdateMatchList( elParentPanel, elParentPanel.tournament_id );
        elMatchList.activeButton = undefined;
        _SelectFirstTile( elParentPanel, elMatchList, matchListDescriptor );
    };

    var _OnTournamentSectionSelected = function ( elParentPanel, elMatchList, matchListDescriptor )
    {
                                                       
        _PopulateMatchTeamsDropdown( elParentPanel, elParentPanel.tournament_id );

        elParentPanel.matchListIsPopulated = false;
        _UpdateMatchList( elParentPanel, elParentPanel.tournament_id );
        elMatchList.activeButton = undefined;
        _SelectFirstTile( elParentPanel, elMatchList, matchListDescriptor );
    };

    function MakeDropDownEntry ( index, sectionDesc, sectionName, elMatchlistDropdown )
    {
        var elSection = $.CreatePanel( 'Label', elMatchlistDropdown, 'group_' + sectionDesc, { text: sectionName } );
        elSection.AddClass( "DropDownMenu" );
        elSection.AddClass( "Width-300" );
        elSection.AddClass( "White" );
        elSection.SetAttributeString( 'value', index );
        elSection.SetAttributeString( 'section_id', sectionDesc );
        elMatchlistDropdown.AddOption( elSection );
    }

    var _PopulateMatchlistDropdown = function ( elParentPanel, tournamentId )
    {
        var elMatchlistDropdown = elParentPanel.FindChildTraverse( "id-match-list-selector" );
        elMatchlistDropdown.ClearPanelEvent( 'oninputsubmit' );
        var nSections = PredictionsAPI.GetEventSectionsCount( tournamentId );
        elMatchlistDropdown.RemoveAllOptions();

        for ( var i = 0; i < nSections; i++ )
        {
            var sectionDesc = PredictionsAPI.GetEventSectionIDByIndex( tournamentId, i );
            var sectionName = PredictionsAPI.GetSectionName( tournamentId, sectionDesc );
            sectionName = $.Localize( "#CSGO_MatchInfo_Stage_" + sectionName.replace( /\s+/g, '' ) );
            MakeDropDownEntry( i, sectionDesc, sectionName, elMatchlistDropdown );
        }

        var sectionsCount = PredictionsAPI.GetEventSectionsCount( tournamentId );
        var activeIndex = sectionsCount - 1;
        for ( var i = 0; i < sectionsCount; i++ )
        {
            var sectionId = PredictionsAPI.GetEventSectionIDByIndex( tournamentId, i );
            if ( PredictionsAPI.GetSectionIsActive( tournamentId, sectionId ) )
            {
                activeIndex = i;
                break;
            }
        }

        elMatchlistDropdown.SetSelectedIndex( activeIndex );

        elMatchlistDropdown.RemoveClass( 'hide' );
        var elMatchList = elParentPanel.FindChildTraverse( "JsMatchList" );
        elMatchlistDropdown.SetPanelEvent( 'oninputsubmit', _OnTournamentSectionSelected.bind( undefined, elParentPanel, elMatchList, tournamentId ) );
    };

    var _PopulateMatchTeamsDropdown = function ( elParentPanel, tournamentId )
    {
        var elMatchistTeamDropdown = elParentPanel.FindChildTraverse( "id-match-list-selector-teams" );
        elMatchistTeamDropdown.ClearPanelEvent( 'oninputsubmit' );
        elMatchistTeamDropdown.RemoveAllOptions();

        var elStageDropdown = elParentPanel.FindChildTraverse( "id-match-list-selector" );
        var sectionId = elStageDropdown.GetSelected().GetAttributeString( 'section_id', 0 );

        var teamsList = [];
        var numGroups = PredictionsAPI.GetSectionGroupsCount( tournamentId, sectionId );

        MakeDropDownEntry( 0, 'allteams', '#Matchlist_Team_Selection', elMatchistTeamDropdown );
        teamsList.push( 'allteams' );

        for ( var j = 0; j < numGroups; j++ )
        {
            var numGroupId = PredictionsAPI.GetSectionGroupIDByIndex( tournamentId, sectionId, j );
            var count = PredictionsAPI.GetGroupTeamsPickableCount( tournamentId, numGroupId );

            for ( var h = 0; h < count; h++ )
            {
                var teamId = PredictionsAPI.GetGroupTeamIDByIndex( tournamentId, numGroupId, h );

                if ( teamsList.indexOf( teamId ) === -1 && teamId )
                {
                    teamsList.push( teamId );
                    var teamName = PredictionsAPI.GetTeamName( teamId );
                    MakeDropDownEntry( ( teamsList.length - 1 ), teamId, teamName, elMatchistTeamDropdown );
                }
            }
        }

        elMatchistTeamDropdown.SetSelectedIndex( teamsList.indexOf( 'allteams' ) );

        elMatchistTeamDropdown.RemoveClass( 'hide' );
        elMatchistTeamDropdown.enabled = ( teamsList.length > 1 );
        var elMatchList = elParentPanel.FindChildTraverse( "JsMatchList" );
        elMatchistTeamDropdown.SetPanelEvent( 'oninputsubmit', _OnTournamentTeamSelected.bind( undefined, elParentPanel, elMatchList, tournamentId ) );
    };

    function _UpdateMatchList ( elTab, matchListDescriptor, optbFromMatchListChangeEvent )
    {
        var listState = MatchListAPI.GetState( matchListDescriptor );

        if ( listState === 'none' )
        {
            listState = _RequestMatchListUpdate( elTab, matchListDescriptor );
        }
        else if ( listState === 'ready' && !optbFromMatchListChangeEvent )
        {
                                                                                                            
            listState = _RequestMatchListUpdate( elTab, matchListDescriptor );
                                                                                                            
                                                
                                                                                                         
                                                
        }

        if ( elTab && ( listState !== "loading" ) )
        {
            _PopulateMatchList( elTab, matchListDescriptor );
        }
    }

    function _PopulateMatchInfo ( parentPanel, matchListDescriptor, matchId )
    {
        var elMatchList = parentPanel.FindChildTraverse( "JsMatchList" );
        var elButton = parentPanel.FindChildTraverse( matchListDescriptor + "_" + matchId );

        if ( elMatchList.activeButton )
        {
            watchTile.SetParentActive( elMatchList.activeButton, false );
        }
        if ( elButton )
        {
            elMatchList.activeButton = elButton;
        }

        if ( ( parentPanel.activeMatchInfoPanel ) && ( parentPanel.activeMatchInfoPanel.matchId === matchId ) && ( matchId != 'gotv' ) )
        {
            matchInfo.Refresh( parentPanel.activeMatchInfoPanel );
            return;
        }

        if ( ( parentPanel.activeMatchInfoPanel ) && ( parentPanel.activeMatchInfoPanel.matchId != matchId ) )
        {
            matchInfo.Hide( parentPanel.activeMatchInfoPanel );
            parentPanel.activeMatchInfoPanel = undefined;
        }

        var parentInfoPanel = parentPanel.FindChildTraverse( 'Info' );
        parentPanel.activeMatchInfoPanel = parentInfoPanel.FindChild( 'info_' + matchId );
        if ( parentPanel.activeMatchInfoPanel == undefined )
        {
            parentPanel.activeMatchInfoPanel = $.CreatePanel( 'Panel', parentInfoPanel, 'info_' + matchId );
            parentPanel.activeMatchInfoPanel.matchId = matchId;
            parentPanel.activeMatchInfoPanel.matchListDescriptor = matchListDescriptor;
            parentPanel.activeMatchInfoPanel.BLoadLayout( "file://{resources}/layout/matchinfo.xml", false, false );
            parentPanel.activeMatchInfoPanel.tournament_id = parentPanel.tournament_id;
            parentPanel.activeMatchInfoPanel.tournamentIndex = parentPanel.tournamentIndex;

            matchInfo.Init( parentPanel.activeMatchInfoPanel );
        }
        else
        {
            matchInfo.Refresh( parentPanel.activeMatchInfoPanel );
        }
    }

    function _RequestMatchListUpdate ( elTab, matchListDescriptor )
    {
        function _ShowLoadingError ( elBoundTab )
        {
            _ShowListSpinner( false, elBoundTab );
            var msg = "";
            if ( elBoundTab.tournament_id )
            {
                msg = "#CSGO_Watch_NoMatch_Tournament_" + elBoundTab.tournament_id.split( ':' )[1];
            }
            else
            {
                switch ( elTab.id )
                {
                    case "JsLive":
                        msg = "#CSGO_Watch_NoMatch_live";
                        break;
                    case "JsYourMatches":
                        msg = "#CSGO_Watch_NoMatch_your_ranked";
                        break;
                }
            }
            _SetListMessage( $.Localize( msg ), true, elBoundTab );
            elBoundTab.downloadFailedHandler = undefined;
        }

        if ( elTab )
        {
            MatchListAPI.Refresh( matchListDescriptor );

            var newState = MatchListAPI.GetState( matchListDescriptor );
            if ( newState === "loading" )
            {
                  
                                               
                                                                                                       
                                                                                                              
                                                 
                                                                                                                  
                _ShowListSpinner( true, elTab );
                _SetListMessage( "", false, elTab );
                elTab.matchListIsPopulated = false;

                                                                                 
                if ( elTab.downloadFailedHandler )
                {
                    $.CancelScheduled( elTab.downloadFailedHandler );
                    elTab.downloadFailedHandler = undefined;
                }
                elTab.downloadFailedHandler = $.Schedule( 3.0, _ShowLoadingError.bind( undefined, elTab ) );
            }
            return newState;
        }
    }

    function _MarkActiveTabUnpopulated ()
    {
        _m_activeTab.matchListIsPopulated = false;
    }

    function _PopulateMatchList( parentPanel, matchListDescriptor )
    {
        if ( !parentPanel ) return;

        function OnMouseOverButton ( currentParentPanel, buttonId )
        {
            var elButton = currentParentPanel.FindChildTraverse( buttonId );
            watchTile.SetParentActive( elButton, true );
        }

        function OnMouseOutButton ( currentParentPanel, buttonId )
        {
            var elButton = currentParentPanel.FindChildTraverse( buttonId );
            if ( !elButton.IsSelected() )
            {
                watchTile.SetParentActive( elButton, false );
            }
        }

        function _ClearMatchInfo ()
        {
            if ( parentPanel.activeMatchInfoPanel )
            {
                matchInfo.Hide( parentPanel.activeMatchInfoPanel );
                parentPanel.activeMatchInfoPanel = undefined;
            }
        }

        function _ShowGOTVConfirmPopup ( elListRoot )
        {
            _ClearMatchInfo();
            UiToolkitAPI.ShowGenericPopupOkCancel( $.Localize( '#CSGO_Watch_Gotv_Theater' ), $.Localize( '#CSGO_Watch_Gotv_Theater_tip' ), '', function () { MatchListAPI.StartGOTVTheater( "live" ); }, _ReselectActiveTile.bind( undefined, elListRoot ) );
        }

        if ( parentPanel.downloadFailedHandler )
        {
            $.CancelScheduled( parentPanel.downloadFailedHandler );
            parentPanel.downloadFailedHandler = undefined;
        }

        function GetListOfMatchIds ( matchListDescriptor, tournamentIndex, unfilteredCount, sectionDesc, teamId = undefined )
        {
            var MatchIds = [];

            for ( var i = 0; i < unfilteredCount; i++ )
            {
                var matchId = '';
                if ( tournamentIndex > 3 )
                {
                    matchId = PredictionsAPI.GetSectionMatchByIndex( matchListDescriptor, sectionDesc, i );
                }
                else if ( tournamentIndex <= 3 || !tournamentIndex )
                {
                                                                                      
                    matchId = MatchListAPI.GetMatchByIndex( matchListDescriptor, i );
                }

                if ( tournamentIndex && teamId && teamId != 0 )
                {
                    if ( IsTeamInMatch( teamId, matchId ) )
                    {
                        MatchIds.push( matchId );
                    }
                }
                else
                {
                    MatchIds.push( matchId );
                }
            }

            return MatchIds;
        }

        function IsTeamInMatch ( teamId, matchId )
        {
            for ( i = 0; i <= 1; i++ )
            {
                if ( MatchInfoAPI.GetMatchTournamentTeamID( matchId, i ) === teamId )
                {
                    return true;
                }
            }
            return false;
        }

        var unfilteredCount = MatchListAPI.GetCount( matchListDescriptor );
        var nCount = 0;
                                                                                                      
        var sectionDesc = 0;
        var tournamentIndex = 0;
        var MatchIdsFiltered = [];

        if ( ( unfilteredCount > 0 ) && ( parentPanel.tournament_id ) )
        {
            tournamentIndex = parentPanel.tournament_id.split( ':' )[1];
            parentPanel.tournamentIndex = tournamentIndex;
            if ( !parentPanel.matchListDropdownIsPopulated )
            {
                if ( tournamentIndex > 3 )
                {
                    _PopulateMatchlistDropdown( parentPanel, parentPanel.tournament_id );
                    _PopulateMatchTeamsDropdown( parentPanel, parentPanel.tournament_id );
                }
                parentPanel.matchListDropdownIsPopulated = true;
            }

            if ( tournamentIndex > 3 )
            {
                var elDropdown = parentPanel.FindChildTraverse( "id-match-list-selector" );
                sectionDesc = elDropdown.GetSelected().GetAttributeString( 'section_id', 0 );
                unfilteredCount = PredictionsAPI.GetSectionMatchesCount( parentPanel.tournament_id, sectionDesc );

                var elStageDropdown = parentPanel.FindChildTraverse( "id-match-list-selector-teams" );
                var strTeamId = elStageDropdown.GetSelected().GetAttributeString( 'section_id', 0 );
                var nteamId = strTeamId === 'allteams' ? 0 : Number( strTeamId );

                MatchIdsFiltered = GetListOfMatchIds( parentPanel.tournament_id, tournamentIndex, unfilteredCount, sectionDesc, nteamId );
                nCount = MatchIdsFiltered.length;
            }
            else if ( tournamentIndex == 1 )
            {
                MatchIdsFiltered = GetListOfMatchIds( parentPanel.tournament_id, tournamentIndex, unfilteredCount, sectionDesc, undefined );
                nCount = MatchIdsFiltered.length - 3;                                       
            }
            else if ( tournamentIndex == 3 )
            {
                MatchIdsFiltered = GetListOfMatchIds( parentPanel.tournament_id, tournamentIndex, unfilteredCount, sectionDesc, undefined );
                nCount = MatchIdsFiltered.length - 1;                   
            }
        }
        else
        {
            MatchIdsFiltered = GetListOfMatchIds( matchListDescriptor, null, unfilteredCount, '', undefined );
            nCount = unfilteredCount;
        }

        _ShowListSpinner( false, parentPanel );
                                                     
        if ( nCount <= 0 )
        {
            _ShowInfoPanel( false, parentPanel );
            _ShowListPanel( false, parentPanel );
            var msg = "";
            if ( parentPanel.tournament_id )
            {
                msg = "#CSGO_Watch_NoMatch_Tournament_" + parentPanel.tournament_id.split( ':' )[1];
            }
            else 
            {
                switch ( parentPanel.id )
                {
                    case "JsLive":
                        msg = "#CSGO_Watch_NoMatch_live";
                        break;
                    case "JsYourMatches":
                        msg = "#CSGO_Watch_NoMatch_your_ranked";
                        break;
                    case "JsDownloaded":
                        msg = "#CSGO_Watch_NoMatch_downloaded";
                        break;
                }
            }
            _SetListMessage( $.Localize( msg ), true, parentPanel );
        }

        var displayedMatches = new Array();
        var elMatchList = parentPanel.FindChildTraverse( "JsMatchList" );
        if ( !elMatchList )
        {
            return;
        }

        for ( var i = 0; i < elMatchList.GetChildCount(); i++ )
        {
            elMatchList.GetChild( i ).markForDelete = true;
        }

        function _CreateOrValidateMatchTile ( matchId )
        {
            var elMatchButton = elMatchList.FindChildInLayoutFile( matchListDescriptor + "_" + matchId );
            if ( !elMatchButton || matchListDescriptor === 'live' )
            {
                                                                                         
                if ( matchListDescriptor === 'live' )
                {
                    if ( elMatchButton )
                    {
                        elMatchButton.DeleteAsync( 0.0 );
                    }
                }

                elMatchButton = $.CreatePanel( 'RadioButton', elMatchList, matchListDescriptor + "_" + matchId );
                elMatchButton.downloadStateHandler = undefined;
                elMatchButton.group = parentPanel.id;
                elMatchButton.myXuid = _m_myXuid;
                elMatchButton.matchId = matchId;
                elMatchButton.matchListDescriptor = matchListDescriptor;
                if ( matchId != 'gotv' )
                {
                    elMatchButton.SetPanelEvent( 'onactivate', _PopulateMatchInfo.bind( undefined, parentPanel, matchListDescriptor, matchId ) );
                }
                else
                {
                    elMatchButton.SetPanelEvent( 'onactivate', _ShowGOTVConfirmPopup.bind( undefined, parentPanel ) );
                }
                elMatchButton.SetPanelEvent( 'onmouseover', OnMouseOverButton.bind( undefined, parentPanel, matchListDescriptor + "_" + matchId ) );
                elMatchButton.SetPanelEvent( 'onmouseout', OnMouseOutButton.bind( undefined, parentPanel, matchListDescriptor + "_" + matchId ) );
                watchTile.Init( elMatchButton );
                elMatchButton.RemoveClass( 'MatchTile--Collapse' );
            }
            else
            {
                watchTile.Refresh( elMatchButton );
            }
            elMatchButton.markForDelete = false;

            function _UpdateDownloadState ( elBoundMatchButton )
            {
                if ( ( elBoundMatchButton ) && ( !elBoundMatchButton.markForDelete ) )
                {
                    var elDownloadIndicator = elBoundMatchButton.FindChildInLayoutFile( 'id-download-state' );
                    if ( elDownloadIndicator )
                    {
                        var isDownloading = Boolean( ( MatchInfoAPI.GetMatchState( elBoundMatchButton.matchId ) === "downloading" ) );
                        var canWatch = Boolean( MatchInfoAPI.CanWatch( elBoundMatchButton.matchId ) );
                        var isLive = Boolean( MatchInfoAPI.IsLive( elBoundMatchButton.matchId ) );
                        elDownloadIndicator.SetHasClass( "download-animation", isDownloading );
                        elDownloadIndicator.SetHasClass( "watchlive", isLive );
                        elDownloadIndicator.SetHasClass( "downloaded", canWatch && !isLive );
                    }
                }
            }

            if ( ( elMatchButton.downloadStateHandler == undefined ) && elMatchButton.FindChildInLayoutFile( 'id-download-state' ) )
            {
                elMatchButton.downloadStateHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_MatchInfo_StateChange', _UpdateDownloadState.bind( undefined, elMatchButton ) );
            }

                                                                                                                                                
            _UpdateDownloadState( elMatchButton );


            elMatchButton.RemoveClass( 'MatchTile--Collapse' );
        }

        for ( i = 0; i < nCount; i++ )
        {
            if ( ( parentPanel.tournament_id ) && ( tournamentIndex > 3 ) )
            {
                _CreateOrValidateMatchTile( MatchIdsFiltered[i] );
            }
            else
            {
                var matchbyindex = MatchListAPI.GetMatchByIndex( matchListDescriptor, i );
                                                                                                   
                _CreateOrValidateMatchTile( MatchIdsFiltered[i] );
            }
        }


        if ( ( matchListDescriptor === 'live' ) && elMatchList.FindChildInLayoutFile( "live_gotv" ) )
        {
            elMatchList.FindChildInLayoutFile( "live_gotv" ).markForDelete = true;
        }
        _ClearList( elMatchList, parentPanel.tournament_id );
        _SelectFirstTile( parentPanel, elMatchList, matchListDescriptor );

        if ( nCount > 0 )
        {
            _ShowListPanel( true, parentPanel );
            _ShowInfoPanel( true, parentPanel );
            _SetListMessage( "", false, parentPanel );
        }

                                                       
        if ( ( matchListDescriptor === 'live' ) && ( nCount > 0 ) )
        {
            _CreateOrValidateMatchTile( 'gotv' );
        }


        parentPanel.matchListIsPopulated = true;
    }

                          
    return {
        UpdateMatchList: _UpdateMatchList,
        ShowListSpinner: _ShowListSpinner,
        SetListMessage: _SetListMessage,
        ShowInfoPanel: _ShowInfoPanel,
        ReselectActiveTile: _ReselectActiveTile
    };

} )();

( function ()
{

} )();