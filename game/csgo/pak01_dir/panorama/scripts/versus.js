'use strict';

var Versus = ( function()
{
	var _m_mockData;

	var _m_totalTime;

	var _m_bInitialized = false;

	var _m_cP;

	var _m_elMyTeam;
	var _m_elPreviewPanel_MyTeam;
	var _m_elPreviewPanel_EnemyTeam;
	var _m_elWipe;
	var _m_elContentRoot;
	var _m_elMovie;

	var _m_sTeamName;		                                  
	var _m_oPlayersData;	                                            
	var _m_oScene;			                                                    

	function _Init ( mockdata )
	{
		if ( _m_bInitialized )
			return false;
		
		_m_totalTime = Number( GameInterfaceAPI.GetSettingString( "sv_warmup_to_freezetime_delay" ) ) + 0.5;

		if ( $.GetContextPanel().id == "LayoutPanel_CSGOVersus" && mockdata )
		{
			_m_cP = $( "#LayoutPanel_CSGOVersus" );
			_m_mockData = mockdata;
			MockAdapter.SetMockData( _m_mockData );

			_m_bInitialized = true;

		}
		else if ( $.GetContextPanel().id == "Versus" && !mockdata )
		{
			_m_cP = $( "#Versus" );

			_m_bInitialized = true;

		}
		else
			return false;
		
		if ( !_SelectScene() )
			return false;

		  
		                                                      
		  
		_m_sTeamName = MockAdapter.GetPlayerTeamName( MockAdapter.GetLocalPlayerXuid() );
		                                                   
		if ( _m_sTeamName !== 'TERRORIST' && _m_sTeamName !== 'CT' )
			return false;
		
		_m_elContentRoot = _m_cP.FindChildTraverse( "id-vs-content-container" );

		_m_elContentRoot.RemoveAndDeleteChildren();

		_m_elMyTeam = $.CreatePanel( "Panel", _m_elContentRoot, 'versus-team--MyTeam' );
		_m_elMyTeam.BLoadLayoutSnippet( 'snippet-vs-team' );
		
		_m_elPreviewPanel_MyTeam = _m_elMyTeam.FindChildTraverse( "id-charlineup__characters" );
		_m_elPreviewPanel_MyTeam.SetScene( "resource/ui/econ/VersusCharactersMine.res", 'characters/models/ctm_sas/ctm_sas.vmdl', false );
		
		_m_elPreviewPanel_MyTeam.CreateSceneContexts( _m_oScene[ 'numModels' ] + 1 );
		
		_m_elWipe = $.CreatePanel( "Panel", _m_elContentRoot, 'versus-wipe' );

		_m_elMovie = _m_cP.FindChildTraverse( "id-vs-movie" );

		             
		_m_elMyTeam.AddClass( _m_sTeamName );
		_m_elMyTeam.SetDialogVariable( "teamname", MockAdapter.GetTeamClanName( _m_sTeamName ) );

		return true;
	}

	function _SelectScene ()
	{
		                                                         
		_m_oPlayersData = MockAdapter.GetAllPlayersMatchDataJSO();
		if ( !_m_oPlayersData || !_m_oPlayersData.scene ||
			!_m_oPlayersData.allplayerdata || !_m_oPlayersData.allplayerdata.length )
			return false;

		                                                                                                   
		_m_oScene = $.LoadKeyValuesFile( 'resource/characterscenes/' + _m_oPlayersData.scene + '.res', 'MOD' );
		if ( !_m_oScene )
			return false;
		
		                                
		var numModelsCT = 0;
		if ( 'CT' in _m_oScene )
		{
			while ( ''+numModelsCT in _m_oScene['CT'] )
				++ numModelsCT;
		}
		var numModelsT = 0;
		if ( 'TERRORIST' in _m_oScene )
		{
			while ( ''+numModelsT in _m_oScene['TERRORIST'] )
				++ numModelsT;
		}

		                                                                                       
		var numModelsMax = ( numModelsCT > numModelsT ) ? numModelsCT : numModelsT;
		if ( numModelsMax <= 0 )                                       
			return false;
		if ( numModelsCT != numModelsT )                        
			return false;

		  
		                                                   
		  
		_m_oScene.players = {};
		_m_oScene.players.TERRORIST = [];
		_m_oScene.players.CT = [];
		for ( var j = 0; j < _m_oPlayersData.allplayerdata.length; ++ j )
		{
			var teamnameForPlayer = null;
			switch ( _m_oPlayersData.allplayerdata[j].teamnumber )
			{
				case 2: teamnameForPlayer = 'TERRORIST'; break;
				case 3: teamnameForPlayer = 'CT'; break;
			}
			if ( teamnameForPlayer )
			{
				_m_oScene.players[ teamnameForPlayer ].push( _m_oPlayersData.allplayerdata[j] );
			}
		}

		                                        
		_m_oScene[ 'numModels' ] = numModelsMax;
		return true;
	}


	function _AddCharacter ( n, team )
	{

		var arrAnimData = _m_oScene[ team ];
		var elPanel = _m_elPreviewPanel_MyTeam;
		var elTeamPanel = $( "#versus-team--MyTeam" );

		if ( n >= _m_oScene.players[ team ].length )
			return false;                                        

		var thisPlayer = _m_oScene.players[ team ][n];
		var xuid = thisPlayer.xuid;

		elPanel.SetActiveSceneContext( n );
		
		                                                                    
		for ( var idxItem = 0; idxItem < thisPlayer.items.length; ++ idxItem )
		{
			var ullItemID = thisPlayer.items[ idxItem ].itemid;
			if ( !ullItemID ) continue;
			var strItemCategory = InventoryAPI.GetLoadoutCategory( ullItemID );
			
			if ( strItemCategory === 'customplayer' )
			{	                              
				elPanel.SetPlayerModel( ItemInfo.GetModelPlayer( ullItemID ) );
			}
			else if ( strItemCategory === 'clothing' )
			{	                      
				elPanel.EquipPlayerWithItem( ullItemID );
			}
			else
			{	                                                          
				elPanel.EquipPlayerWithItem( ullItemID );
				break;                                                                       
			}
		}
		
		                                 
		elPanel.PlaySequence( arrAnimData[ n ].sequence, true );

		var elIdentityContainer = elTeamPanel.FindChildTraverse( "id-vs-identity-container" );

		var elIdentity = $.CreatePanel( "Panel", elIdentityContainer, 'id-identity-' + team + "-" + n );
		elIdentity.BLoadLayoutSnippet( 'snippet-vs-identity' );

		       
		elIdentity.SetDialogVariable( "player_name", thisPlayer.name );

		         
		var elAvatarImage = elIdentity.FindChildTraverse( "id-player__avatar" );
		if ( elAvatarImage )
		{
			if ( MockAdapter.IsXuidValid( xuid ) )
			{
				elAvatarImage.PopulateFromSteamID(xuid);
			}
			else
			{
				elAvatarImage.SetDefaultImage( "file://{images}/icons/scoreboard/avatar-" + team + ".png" );
			}

			var teamColor = ( thisPlayer.playercolor === undefined ) ? '' : GameStateAPI.GetPlayerColor( '#'+ thisPlayer.playercolor );
			if ( teamColor )
			{
				elAvatarImage.style.borderColor = teamColor;
				elAvatarImage.style.borderWidth = "1px";
				elAvatarImage.style.borderStyle = "solid";
			}

		}

	}

	                           
	function _AddScene ( n, team, mdlName )
	{
		var elPanel = team == 'enemy' ? _m_elPreviewPanel_EnemyTeam : _m_elPreviewPanel_MyTeam;

		elPanel.SetActiveSceneContext( n );
		elPanel.SetSceneModel( mdlName );
	}

	function _AspectRatioTest ( returnThisIf4x3, returnThisIf16x9, returnThisIf16x10 )
	{
		if ( $.GetContextPanel().BAscendantHasClass( 'AspectRatio4x3' ) )
		{
			return returnThisIf4x3;
		}
		else if ( $.GetContextPanel().BAscendantHasClass( 'AspectRatio16x9' ) )
		{
			return returnThisIf16x9;
		}
		else if ( $.GetContextPanel().BAscendantHasClass( 'AspectRatio16x10' ) )
		{
			return returnThisIf16x10;
		}
	}

	function _Show ( teamOverride = undefined ) 
	{
		if ( !_Init( teamOverride ) )
			return;

		                                 
		_m_elMovie.SetMovie( "file://{resources}/videos/vs_bg.webm" );

		for ( var i = 0; i < _m_oScene[ 'numModels']; i++ )
		{
			_AddCharacter( i, _m_sTeamName );
		}
		                                       
		_AddScene( _m_oScene[ 'numModels'], 'mine', "models/weapons/pedestal_team01.mdl" );

		_m_cP.style.animationDuration = _m_totalTime + 's';
		_m_cP.AddClass( 'vs-show' );

		  		                                                        
		_m_elPreviewPanel_MyTeam.SetCameraPreset( 1, false );

		                       

		                                                  

		var teamFadeInDuration = 0.6;
		var teamFadeOutDuration = 0.6;

		var wipeDuration = 0.1;

		_m_elWipe.style.animationDuration = wipeDuration + 's';
		_m_elWipe.TriggerClass( 'play' );


		            
		$.Schedule( wipeDuration / 2, function()
		{
			_m_elPreviewPanel_MyTeam.AddClass( 'fade-in' );
			_m_elPreviewPanel_MyTeam.style.animationDuration = teamFadeInDuration + 's';

			         
			_m_elPreviewPanel_MyTeam.SetTimedCameraPreset( 2, teamFadeInDuration );

		} );

		var currentTime = teamFadeInDuration;

		                 
		if ( 1 )
			$.Schedule( currentTime, function( cTime )
			{
				var timeRemaining = _m_totalTime - cTime;

				_m_elPreviewPanel_MyTeam.SetTimedCameraPreset( 3, timeRemaining );

				_m_elPreviewPanel_MyTeam.SetFlashlightRotation( 1, 0, -1 );

			}.bind( undefined, currentTime ) )


		                                  
		if ( 1 )
			$.Schedule( currentTime, function( cTime )
			{
				var timeRemaining = _m_totalTime - cTime;

				           
				var elIdentityContainer = _m_elMyTeam.FindChildTraverse( "id-vs-identity-container" );

				var arrIdPanels = elIdentityContainer.Children();

				arrIdPanels.forEach( function( panel, index )
				{
					$.Schedule( index * 0.75, function( panel )
					{
						var prevPosY = undefined;
						                                                 
						if ( index > 0 )
						{
							var prevPosString = arrIdPanels[ index - 1 ].style.position;
							var prevPosY = Number( prevPosString.split( ' ' )[ 1 ].split( 'px' )[ 0 ] );
						}

						_m_elPreviewPanel_MyTeam.SetActiveSceneContext( index );
						var PanelPos = _m_elPreviewPanel_MyTeam.GetBonePositionInPanelSpace( 'head_0' );
						PanelPos.y -= 100;

						if ( 0 )        
						{
							var debugPanel = $.CreatePanel( "Panel", elIdentityContainer, "debug-pelvis" + index );
							debugPanel.style.border = "1px solid red";
							debugPanel.style.width = "20px";
							debugPanel.style.height = "20px";
							debugPanel.style.borderRadius = "50%";
							debugPanel.style.verticalAlign = "center";
							debugPanel.style.horizontalAlign = "center";
							debugPanel.style.position = PanelPos.x + "px " + PanelPos.y + "px 0px";
						}

						                                                    
						if ( prevPosY && Math.abs( PanelPos.y - prevPosY ) < 70 )
						{
							PanelPos.y -= 50;
							                                     
						}

						panel.style.position = PanelPos.x + "px " + PanelPos.y + "px 0px";
						panel.AddClass( 'fade-in' );
					}.bind( undefined, panel ) );
				} );

				                                           
				$.Schedule( 0, function()
				{
					           
					var elMyTeamName = _m_elMyTeam.FindChildTraverse( 'id-charlineup__characters__teamname' );
					elMyTeamName.AddClass( 'fade-in' );
					elMyTeamName.style.animationDuration = 3 +'s';
				} );

				           
				elIdentityContainer.style.transitionDuration = timeRemaining + 's';
				elIdentityContainer.AddClass( 'drift' );

			}.bind( undefined, currentTime ) )

		currentTime = _m_totalTime - teamFadeOutDuration;

		          
		if ( 1 )
			$.Schedule( currentTime, function( cTime )
			{
				                        

				var timeRemaining = _m_totalTime - ( cTime );

				           
				var elIdentityContainer = _m_elMyTeam.FindChildTraverse( "id-vs-identity-container" );
				elIdentityContainer.Children().forEach( function( panel, index )
				{
					panel.AddClass( 'hide' );
				} );

				_m_elPreviewPanel_MyTeam.SetTimedCameraPreset( 4, timeRemaining );

			}.bind( undefined, currentTime ) )

		$.Schedule( _m_totalTime - ( wipeDuration / 2 ), function()
		{
			_m_elWipe.TriggerClass( 'play' );
		} );

		if ( 1 )
			$.Schedule( _m_totalTime, function()
			{

				_m_cP.RemoveClass( 'vs-show' );
				                     
				_m_elMovie.SetMovie( "" );

				_m_bInitialized = false;

				var testpanel = $( "#LayoutPanel_CSGOVersus" );
				if ( testpanel )
				{
					testpanel.AddClass( "vs_show_hold" );
				}

			} );


	}

	return {
		Show: _Show,
	}
} )();

                                                                                                    
                                           
                                                                                                    
( function()
{
	$.RegisterForUnhandledEvent( "ShowVersusScreen", Versus.Show );
} )();
