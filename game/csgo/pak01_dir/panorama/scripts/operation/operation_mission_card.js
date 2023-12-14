
'use strict';

	                   
	                             

var OperationMissionCard = ( function()
{
	var _m_missionCardPrefix = 'id-mission-card-';
	var _m_missionBacklogIndex = 0;
	var _m_missionUnlockTimerHandler = null;

	var _UpdateMissionCard = function( idx, elParent )
	{
		var oCardDetails = _GetMissionCardDetails( idx );

		if( oCardDetails )
		{
			var elMissionCard  = _CreateMissionCard( oCardDetails, elParent );
			var elContainer = elMissionCard.FindChildInLayoutFile( 'id-mission-card-missions-container' );
			_UpdateMissionCardDisplay( elMissionCard, oCardDetails );

			if( oCardDetails.bShowLock )
			{
				elMissionCard.SetHasClass( 'card-missions-locked', true );
			}
			else
			{
				var currentlyPlayingMissionId = GameStateAPI.GetActiveQuestID();
				var nActiveMissionInCardCount = 0;

				var aMissions = [];
				
				for( var iMission = 0; iMission < oCardDetails.quests.length; ++iMission) {
					var missionId = oCardDetails.quests[ iMission ];
					
					var oMissionDetails = OperationUtil.GetMissionDetails( missionId );
					aMissions.push( oMissionDetails );
					nActiveMissionInCardCount = currentlyPlayingMissionId === missionId ? 
						nActiveMissionInCardCount++ : nActiveMissionInCardCount;
				}

				aMissions.sort(function(a, b)
				{
					return ( b.nMissionPointsRemaining > a.nMissionPointsRemaining ) ? 1 : -1;
				});

				aMissions.forEach(element => {
					var elMission = OperationMission.CreateMission( elContainer, element, oCardDetails.isunlocked );
					
					OperationMission.UpdateMissionDisplay( elMission, element, oCardDetails.isunlocked, oCardDetails.id );
				});

				if ( GameStateAPI.IsLocalPlayerPlayingMatch() )
				{
					elMissionCard.SetHasClass( 'no-mission-warning', nActiveMissionInCardCount < 1 );
				}
			}
		}
	}

	var _GetMissionCardDetails = function( idx )
	{
		var oCardDetails = MissionsAPI.GetSeasonalOperationMissionCardDetails( OperationUtil.GetOperationInfo().nSeasonAccess, idx );
		if ( oCardDetails )
		{
			oCardDetails.isunlocked = idx < InventoryAPI.GetMissionBacklog();
			oCardDetails.idx = idx;
			oCardDetails.bShowLock = ( oCardDetails.quests.length <= 0 )
				|| ( !oCardDetails.isunlocked && !oCardDetails.showTimer );

			return oCardDetails;
	
			                                                                   
			                                                                  

			                       
			   
				                                                            
			   
			       
			   
				                                                                              
					                                                  
					                                                                                       
				   
				
					                                                 
				   
					                                                                                                   
				   
			   

			                                                
			                                                                                               
			                                        
			                                 
				                                          
				  	                                                                        
				   
			      

			                                      

			
			                       
			                                      
			                       
		}
		else
		{
			                                                                                

			return null;
		}
	};

	var _CreateMissionCard = function( oCardDetails, elParent )
	{
		var elMissionCard = null;
		
		if ( !elParent.FindChildInLayoutFile( _m_missionCardPrefix + oCardDetails.id ) )
		{
			                                                                     
			elParent.RemoveAndDeleteChildren();
			
			elMissionCard = $.CreatePanel( 'Panel',
				elParent,
				_m_missionCardPrefix + oCardDetails.id,
				{
					group: 'mission_cards',
					hittest: false
				} );
			
			elMissionCard.BLoadLayout('file://{resources}/layout/operation/operation_mission_card.xml', false, false );
		}
		else
		{
			elMissionCard = elParent.FindChildInLayoutFile( _m_missionCardPrefix + oCardDetails.id );
		}

		return elMissionCard;
	};

	var _UpdateMissionCardDisplay = function( elMissionCard, oCardDetails )
	{
		elMissionCard.FindChildInLayoutFile( 'id-mission-card-tag' ).SetHasClass( 'hidden', oCardDetails.idx !== OperationUtil.GetOperationInfo().nActiveCardIndex );
		
		elMissionCard.SetDialogVariable( 'mission_name', $.Localize( oCardDetails.name ));
		elMissionCard.SetDialogVariableInt( 'card_points_needed', oCardDetails.operational_points );
		elMissionCard.SetDialogVariableInt( 'card_week', oCardDetails.idx + 1 );

		_UpdateEarnedPoints( elMissionCard, oCardDetails );
		                                                       
	};

	var _BackgroundImage = function ( elMissionCard, idx )
	{
		var image = 'url("file://{images}/operations/op11/mission_' + idx  +'.png")';
		elMissionCard.style.backgroundImage = image;
		elMissionCard.style.backgroundPosition = '50% 0%;';
		elMissionCard.style.backgroundSize = 'auto 100%;';
		elMissionCard.style.backgroundImgOpacity = '.2;';
		                                                                
	};

	var _UpdateUnlockTimer = function( elMissionCard )
	{
		_m_missionUnlockTimerHandler = null;
		
		if ( _m_missionBacklogIndex !== InventoryAPI.GetMissionBacklog() )
		{
			if ( InventoryAPI.GetMissionBacklog() && InventoryAPI.GetMissionBacklog() > 0 )
			{
				_m_missionBacklogIndex = InventoryAPI.GetMissionBacklog();
				                        
				_GetMissionCardDetails( elMissionCard.Data().idx, elMissionCard.GetParent());
			}
			else
			{
				_m_missionBacklogIndex = 0;
			}

			return;
		}

		                                        
		if ( elMissionCard.IsValid() && elMissionCard.Data().idx === _m_missionBacklogIndex )
		{
			var seconds = InventoryAPI.GetSecondsUntilNextMission();

			                                                
			elMissionCard.SetHasClass( 'hastimer', ( seconds && seconds !== 0 ) );
			if ( seconds && seconds !== 0 )
			{
				seconds = seconds <= 60 ? 60 : seconds;
				                  
				elMissionCard.SetDialogVariable( 'unlock_time', FormatText.SecondsToSignificantTimeString( seconds ) );
				                                                           
				                                                                                                                    
			}

			_m_missionUnlockTimerHandler = $.Schedule( 5, _UpdateUnlockTimer.bind( undefined, elMissionCard ) );
			                                                                            
		}
	};

	var _CancelUnlockTimer = function()
	{
		if ( _m_missionUnlockTimerHandler )
		{
			$.CancelScheduled( _m_missionUnlockTimerHandler );
			                                                                                 
			_m_missionUnlockTimerHandler = null;
		}
	};

	var _UpdateEarnedPoints = function( elMissionCard, oCardDetails )
	{
		var oPoints =  OperationUtil.GetMissionCardEarnedPoints( oCardDetails );
		var nEarnedPoints = oPoints.totalCardPointsDisplay;

		elMissionCard.SetDialogVariableInt( 'card_points_earned', nEarnedPoints );

		var elLabel = elMissionCard.FindChildInLayoutFile( 'id-mission-card-stars-text' );
		elLabel.text = $.Localize( '#op_mission_card_points', elMissionCard );
		elMissionCard.SetHasClass( 'card-complete', nEarnedPoints >= oCardDetails.operational_points );
	};

	return {
		GetMissionCardDetails: _GetMissionCardDetails,
		UpdateMissionCard: _UpdateMissionCard,
		CancelUnlockTimer: _CancelUnlockTimer
	};
} )();
