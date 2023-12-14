'use strict';

( function ()
{
    var _m_cP = $.GetContextPanel();
    var _m_pauseMenu = false;
    var _m_animateStats = true;

    var _m_currentlyUpdating = false;
    var _m_updatePending = false;
    var _m_endOfMatchActive = false;
    var _m_bPerfectWorld = ( MyPersonaAPI.GetLauncherType() === "perfectworld" );

              
                               
              

              
                    
                
                                                                                                                      
                                                                                       
                                                                                       
                                                                                                                      
                                                                                       
                                                                                       
                                                                                       
                                                                                      
                                                                                                    
                                                                                      
                                                                                      
                                                                                     
                                                                                                                    
                                                                                                   
                                                                                                   
                                                                                                   
          
                      
                        
                                            
                                       
                         
                                                  
                    
                                                                                                          
                                                                                                             
                                                                                                                 
                                                                                                               
                                                                                                                
              
          
      

                        
                
             
                            
                          
                                                                                               
                                                                                              
                 
              
             
                            
                          
                                                                                             
                 
              
             
                            
                          
                                                                
                                                                                               
                 
              
             
                            
                          
                                                                                                
                                                               
                 
              
             
                            
                          
                                                                                             
                                                                
                                                               
                 
              
             
                            
                          
                                                               
                                                              
                 
              
             
                            
                          
                                                                                               
                                                              
                 
              
             
                            
                          
                                                               
                                                              
                 
              
             
                             
                          
                                                                                               
                                                                                              
                 
              
             
                             
                          
                                                                                             
                 
              
             
                             
                          
                                                                
                                                                                               
                 
              
             
                             
                          
                                                                                                
                                                               
                 
              
             
                             
                          
                                                                                             
                                                                
                                                               
                 
              
             
                             
                          
                                                               
                                                              
                 
              
             
                            
                          
                                                                                               
                                                              
                 
              
             
                             
                          
                                                               
                                                              
                 
             
          
                      
                        
                                            
                                       
                         
                                                  
                    
                                                                                                          
                                                                                                             
                                                                                                                 
                                                                                                               
                                                                                                                
              
          
      
              

    var _GetInfo = function()
    {
                  
                            
                            
                  

        return _m_cP.GetInfo();
    }

    var _UpdateButtonStates = function()
    {
                  
                            
                   
                  

        _m_cP.UpdateButtonStates();
    }


    var _Initialize = function()
    {
        if ( _m_cP.GetAttributeString( 'pausemenu', 'false' ) === 'true' )
            _m_pauseMenu = true;

                  
                                                                            
                                  
                  

        if ( _m_pauseMenu )
        {
            _m_animateStats = false;
            $.RegisterForUnhandledEvent( "EndOfMatch_Show", _IsEndOfMatchActive.bind( undefined, true ) );
            $.RegisterForUnhandledEvent( "EndOfMatch_Shutdown", _IsEndOfMatchActive.bind( undefined, false ) );
            
            _UpdateFromPauseMenu();
        }
        else
        {
                                                                               
            _m_currentlyUpdating = true;
            _m_updatePending = true;
            $.Schedule( 3.0, _FinishUpdating );                                    
        }

        $.RegisterForUnhandledEvent( 'CSGOSurvivalStatsUpdated', _UpdateAllPlayers );
    };

    var _IsEndOfMatchActive = function( endOfMatchActive )
    {
        _m_endOfMatchActive = endOfMatchActive;

        if ( _m_pauseMenu )
        {
            _UpdateAllPlayers();
        }
    };

    var _ShowHide = function( bShow )
    {
        if ( !_m_endOfMatchActive )
        {
            _m_cP.visible = bShow;
        }
        else
        {
            _m_cP.visible = false;
        }
    };

    var _UpdateFromPauseMenu = function()
    {
        if ( !_m_cP.IsValid() )
            return;

        var mode = GameStateAPI.GetGameModeInternalName( false );
    
        if ( mode !== "survival" )
        {
            return;
        }

        _UpdateAllPlayers();
    };

    var _FinishUpdating = function ()
    {
                                                                    
        if ( !_m_currentlyUpdating )
            return;

                        
        _m_currentlyUpdating = false;

        if ( !_m_cP.IsValid() )
            return;

                                                 
        _UpdateButtonStates();

                                                                                      
        if ( _m_updatePending )
        {
            _m_updatePending = false;
            _UpdateAllPlayers();
        }
    }

    var _UpdateAllPlayers = function ()
    {
                                                                             
        if ( !_m_cP.IsValid() )
            return;

                                                     
        if ( _m_currentlyUpdating )
        {
            _m_updatePending = true;
            return;
        }

        var oInfo = _GetInfo();

        if ( !oInfo )
            return;

                                                 
                                                                  
                                                                                         
        _m_currentlyUpdating = true;
        _ShowHide( _DoesInfoObjectHaveAnyData( oInfo ));

                            
        if ( _m_cP.GetAttributeString( 'debugdata', 'false' ) === 'true' )
        {
            var strInfos = JSON.stringify( oInfo, undefined, 4 ).split( '\n' );
            strInfos.forEach( function ( s ) {             } );
        }

        var oLocalPlayer = oInfo.localPlayer;
        var oLocalPlayerXuid = undefined;
        if ( oLocalPlayer )
        {
            oLocalPlayerXuid = oLocalPlayer.xuid;
        }

        var elList = _m_cP.FindChildInLayoutFile( 'id-eom-survival-players' );
        elList.RemoveAndDeleteChildren();
        for ( var i = 0; i < oInfo.teams.length; i++ )
        {
            var playersCount = oInfo.teams[ i ].players.length;
                                         
                                                                        
                                
                
                                           
                                                                                                     
                                                                                 
                    
                                                                                           
                    
                
                   
                
                       
            var elTeam = _CreateTeamAvatarPanel( elList, oInfo.teams[ i ] );

            if ( i > 0  )
            {
                elTeam.AddClass( 'survival-team--border' );
            }

            if ( elTeam )
            {
                var teamHasLocalPlayer = false;

                for ( var j = 0; j < playersCount; j++ )
                {
                                                                                        
                                                                                                                  
                    var position = j === ( playersCount - 1 ) ? oInfo.teams[ i ].position : null;
                    _UpdatePlayer( elTeam, oInfo.teams[ i ].players[ j ], position );

                    if ( !teamHasLocalPlayer )
                    {
                        teamHasLocalPlayer = oLocalPlayerXuid === oInfo.teams[ i ].players[ j ].xuid ? true : false;
                    }

                                                                                
                    if ( teamHasLocalPlayer && ( position || position  === 0 ))
                    {
                        _HighlightLocalPLayer( elTeam, oInfo.teams[ i ].players[ j ].xuid );
                    }
                }
            }
               
        }

        _UpdateStats( oLocalPlayer, oInfo );
        _FinishUpdating();
    };

    function _UpdateStats( oLocalPlayer, oInfo )
    {
        _RemoveOldStats();
        _ShowHidePlaySpectateBar( oLocalPlayer );
    
        if ( oLocalPlayer )
        {
            if ( oLocalPlayer.position_loc.slice( 0, 1 ) === '#' )
                _m_cP.FindChildInLayoutFile( 'id-stat-position' ).SetLocString( oLocalPlayer.position_loc );
            else
                _m_cP.FindChildInLayoutFile( 'id-stat-position' ).text = oLocalPlayer.position_loc;
            
            var elContentspanel = _m_cP.FindChildInLayoutFile( 'id-eom-survival-contents' );
            _TintPositionHexToTeam( elContentspanel, oLocalPlayer.position );

            _m_cP.FindChildInLayoutFile( 'id-stat-title' ).SetLocString( oLocalPlayer.alive_loc );

            var elStats = _m_cP.FindChildInLayoutFile( 'id-eom-survival-stats-container' );
            for ( var i = 0; i < oLocalPlayer.stats.length; i++ )
            {
                _AddStatsRow( elStats, oLocalPlayer.stats[ i ] );
            }

            _MakeDamageReports( oInfo.teams );

            if ( !_m_cP.FindChildInLayoutFile( 'id-eom-survival-contents' ).BHasClass( 'show' ) )
            {
                _m_cP.FindChildInLayoutFile( 'id-eom-survival-contents' ).AddClass( 'show' );
            }
                                                 
            _m_animateStats = false;
        }
        else
        {
                                                   
            _m_cP.FindChildInLayoutFile( 'id-eom-survival-damage-container' ).RemoveClass( 'show' );
        }
    }

    function _RemoveOldStats()
    {
        var elStats = _m_cP.FindChildInLayoutFile( 'id-eom-survival-stats-container' );
        elStats.RemoveAndDeleteChildren();

        var elDamageReports = _m_cP.FindChildInLayoutFile( 'id-eom-survival-damage-container' );
        elDamageReports.RemoveAndDeleteChildren();
    }

    function _ShowHidePlaySpectateBar ( oLocalPlayer )
    {
                                                                                
        var bShow = ( oLocalPlayer && oLocalPlayer.stats.length > 0 ) ? true : false;
        _m_cP.FindChildInLayoutFile( 'id-eom-survival-buttons-row' ).visible = bShow;
    }

    function _CreateTeamAvatarPanel( elList, oTeam )
    {
                                                          
        for( var iPlayer = 0; iPlayer < oTeam.players.length; ++iPlayer )
        {
            if ( elList.FindChildInLayoutFile( oTeam.players[iPlayer].xuid ) )
                return null;
        }

        var elTeamPanel = $.CreatePanel( 'Panel', elList, '' );
        elTeamPanel.BLoadLayoutSnippet( 'survival-team' );

        return elTeamPanel.FindChildInLayoutFile( 'JsSurvivalTeamPlayers' );
    }

    function _UpdatePlayer ( elList, oPlayer, position = null ) 
    {
        var elPlayerPanel = elList.FindChildInLayoutFile( oPlayer.xuid );

                                                                                                

        if ( !elPlayerPanel )
        {
            elPlayerPanel = $.CreatePanel( 'Panel', elList, oPlayer.xuid );
			elPlayerPanel.BLoadLayoutSnippet( 'survival-player' );

			              
			var elImage = elPlayerPanel.FindChildInLayoutFile( "JsSurvivalSkillGroup" );
			if ( oPlayer.skillgroup )
			{
				elImage.AddClass( 'has-rank-icon' );
				elImage.SetImage( 'file://{images}/icons/skillgroups/dangerzone'+oPlayer.skillgroup+'.svg' );
			}
			else
			{
				elImage.AddClass( 'no-rank-icon' );
			}

            _InitAvatar( elPlayerPanel.FindChildInLayoutFile( 'JsSurvivalAvatar' ), oPlayer.xuid );
            _AddDeadStateToPlayer( elPlayerPanel, oPlayer );

            if ( position || position === 0 )
            {
                _CreatePositionPanelForPlayer( elPlayerPanel, position );
            }
        }
    }

    function _InitAvatar( elAvatar, xuid )
    {
        elAvatar.BLoadLayoutSnippet( 'AvatarPlayerCard' );
        elAvatar.SetAttributeString( 'xuid', xuid );
        Avatar.Init( elAvatar, xuid, 'playercard' );
        _AddOpenPlayerCardAction( elAvatar, xuid );
        _MouseOverEvents( elAvatar, xuid, xuid );
    }

    function _AddDeadStateToPlayer( elPlayerPanel, oPlayer )
    {
        if ( !oPlayer.alive )
        {
            var iconPath = 'file://{images}/icons/ui/elimination.svg';

            if ( _m_bPerfectWorld )
            {
                iconPath = 'file://{images}/icons/ui/map_death.svg';
            }

            elPlayerPanel.FindChildInLayoutFile( 'JsSurvivalDeadIcon' ).SetImage( iconPath );
            elPlayerPanel.AddClass( 'eom-player-dead' );
            
        }
    }

    function _CreatePositionPanelForPlayer( elPlayer, position )
    {
        var elParent = elPlayer.FindChildInLayoutFile( 'survival-player-avatar' );
        
        var elPlacement = $.CreatePanel( 'Panel', elParent, '' );
        elPlacement.BLoadLayoutSnippet( 'survival-placement' );

        if ( !position )
        {
            elPlayer.FindChildInLayoutFile( 'JsSurvivalPlacement' ).text = '?'; 
        }
        else
        {
            elPlayer.FindChildInLayoutFile( 'JsSurvivalPlacement' ).text = $.Localize( '#EOM_Position_' + position );
        }

        _TintPositionHexToTeam( elPlayer, position );
    }

    function _TintPositionHexToTeam( elParentPanel, position )
    {
        if ( position > 0 )
        {
            if ( position === 1 )
            {
                elParentPanel.AddClass( 'eom-survival-placement-1' );
            }
            else if ( position === 2 )
            {
                elParentPanel.AddClass( 'eom-survival-placement-2' );
            }
            else if ( position ==3 )
            {
                elParentPanel.AddClass( 'eom-survival-placement-3' );
            }
            else if ( position >3 )
            {
                elParentPanel.AddClass( 'eom-survival-placement-red' );
            }
        }
        else
        {
            elParentPanel.AddClass( 'eom-survival-placement-grey' );
        }
    }

    function _HighlightLocalPLayer ( elList, xuid )
    {
        if ( !_m_cP.IsValid() )
            return;

        var elAvatar = elList.FindChildInLayoutFile( xuid );

        if ( elAvatar )
        {
            elAvatar.AddClass( 'eom-player-local' );
        }
    }

    function _MouseOverEvents ( elAvatar, id, xuid )
    {
		elAvatar.SetPanelEvent( "onmouseover", function()
		{
			UiToolkitAPI.ShowTextTooltip( id, FriendsListAPI.GetFriendName( xuid ) );
        } );
        
        elAvatar.SetPanelEvent( "onmouseout", function()
        {
            UiToolkitAPI.HideTextTooltip();
        } );
    }

    function _AddOpenPlayerCardAction( elAvatar, xuid ) {
        var openCard = function ( xuid ) {
                                                                                                         
            $.DispatchEvent( 'SidebarContextMenuActive', true );

            if ( xuid !== 0 )
            {
                var contextMenuPanel = UiToolkitAPI.ShowCustomLayoutContextMenuParametersDismissEvent(
                    '',
                    '',
                    'file://{resources}/layout/context_menus/context_menu_playercard.xml',
                    'xuid=' + xuid,
                    function () {
                        $.DispatchEvent( 'SidebarContextMenuActive', false );
                    }
                );
                contextMenuPanel.AddClass( "ContextMenu_NoArrow" );
            }
        };

        elAvatar.SetPanelEvent( "onactivate", openCard.bind( undefined, xuid ) );
        elAvatar.SetPanelEvent( "oncontextmenu", openCard.bind( undefined, xuid ) );
    }

    function _AddStatsRow ( elStats, oStat ) 
    {
        var elPanel = $.CreatePanel( 'Panel', elStats, oStat.name );
        elPanel.BLoadLayoutSnippet( 'survivial-stats-row' );

        elPanel.FindChildInLayoutFile( 'id-stat-name' ).SetLocString( oStat.name );
		elPanel.FindChildInLayoutFile( 'id-stat-value' ).SetDialogVariableInt( 'value', oStat.value );
		elPanel.FindChildInLayoutFile( 'id-stat-value' ).SetDialogVariableTime( 'value', oStat.value );
        elPanel.FindChildInLayoutFile( 'id-stat-value' ).SetLocString( oStat.value_loc );
    }

    function _MakeDamageReports ( ateams )
    {
        var aPlayers = [];
        for ( var i = 0; i < ateams.length; i++ )
        {
            var playersCount = ateams[ i ].players.length;
            for ( var j = 0; j < playersCount; j++ )
            {
                if ( ateams[ i ].players[ j ].damage_to || ateams[ i ].players[ j ].damage_from )
                {
                    aPlayers.push( ateams[ i ].players[ j ] )
                }
            }
        }

        if ( aPlayers.length < 1 )
        {
            _m_cP.FindChildInLayoutFile( 'id-eom-survival-damage-container' ).RemoveClass( 'show' );
            return;
        }

        _m_cP.FindChildInLayoutFile( 'id-eom-survival-damage-container' ).AddClass( 'show' );

        aPlayers.sort(function (a, b) {
            return b.damage_from - a.damage_from;
        } );
        
        aPlayers.forEach( element => {
            _AddDamagReport( element );
        });
    }

    function _AddDamagReport ( oPlayer )
    {
                                                                                      
        var elParent = _m_cP.FindChildInLayoutFile( 'id-eom-survival-damage-container' );

        var elPanel = $.CreatePanel( 'Panel', elParent, 'damage-'+ oPlayer.xuid );
        elPanel.BLoadLayoutSnippet( 'survival-damage-to-from' );

        if ( oPlayer.damage_to )
        {
            elPanel.FindChildInLayoutFile( 'JsSurvivalDamageGiven' ).AddClass( 'show' );
            elPanel.FindChildInLayoutFile( 'JsSurvivalDamageGivenValue' ).text = oPlayer.damage_to;
        }
        
        if ( oPlayer.damage_from )
        {
            elPanel.FindChildInLayoutFile( 'JsSurvivalDamageTaken' ).AddClass( 'show' );
            elPanel.FindChildInLayoutFile( 'JsSurvivalDamageTakenValue' ).text = oPlayer.damage_from;
        }

        var elAvatar = $.CreatePanel( 
            'CSGOAvatarImage',
            elPanel,
            'damage-id-' + oPlayer.xuid,
            {
                class: 'eom-survival__avatar',
                defaultsrc: 'file://{images}/icons/ui/player.svg'
            }
        );

        elPanel.MoveChildBefore( elAvatar, elPanel.FindChildInLayoutFile( 'JsSurvivalDamageList' ));

        elAvatar.PopulateFromSteamID(oPlayer.xuid);
        _AddOpenPlayerCardAction( elAvatar, oPlayer.xuid );
        _MouseOverEvents( elAvatar, elAvatar.id, oPlayer.xuid );
    }

    var _Requeue_Clicked = function()
    {
        EndOfMatch_Survival_Requeue_Clicked();
        $.DispatchEvent( 'UIPopupButtonClicked', '' )

        var elRequeueBtn = _m_cP.FindChildInLayoutFile( 'eom-survival_queue' );
        elRequeueBtn.AddClass( 'hidden' );

        var elRequeueStatus = _m_cP.FindChildInLayoutFile( 'eom-survival_status' );
        {
            elRequeueStatus.RemoveClass( 'hidden' );
        }
    };

    var _DoesInfoObjectHaveAnyData = function( oInfo )
    {
        return oInfo.teams.length > 0 ? true : false;
    };

    _m_cP.matchStatus = {
        UpdateAllPlayers: _UpdateAllPlayers,
        UpdateFromPauseMenu: _UpdateFromPauseMenu,
        Requeue_Clicked: _Requeue_Clicked
    };

                                                     
                                                                                       
                                                                                         
                                                       
    $.Schedule( 0, _Initialize );
})();
