
'use strict';

	                   
	                             

var OperationMission = ( function()
{
	var _m_missionPrefix = 'id-mission-';

	var _CreateMission = function( elContainer, oMissionDetails, isUnlocked )
	{
		                                                                                                                    

		var elMission = null;

		if ( !elContainer.FindChildInLayoutFile( oMissionDetails.missionId ) )
		{
			elMission = _LoadMissonSnippet(elContainer, oMissionDetails);
		}
		else
		{
			elMission = elContainer.FindChildInLayoutFile( oMissionDetails.missionId );
			
			                                                                   
			                                                                                                               
			if( oMissionDetails.nMissionPointsRemaining === 0 && !elMission.BHasClass( 'complete' ))
			{
				elMission.DeleteAsync(0);
				elMission = _LoadMissonSnippet(elContainer, oMissionDetails);
			}
		}

		elMission.enabled = isUnlocked;
		return elMission;
	};

	var _LoadMissonSnippet = function( elContainer, oMissionDetails )
	{
		var elMission = $.CreatePanel( 'Button',
			elContainer,
			oMissionDetails.missionId
		);

		elMission.BLoadLayout( 'file://{resources}/layout/operation/operation_mission_snippets.xml', false, false );
		return elMission;
	};

	var _UpdateMissionDisplay = function( elMission, oMissionDetails, isunlocked, missionCardId = null, bHideDesc = false )
	{
		                                                                                                        
		                                                                                                                                 
		                                                                                                      

		                                                                                          
		                                                                                                                                  
		                                                                                                       
		                                                                                                                                                 
		                                                                       
		                                                                         

		                            
		var goal = MissionsAPI.GetQuestPoints( oMissionDetails.missionId, "goal" );
		if ( !goal || goal === -1 )
		{
			return;
		}

		_UpdateMissionName( elMission, oMissionDetails.missionItemId );

		if ( !bHideDesc )
		{
			bHideDesc = oMissionDetails.missonType === 'or';
		}
		
		_UpdateMissionDesc( elMission, oMissionDetails.missionId, bHideDesc );
		_UpdateMissionIcon( elMission, isunlocked, oMissionDetails );
		_EnableDisableMission( elMission, isunlocked, oMissionDetails );

		if ( missionCardId )
		{
			_AddMissionActions( elMission, oMissionDetails, missionCardId );
		}
		
		var elParent = elMission.FindChildInLayoutFile( 'id-mission-segments-container' );

		if ( oMissionDetails.missonType === 'or' )
		{
			var oCompletedOrQuest = oMissionDetails.aSubQuests.filter( element => element.nsubQuestPointsRemaining === 0 )[ 0 ];

			var uncommitedPointsMeetGoal = false;
			if ( oCompletedOrQuest )
			{
				var elContainer = LoadSnippetByType( elParent, missionPanelId, "snippet-mission-segment-container" );
				_UpdateMissionDesc( elMission, oCompletedOrQuest.missionId, bHideDesc = false );
				_UpdateSegmentsMissionTypes( oMissionDetails, elContainer, oMissionDetails.aSegmentsData[ 0 ], oCompletedOrQuest, 0 );
			}
			else
			{
				for ( var i = 0; i < oMissionDetails.aSubQuests.length; i++ )
				{
					if ( !uncommitedPointsMeetGoal && oMissionDetails.aSubQuests[i].nUncommitted >= oMissionDetails.aSubQuests[i].nGoal )
					{
						uncommitedPointsMeetGoal = true;
					}
					_UpdateOrTypeMission( oMissionDetails, oMissionDetails.aSegmentsData[ 0 ], elParent, i );
				}

				var aStars = elParent.FindChildInLayoutFile( 'id-mission-segments-stars' ).Children();
				aStars.forEach(element => {
					element.SetHasClass( 'uncommitted', uncommitedPointsMeetGoal );
				}); 
			}
		}
		else
		{
			var missionPanelId = _m_missionPrefix + oMissionDetails.missionId;
			var elContainer = LoadSnippetByType( elParent, missionPanelId, "snippet-mission-segment-container" );

			for ( var i = 0; i < oMissionDetails.nMissionSegments; i++ )
			{
				_UpdateSegmentsMissionTypes( oMissionDetails, elContainer, oMissionDetails.aSegmentsData[ i ],null, i );
			}
		}

		elMission.SetHasClass( 'complete', oMissionDetails.nMissionPointsRemaining === 0 && isunlocked );
		elMission.SetHasClass( 'hidebar', MatchStatsAPI.GetGameMode() === "cooperative" && GameStateAPI.IsLocalPlayerPlayingMatch() );

		                            	                                     
		                          		                                    
		                 				                                  
		                 				                                
		                   			                              
		                                                                                                              

		MissionsAPI.ApplyQuestDialogVarsToPanelJS( Number( oMissionDetails.missionItemId ), elMission );
	};

	var _UpdateOrTypeMission = function( oMissionDetails, oSegmentData, elParent, index )
	{
		var oSubQuestData = oMissionDetails.aSubQuests[ index ];
		var elContainer = LoadSnippetByType( elParent, _m_missionPrefix + oSubQuestData.missionId, "snippet-mission-segment-container-or-type" );
		elContainer.SetDialogVariableInt( 'points', oSubQuestData.nGoal );

		_UpdateMissionDesc( elContainer, oSubQuestData.missionId, false );

		var segmentPanelId = _m_missionPrefix + oSubQuestData.missionId + '_segment' + index;
		_CreateBars( elContainer.FindChildInLayoutFile( 'id-mission-bar' ),
			oSegmentData,
			oSubQuestData,
			oMissionDetails,
			segmentPanelId
		);

		var nEarnedDisplay = _GetTotalPointsEarned( oMissionDetails, oSegmentData, oSubQuestData );
		var elCount = _CreateSectionCount( elContainer.FindChildInLayoutFile( 'id-mission-bar' ), oSubQuestData.nGoal, nEarnedDisplay );
		var isMissionCompleteWithUncommittedPoints = ( ( nEarnedDisplay >= oSubQuestData.nGoal ) && oMissionDetails.nMissionPointsRemaining > 0 );

		elCount.SetHasClass( 'uncommitted', isMissionCompleteWithUncommittedPoints );

		if ( index === 0 )
		{
			var starsPanelId = _m_missionPrefix + "sudquest-stars" + oSubQuestData.missionId;
			var elStarsContainer = LoadSnippetByType( elParent, starsPanelId, "snippet-mission-stars-container-or-type" );
			
			for ( var k = 0; k < oMissionDetails.nOpPointsPerSegment; k++ )
			{
				var starPanelId = _m_missionPrefix + oSubQuestData.missionId + '_star' + k;
				var elStar = _CreateMissionStar(
					elStarsContainer.FindChildInLayoutFile( 'id-mission-segments-stars' ),
					oMissionDetails.aSegmentsData[ 0 ],
					oMissionDetails,
					starPanelId,
					nEarnedDisplay );
			}
		}
	};

	var _UpdateSegmentsMissionTypes = function( oMissionDetails, elContainer, oSegmentData, oSubQuestData, index )
	{	
		var segmentPanelId = _m_missionPrefix + oMissionDetails.missionId + '_segment' + index;
		_CreateBars( elContainer,
			oSegmentData,
			oSubQuestData,
			oMissionDetails,
			segmentPanelId
		);

		var nEarnedDisplay = _GetTotalPointsEarned( oMissionDetails, oSegmentData, oSubQuestData );

		if ( oMissionDetails.nMissionSegments === 1 )
		{
			var nGoal = oMissionDetails.missonType === 'or' ? oSubQuestData.nGoal : oSegmentData.nGoal;
			var elCount = _CreateSectionCount( elContainer, nGoal, nEarnedDisplay );
			elCount.SetHasClass( 'uncommitted', ( oMissionDetails.nUncommitted + oSegmentData.nEarned ) >= oSegmentData.nGoal && !oSegmentData.isComplete );
		}

		for ( var k = 0; k < oMissionDetails.nOpPointsPerSegment; k++ )
		{
			var starPanelId = _m_missionPrefix + segmentPanelId + '_star' + k;
			var elStar = _CreateMissionStar( elContainer, oSegmentData, oMissionDetails, starPanelId, nEarnedDisplay );

			elStar.SetHasClass( 'uncommitted', ( oMissionDetails.nUncommitted + oSegmentData.nEarned ) >= oSegmentData.nGoal && !oSegmentData.isComplete );
		}
	};

	var _GetTotalPointsEarned = function( oMissionDetails, oSegmentData, oSubQuestData )
	{
		if ( oMissionDetails.isReplayable )
		{
			return oSegmentData.nEarned;
		}

		                                                                                                             
		                                                            
		var oData = oMissionDetails.missonType === 'or' ? oSubQuestData : oSegmentData;
		var nUncommitted = oMissionDetails.missonType === 'or' ? oSubQuestData.nUncommitted : oMissionDetails.nUncommitted;

		if ( oData.isComplete || ( oData.nEarned + nUncommitted ) >= oData.nGoal )
		{
			return oData.nGoal;
		}

		return oData.nEarned + nUncommitted;
	}

	var _UpdateMissionDesc = function ( elMission, missionId, bhideDesc )
	{
		elMission.SetHasClass( 'hide-desc', bhideDesc );
		if( bhideDesc )
			return;

		var nQuestID = Number( missionId );
		var elMissionDescLabel = elMission.FindChildInLayoutFile( 'id-mission-desc' );
		elMissionDescLabel.visible = true;
		OperationUtil.SetLocalizationStringAndVarsForMission( elMissionDescLabel, nQuestID, "loc_description" );
	};

	var _HudIncompleteSubMissions = function( elMission, aIncompleteMissions )
	{
		var elContainer = elMission.FindChildInLayoutFile( 'id-snippet-hud-next-subquests' );
		
		if( aIncompleteMissions.length > 0 )
		{
			for ( var i = 0; i < aIncompleteMissions.length; i++ )
			{
				var elSegment = LoadSnippetByType( elContainer, aIncompleteMissions[i].missionId , "snippet-hud-next-subquest" );
				OperationUtil.SetLocalizationStringAndVarsForMission(
					elSegment.FindChildInLayoutFile( 'id-subquest-desc' ),
					Number( aIncompleteMissions[i].missionId ), "loc_description" );
			}
		}

		var aChildren = elContainer.Children();
		aChildren.forEach( element => {
			var nUncommitted = MissionsAPI.GetQuestPoints( Number( element.id ), "uncommitted" );
			var nGoal = MissionsAPI.GetQuestPoints( Number( element.id ), "goal" );
			
			if ( nUncommitted > 0 )
			{
				var nDisplay = nUncommitted >= nGoal ? nGoal : nUncommitted;
				element.SetDialogVariableInt( 'uncommited', nDisplay );
				element.SetDialogVariableInt( 'goal', nGoal );
			}

			element.FindChildInLayoutFile( 'id-subquest-progress' ).visible = nUncommitted > 0 && nGoal > 1;

			if ( element.FindChildInLayoutFile( 'id-subquest-progress' ).visible && nUncommitted < nGoal )
			{
				elContainer.MoveChildBefore( element, elContainer.GetChild( 0 ) );
			}

			if ( nUncommitted >= nGoal )
			{
				elContainer.MoveChildBefore( element, elContainer.GetChild( 0 ) );
				element.AddClass( 'uncommitted' );

				$.Schedule( 1.5, function(){ element.AddClass( 'hide-submission' ) });
			}
		});
	}

	var _UpdateMissionName = function ( elMission, missionItemId )
	{
		elMission.FindChildInLayoutFile( 'id-mission-name' ).text = InventoryAPI.GetItemName( missionItemId );
	}

	var _UpdateMissionIcon = function( elMission, isunlocked, oMissionDetails )
	{
		var currentlyPlayingMissionId = GameStateAPI.GetActiveQuestID();
		var elIcon = elMission.FindChildInLayoutFile( 'id-mission-card-icon-play' );
		elIcon.visible = oMissionDetails.nMissionPointsRemaining !== 0 && 
			isunlocked && 
			currentlyPlayingMissionId !== oMissionDetails.missionId;

		elIcon.SetImage( 'file://{images}/icons/ui/' + oMissionDetails.missionGameMode + '.svg' );
		elIcon.SetHasClass( 'nocolor', ( oMissionDetails.missionGameMode.startsWith( 'competitive' ) || 
			oMissionDetails.missionGameMode === 'survival' ));

		elMission.FindChildInLayoutFile( 'id-mission-card-icon-locked' ).visible = !isunlocked;
		elMission.FindChildInLayoutFile( 'id-mission-card-icon-complete' ).visible = !oMissionDetails.isReplayable &&
			oMissionDetails.nMissionPointsRemaining === 0 &&
			isunlocked;
		elMission.FindChildInLayoutFile( 'id-mission-card-spinner' ).visble = isunlocked && currentlyPlayingMissionId === oMissionDetails.missionItemId;
		elMission.FindChildInLayoutFile( 'id-mission-card-icon-replay' ).visible = oMissionDetails.isReplayable &&
			oMissionDetails.nMissionPointsRemaining === 0 &&
			isunlocked;
	};

	var _EnableDisableMission = function( elMission, isunlocked, oMissionDetails)
	{
		                                             
		elMission.enabled = isunlocked &&
		( oMissionDetails.nMissionPointsRemaining !== 0 ||
			oMissionDetails.isReplayable );
	};

	var _AddMissionActions = function( elMission, oMissionDetails, missionCardId )
	{
		elMission.SetPanelEvent( 'onactivate',
			_SetMissionOnActivate.bind(
				undefined, 
				missionCardId, 
				oMissionDetails.missionItemId, 
				OperationUtil.GetOperationInfo().nSeasonAccess
		) );

		if( oMissionDetails.missonType === 'checklist' || oMissionDetails.missonType === 'sequential' )
		{
			elMission.SetPanelEvent( 'onmouseover',
				_ShowMissionTooltip.bind(
					undefined,
					elMission,
					oMissionDetails
			));

			elMission.SetPanelEvent( 'onmouseout', _HideMissionTooltip )
		}
		else
		{
			elMission.ClearPanelEvent( 'onmouseover' );
			elMission.ClearPanelEvent( 'onmouseout' );
		}
	};

	var _CreateBars = function( elContainer, oSegmentData, oSubQuestData, oMissionDetails, segmentPanelId, )
	{
		var nSegments = oSegmentData.nSegmentIncrementalGoalDelta;
		var isSingleBar = ( oMissionDetails.nMissionSegments === 1 || oMissionDetails.missonType === 'or' ) ? true : false;

		for ( var i = 0; i < nSegments; i++ )
		{
			var segmentSubMissionPanelId = segmentPanelId + 'sub_' + i;
			var elBar = LoadSnippetByType( elContainer, segmentSubMissionPanelId, "snippet-mission-segment" );
			elBar.SetHasClass('op_mission-card__mission__bar-container-seq', oMissionDetails.missonType === 'sequential');
			elBar.SetHasClass( 'op-mission-card__mission__bar-container--no-y-offset', isSingleBar );

			var nPercentComplete = 0;
			var nPercentCompleteUncommitted = 0;
			
			if( oMissionDetails.missonType === 'or' )
			{
				nPercentComplete = oSubQuestData.nPercentComplete;
				nPercentCompleteUncommitted = oSubQuestData.nPercentCompleteUncommitted;
			}
			else if ( oMissionDetails.isReplayable )
			{
				nPercentComplete = oSegmentData.nPercentComplete;
			}
			else if ( oMissionDetails.aSubQuests )
			{
				var oSubQuest = oMissionDetails.aSubQuests[ oSegmentData.nPreviousGoal + i ];
				nPercentComplete = oSubQuest.nPercentComplete;
				
				                                                                
				nPercentCompleteUncommitted = oSubQuest.nUncommitted < oSubQuest.nGoal ? 0 : 100;
			}

			elBar.FindChildInLayoutFile( 'id-mission-card-bar' ).style.width = nPercentComplete + '%;';
			elBar.FindChildInLayoutFile( 'id-mission-card-bar-uncommitted' ).style.width = nPercentCompleteUncommitted + '%;';
		}
	};

	var _CreateMissionStar = function( elContainer, oSegmentData, oMissionDetails, starPanelId, nEarned )
	{
		var elStar = LoadSnippetByType( elContainer, starPanelId, "snippet-mission-star" );
		elStar.SetHasClass( 'complete', oSegmentData.isComplete );

		if( oMissionDetails.nMissionSegments > 1 )
		{
			elStar.SetDialogVariableInt( 'mission_points_goal', oSegmentData.nGoal );
			elStar.SetDialogVariableInt('mission_points_earned', nEarned );
			return elStar;
		}

		                                                                                                      
		elStar.SetDialogVariableInt( 'mission_points_goal', 0 );
		elStar.SetDialogVariableInt( 'mission_points_earned', 0 );
		elStar.SetHasClass( 'op-mission-card__hide-count', true );
		return elStar;
	};

	var _CreateSectionCount = function( elContainer, nGoal, nEarnedDisplay )
	{
		var elSectionCount = null;
		if( !elContainer.FindChildInLayoutFile( 'id-section-count' ) )
		{
			elSectionCount = $.CreatePanel( 'Label', 
				elContainer, 
				'id-section-count', 
				{class: 'op_mission-card__mission-progress-count'} 
				);
		}
		else
		{
			elSectionCount = elContainer.FindChildInLayoutFile( 'id-section-count' );
		}

		elSectionCount.text = nEarnedDisplay +'/'+ nGoal;
		return elSectionCount;
	}

	var LoadSnippetByType = function ( elContainer, snippetPanelId, snippetName )
	{
		var elSnippet = null;
		
		if ( !elContainer.FindChildInLayoutFile( snippetPanelId ) )
		{
			elSnippet = $.CreatePanel( 'Panel',
				elContainer,
				snippetPanelId
			);
			
			elSnippet.BLoadLayoutSnippet( snippetName );
		}
		else
		{
			elSnippet = elContainer.FindChildInLayoutFile( snippetPanelId );
		}

		return elSnippet;
	}

	var _SetMissionOnActivate = function( missionCardId, MissionItemID, nSeasonAccess )
	{
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE' );

		if ( OperationUtil.IsMissionLockedBehindPremiumOperationPass( missionCardId, MissionItemID, nSeasonAccess ) )
		{
			var sFauxPassItemID = OperationUtil.GetPassFauxId();
			var sOperationPassName = ItemInfo.GetName( sFauxPassItemID );

			UiToolkitAPI.ShowGenericPopupYesNo( sOperationPassName,                                                           
					"#op_mission_requires_premium_pass", "",
					function() { OperationUtil.OpenUpSell(); },
					function() {} 
				);
			return;
		}

		                                                                                
		var gameMode = InventoryAPI.GetQuestGameMode( MissionItemID );
		if ( gameMode === 'competitive' )
		{
			var bModeUnlocked = MyPersonaAPI.HasPrestige() || ( MyPersonaAPI.GetCurrentLevel() >= 2 );
			if ( !bModeUnlocked )
			{
				                                                      
				                                                               

				UiToolkitAPI.ShowGenericPopupOk(
					"#PlayMenu_unavailable_locked_mode_title",
					"#PlayMenu_unavailable_newuser_2",
					"",
					function() {},
					function() {} 
				);
				return;
			}
		}

		UiToolkitAPI.ShowCustomLayoutPopupParameters( 
			'',
			'file://{resources}/layout/popups/popup_activate_mission.xml',
			'message=' + $.Localize( '#op_mission_activate' ) +
			'&' + 'requestedMissonCardId=' + missionCardId +
			'&' + 'seasonAccess=' + nSeasonAccess +
			'&' + 'questItemID=' + MissionItemID +
			'&' + 'spinner=1'
		);
	};

	var _ShowMissionTooltip = function ( elMission, oMissionDetails )
	{
		var submissionids = [];

		oMissionDetails.aSubQuests.forEach(element => {
			submissionids.push( element.missionId );
		});
		
		UiToolkitAPI.ShowCustomLayoutParametersTooltip( 
			elMission.id, 
			'TooltipMission', 
			'file://{resources}/layout/tooltips/tooltip_mission.xml',
			'type=' + oMissionDetails.missonType +
			'&' + 'gamemode=' + oMissionDetails.missionGameMode +
			'&' + 'mission-id=' + oMissionDetails.missionId +
			'&' + 'sub-mission-ids=' + submissionids.join(',')
			);
	}

	var _HideMissionTooltip = function()
	{
		UiToolkitAPI.HideCustomLayoutTooltip( 'TooltipMission' );
	}

	return {
		CreateMission: _CreateMission,
		UpdateMissionDisplay: _UpdateMissionDisplay,
		HudIncompleteSubMissions: _HudIncompleteSubMissions
	};
} )();