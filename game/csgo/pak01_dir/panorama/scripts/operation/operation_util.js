'use strict';

var OperationUtil = ( function () {

	var m_nSeasonAccess = -1;
	var m_numTierUnlocked = 0;
	var m_numMissionsCompleted = 0;

	                         
	var m_nRedeemableGoodsCount = 0;

	var m_numMissionsRewardThresholds = 0;
	var m_bPremiumUser = false;
	var m_nCoinRank = 0;
	var m_nActiveCardIndex = 0;
	var m_nRewardsCount = 0;
	var m_numRedeemableBalance = 0;
	var m_nLoopingRewardsCount = 0;
	var m_bPrime = false;
	var m_aCoinDefIndexes = [4759, 4760, 4761, 4762];
	var m_aStarDefIndexes = [4763, 4764, 4765]
	var m_passStoreId = 4758;

	var _ValidateOperationInfo = function( nSeasonAccess )
	{
		                                               
		                               
		                                                                          
		m_nSeasonAccess = nSeasonAccess;
		
		if ( nSeasonAccess < 0 || nSeasonAccess === null || nSeasonAccess === undefined )
			return false;
		
		m_nSeasonAccess = nSeasonAccess;
		                                                 

		m_nCoinRank = MyPersonaAPI.GetMyMedalRankByType( ( m_nSeasonAccess + 1 ) + "Operation$OperationCoin" );
		                                           

		m_bPrime = PartyListAPI.GetFriendPrimeEligible( MyPersonaAPI.GetXuid() );
		m_nRewardsCount = MissionsAPI.GetSeasonalOperationTrackRewardsCount( m_nSeasonAccess );
		m_nRedeemableGoodsCount = MissionsAPI.GetSeasonalOperationRedeemableGoodsCount( m_nSeasonAccess );
		m_nLoopingRewardsCount = MissionsAPI.GetSeasonalOperationLoopingRewardsCount( m_nSeasonAccess );
		m_numMissionsRewardThresholds = MissionsAPI.GetSeasonalOperationXpRewardsThresholds( m_nSeasonAccess );

		                                                                                                                         
		var idxOperation = InventoryAPI.GetCacheTypeElementIndexByKey( 'SeasonalOperations', m_nSeasonAccess );
		if ( idxOperation != undefined && idxOperation != null
			&& InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'season_value' ) == m_nSeasonAccess )
		{	                                                         
			m_numMissionsCompleted = InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'missions_completed' );
			m_numTierUnlocked = InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'tier_unlocked' );
			if ( m_nRedeemableGoodsCount && m_nRedeemableGoodsCount > 0 )
			{
				var spt = InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'season_pass_time' );
				m_bPremiumUser = ( spt && ( spt > 0 ) ) ? true : false;
			}
			else
			{
				var spt = InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'premium_tiers' );
				m_bPremiumUser = ( spt && ( spt >= 1 ) ) ? true : false;
			}
			m_nActiveCardIndex = MissionsAPI.GetSeasonalOperationMissionCardActiveIdx( m_nSeasonAccess );
			m_numRedeemableBalance = InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'redeemable_balance' );
		}
		else
		{
			                                             

			m_numMissionsCompleted = 0;
			m_numTierUnlocked = 0;
			m_bPremiumUser = false;
			m_nActiveCardIndex = -1;
			m_numRedeemableBalance = 0;
		}

		_AddLoopingRewardsToDisplay();

		                                                 
		                                                            
		                                                          
		                                                            
		                                                  
		                                         
		                                 
		                                                  
		                                                                  

		return true;
	};

	var _AddLoopingRewardsToDisplay = function()
	{
		                                    
		if ( m_nLoopingRewardsCount > 0 )
		{	                                                
			m_nRewardsCount += m_nLoopingRewardsCount;
			                                                                        
			while ( m_numTierUnlocked > m_nRewardsCount - m_nLoopingRewardsCount )
			{
				m_nRewardsCount += m_nLoopingRewardsCount;
			}
		}
	};

	var _GetObjValue= function( bHasStoreItems, rewardIndex, item )
	{
		                     
		var data;
		
		if( bHasStoreItems )
		{
			data = MissionsAPI.GetSeasonalOperationRedeemableGoodsSchema( m_nSeasonAccess, rewardIndex, item.value );
		}
		else
		{
			data = MissionsAPI.GetSeasonalOperationTrackRewardSchema( m_nSeasonAccess, rewardIndex, item.value );
		}

		                                                                                          
		if( item.value === 'ui_order')
		{
			return data ? data : '';
		}
		else{
			return data;
		}
	};

	var _GetContainerTypeForReward = function( oRewardData )
	{
		var rewardId = oRewardData.itempremium.ids[ 0 ];
		
		var toolsKey = InventoryAPI.GetRawDefinitionKey( rewardId, "inv_container_and_tools" ); 

		                                  

		if( ( toolsKey === "weapon_case" ) )
		{
			return 'isWeaponsCase';
		}
		else if ( toolsKey === "graffiti_box" ){
			return 'isGraffitiBox';
		}
		else if( InventoryAPI.GetRawDefinitionKey( rewardId, "item_type" ) === "operation_coin" )
		{
			return 'isCoin';
		}
		else if( ItemInfo.IsCharacter( oRewardData.lootlist[0] ) )
		{
			return 'isCharacterLootlist';
		}
		else if( ItemInfo.IsWeapon( oRewardData.lootlist[0] ) )
		{
			return 'isWeaponLootlist';
		}

		return 'isStickerLootlist';
	};

	var _GetRewardsData = function()
	{
		                                    
		if ( !m_nSeasonAccess || m_nSeasonAccess === -1 )
		{
			return;
		}
		var bHasStoreItems = _HasStoreItems();
		var nRewardsCount  = bHasStoreItems ? m_nRedeemableGoodsCount : m_nRewardsCount;
		                                                              

		var aRewardDataFields = [
			{ objHandle:'points', value: 'points'},
			{ objHandle:'flags', value: 'flags'},
			{ objHandle:'uiOrder', value: 'ui_order'},
			{ objHandle:'imagePath', value: 'ui_image'},
			{ objHandle:'imagePathInspect', value: 'ui_image_inspect'},
			{ objHandle:'imagePathThumbnail', value: 'ui_image_thumbnail'},
			{ objHandle:'RewardItemsNames', value: 'item_name'},
			{ objHandle:'RewardItemGroups', value: 'item_name_groups'},
			{ objHandle:'FreeRewardItemsNames', value: 'item_name_free'},
			{ objHandle:'useAsCallout', value: 'callout'},
			{ objHandle:'isGap', value: 'none'},
			{ objHandle:'lootlist', value: []},
			{ containerType:'' }
		];

		var _allRewardsData = [];

		for ( var i = 0; i < nRewardsCount; i++ )
		{
			var _rewardData = {};
			_rewardData.idx = i;
			aRewardDataFields.forEach(function( item, index ) 
			{
				                                              
				_rewardData[item.objHandle] = _GetObjValue( bHasStoreItems, i, item );
			});

			                                                                                                                                  
			                                                                                                                 
			                                                                             
			                                                                                                           
			                                              
			var rewardTypes = [
				{ type: 'premium', names: _rewardData.RewardItemsNames },
				{ type: 'free', names: _rewardData.FreeRewardItemsNames }
			];

			rewardTypes.forEach( rType =>
			{
				if( !rType.names )
				{
					rType.names = '';
				}
				
				var items = { type: rType.type, ids: [] };
				var nameList = rType.names.split( ',' );
				nameList.forEach( reward =>
				{
					if ( reward )
					{
						var itemidForReward;
						if ( reward.startsWith( 'lootlist:' ) )
						{                                               
							itemidForReward = InventoryAPI.GetLootListItemIdByIndex( reward, 0 );
						} else
						{	                                                  
							var nDefinitionIndex = InventoryAPI.GetItemDefinitionIndexFromDefinitionName( reward );
							itemidForReward = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( nDefinitionIndex, 0 );
						}
						items.ids.push( itemidForReward );
					}
				} );

				_rewardData[ 'item' + rType.type ] = items;
			} );
			
			if ( _rewardData.RewardItemGroups )
			{
				var posUnderscore = _rewardData.RewardItemGroups.lastIndexOf('_');
				var numGroups = parseInt( _rewardData.RewardItemGroups.substr( posUnderscore + 1 ) ) + 1;
				var strBaseLootlistName = _rewardData.RewardItemGroups.substr( 0, posUnderscore + 1 );
				_rewardData.lootlistGroups = [];
				_rewardData.lootlist = [];
				for ( var k = 0; k < numGroups; ++ k )
				{
					var idxFistGroupElement = _rewardData.lootlist.length;
					var strListName = 'lootlist:'+strBaseLootlistName+k;
					var moreItems = _GetLootListForReward( strListName );
					                                                                                                     
					if ( moreItems.length > 0 )
					{
						for ( var mm = 0; mm < moreItems.length; ++ mm )
						{
							_rewardData.lootlist.push( moreItems[mm] );
						}
						_rewardData.lootlistGroups.push( { idxBegin: idxFistGroupElement, idxEnd: _rewardData.lootlist.length } );
					}
				}
			}
			else
			{
				_rewardData.lootlist = _GetLootListForReward( _rewardData.itempremium.ids[ 0 ] );
			}
			_rewardData.containerType = _GetContainerTypeForReward( _rewardData );

			_allRewardsData.push( _rewardData );
		}

		return _allRewardsData;
	};

	var _GetLootListForReward = function( rewardId )
	{
		var count = ItemInfo.GetLootListCount( rewardId );
		var itemsList = [];
		if ( !count )
		{
			itemsList.push( rewardId );
		}
		else
		{
			for ( var i = 0; i < count; i++ )
			{
				  
				                                                                
				                                                              
				                            
				  
				var itemId = ItemInfo.GetLootListItemByIndex( rewardId, i );
				if ( InventoryAPI.DoesItemMatchDefinitionByName( itemId, 'spraypaint' ) || InventoryAPI.DoesItemMatchDefinitionByName( itemId, 'spray' ) )
				{
					itemId = InventoryAPI.GenerateSprayTintedItemID( itemId );
				}
				itemsList.push( itemId );
			}
		}

		return itemsList;
	};

	var _GettotalPointsFromAvailableFromMissions = function()
	{
		var totalPoints = 0;
		if ( !m_nSeasonAccess )
		{
			return  totalPoints;
		}
		
		var cardCount = MissionsAPI.GetSeasonalOperationMissionCardsCount( m_nSeasonAccess );

		for ( var i = 0; i < cardCount; i++ )
		{
			var jsoCardDetails = MissionsAPI.GetSeasonalOperationMissionCardDetails( m_nSeasonAccess, i );

			if ( !jsoCardDetails )
			{
				return;
			}

			totalPoints += jsoCardDetails.operational_points;

			                                                                                 
			   	                                                  
			   	                                                                                             
			   		                                                   
			    
		}

		return totalPoints;
	};

	var _GetMissionDetails = function( missionId )
	{
		var oMissionDetails = _UpdateMissionDetailsObject (Number( missionId ) );

		               
		                                                                                    
		                                                                                     
		                                      
		oMissionDetails.aSegmentsData = _UpdateSegmentData( oMissionDetails );

		                      
		                                                                       
		                                         
		var numGraphCount = MissionsAPI.GetQuestGraphCount( Number( missionId ));
		if ( numGraphCount > 0 )
		{
			oMissionDetails.aSubQuests = _UpdateSubQuestData( Number( missionId ), numGraphCount, oMissionDetails.missonType === 'checklist' );
		}

		                                                
		return oMissionDetails;
	}

	var _UpdateMissionDetailsObject = function( missionId )
	{
		var MissionItemID = InventoryAPI.GetQuestItemIDFromQuestID( missionId);

		                                         
		var gameMode = InventoryAPI.GetQuestGameMode( MissionItemID );
		var mapGroup = InventoryAPI.GetQuestMapGroup( MissionItemID );
		if ( !mapGroup )
		{
			mapGroup = 'mg_' + InventoryAPI.GetQuestMap( MissionItemID );
		}
		if ( mapGroup === 'mg_lobby_mapveto' )
		{
			gameMode = 'competitive_teams';
		}

		var numQuestGraphType = MissionsAPI.GetQuestGraphType( missionId );
		var missionGoal = MissionsAPI.GetQuestPoints( missionId, "goal" );

		                                                                                                           
		return {
			missionId: missionId,
			missionItemId: InventoryAPI.GetQuestItemIDFromQuestID( missionId ),
			missionName: InventoryAPI.GetItemName( MissionItemID ),
			missionDesc: MissionsAPI.GetQuestDefinitionField( missionId, "loc_description" ),
			nMissionSegments: MissionsAPI.GetQuestPoints( missionId, 'count' ),
			nMissionPointsRemaining: MissionsAPI.GetQuestPoints( missionId, "remaining" ),
			nOpPointsPerSegment: MissionsAPI.GetQuestDefinitionField( missionId, 'operational_points' ),
			isReplayable: ( gameMode === 'cooperative' || gameMode === 'coopmission' ),
			isSingleMatch: MissionsAPI.GetQuestDefinitionField( missionId, "singlematch" ) === '1' ? true : false,
			missionGoal: MissionsAPI.GetQuestPoints( missionId, "goal" ),
			nUncommitted: MissionsAPI.GetQuestPoints( missionId, "uncommitted" ),
			missionGameMode: gameMode,
			missionMapGroup: mapGroup,
			missonType: numQuestGraphType === 1 ? 'sequential' :
				numQuestGraphType === 2 && missionGoal > 1 ? 'checklist' :
					numQuestGraphType === 2 && missionGoal === 1 ? 'or' :
						numQuestGraphType === 0 ? 'single' :
							''
		}
	};

	var _SetLocalizationStringAndVarsForMission = function( elMissionPanel, nQuestID, strSchemaField )
	{
		MissionsAPI.ApplyQuestDialogVarsToPanelJS( nQuestID, elMissionPanel );
		elMissionPanel.SetLocalizationString( MissionsAPI.GetQuestDefinitionField( nQuestID, strSchemaField ) );
	};

	var _UpdateSegmentData = function( oMissionDetails )
	{
		var aSegmentsData = [];
		var nGoalsAlreadyDisplayed = 0;
		var nPreviousGoal = 0;
		for ( var i = oMissionDetails.nMissionSegments; i-- > 0; )
		{
			var nGoal = MissionsAPI.GetQuestPoints( oMissionDetails.missionId, 'goal' + i );
			var nEarned = oMissionDetails.missionGoal - oMissionDetails.nMissionPointsRemaining;
			var nSegmentIncrementalGoalDelta = nGoal - nGoalsAlreadyDisplayed;
			var nSegmentEarned = nEarned - nGoalsAlreadyDisplayed;
			if ( nSegmentEarned < 0 )
			{
				nSegmentEarned = 0;
			}

			if ( nSegmentEarned > nSegmentIncrementalGoalDelta ) 
			{
				nSegmentEarned = nSegmentIncrementalGoalDelta;
			}

			nGoalsAlreadyDisplayed = nGoal;
			                                     
			var progressPercent = ( nSegmentEarned / nSegmentIncrementalGoalDelta ) * 100;
			var oSegmentData = {};

			oSegmentData.nGoal = nGoal;
			oSegmentData.nEarned = nEarned;
			oSegmentData.nPercentComplete = progressPercent;
			                                                          
			oSegmentData.isComplete = oMissionDetails.nMissionPointsRemaining === 0 ?
				true :
				( nSegmentEarned === nSegmentIncrementalGoalDelta );
			oSegmentData.nSegmentEarned = nSegmentEarned;
			oSegmentData.nSegmentIncrementalGoalDelta = nSegmentIncrementalGoalDelta;
			oSegmentData.nPreviousGoal = nPreviousGoal;

			aSegmentsData.push( oSegmentData );
			nPreviousGoal = nGoal;
		}

		return aSegmentsData;
	};

	var _UpdateSubQuestData = function( missionId, numGraphCount, isChecklist )
	{
		var aSubQuests = [];
		for ( var i = 0; i < numGraphCount; ++i )
		{
			var submissionId = MissionsAPI.GetQuestGraphEntry( missionId, i );
			var nGoal = MissionsAPI.GetQuestPoints( submissionId, 'goal' );
			var nRemaining = MissionsAPI.GetQuestPoints( submissionId, "remaining" );
			var nUncommitted = MissionsAPI.GetQuestPoints( submissionId, "uncommitted" );
			var nEarned = nGoal - nRemaining;
			var oData = {
				missionId: submissionId,
				nGoal: MissionsAPI.GetQuestPoints( submissionId, "goal" ),
				nUncommitted: nUncommitted,
				nEarned: nEarned,
				nsubQuestPointsRemaining: nRemaining,
				isComplete: nRemaining === 0 ?
				true : ( nEarned === nGoal ),
				nPercentComplete: nRemaining === 0 ? 100 : ( nEarned / nGoal ) * 100,
				nPercentCompleteUncommitted: nUncommitted === 0 || !nUncommitted ? 0 : ( nUncommitted / nGoal ) * 100,
			}
			aSubQuests.push( oData );
		}

		if( isChecklist )
		{
			                                                   
			return aSubQuests.sort((a, b) => {
				return ( b.nPercentComplete - a.nPercentComplete ) || ( b.nPercentCompleteUncommitted - a.nPercentCompleteUncommitted ) ;
			});
		}

		return aSubQuests;
	};

	var _GetMissionCardEarnedPoints = function( oCardDetails )
	{
		var totalCardPoints = 0;
		var totalPossilbePoints = 0;

		for ( var iMission = 0; iMission< oCardDetails.quests.length; iMission++ )
		{
			var missionID = oCardDetails.quests[ iMission];
			var numThresholds = MissionsAPI.GetQuestPoints( missionID, "count" );
			var goal = MissionsAPI.GetQuestPoints( missionID, "goal" );
			var remaining = MissionsAPI.GetQuestPoints( missionID, "remaining" );
			if ( remaining > 0 )
			{
				var numLoops = numThresholds;
				for ( var i = 0; i < numLoops; ++ i )
				{
					if ( ( goal - remaining ) < MissionsAPI.GetQuestPoints( missionID, "goal" + i ) )
						-- numThresholds;
					else
						break;
				}
			}
			totalCardPoints += parseInt( MissionsAPI.GetQuestDefinitionField( missionID, 'operational_points' ) ) * numThresholds;
			totalPossilbePoints += MissionsAPI.GetQuestDefinitionField( missionID, 'operational_points' ) * MissionsAPI.GetQuestPoints( missionID, 'count' );
		}

		var oPoints = {
			totalCardPoints: totalCardPoints,
			totalCardPointsDisplay : totalCardPoints > oCardDetails.operational_points ? oCardDetails.operational_points : totalCardPoints,
			totalPossilbePoints: totalPossilbePoints
		};

		return oPoints;

		                                                                                                               
	}

	function _IfOperationEndedGetExtendedSeasonWithRedeemableBalance( bAlwaysShowOperationEndedMessageBox )
	{
		var nActiveSeason = 10;                                                                                                                   
		
		if ( bAlwaysShowOperationEndedMessageBox )
		{
			nActiveSeason = -1;
		}
		else
		{
			_ValidateOperationInfo( nActiveSeason );
			if ( m_numRedeemableBalance <= 0 )
				nActiveSeason = -1;
		}
			
		if ( nActiveSeason < 0 )
			UiToolkitAPI.ShowGenericPopup( '#op_stars_shop_title', '#op_stars_shop_operation_over', "" );
			
		return nActiveSeason;
	}

	function _OpenPopupCustomLayoutOperationHub ( rewardIdxToSetWhenOpen )
	{
		var nActiveSeason = GameTypesAPI.GetActiveSeasionIndexValue();
		if ( nActiveSeason < 0 )
			return;

		var elPanel = UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/operation/operation_main.xml',
			'none'
		);
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'tab_mainmenu_inventory', 'MOUSE' );

		elPanel.SetAttributeInt( "season_access", nActiveSeason );
		if ( rewardIdxToSetWhenOpen > -1 )
		{
			elPanel.SetAttributeInt( "start_reward", rewardIdxToSetWhenOpen );
		}
	}

	function _OpenPopupCustomLayoutOperationStore()
	{
		$.DispatchEvent( 'ContextMenuEvent', '' );

		var nActiveSeason = GameTypesAPI.GetActiveSeasionIndexValue();
		if ( nActiveSeason < 0 )
			nActiveSeason = _IfOperationEndedGetExtendedSeasonWithRedeemableBalance();

		if ( nActiveSeason < 0 )
			return;

		var elPanel = UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/operation/operation_store.xml',
			'none'
		);

		elPanel.SetAttributeInt( "season_access", nActiveSeason );
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'tab_mainmenu_inventory', 'MOUSE' );
	}

	function _OpenUpSell( starsNeeded = 0, bForceOpenStarsPurchase = false )
	{
		function _OpenStarStore()
		{
			var elPopup = UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/popups/popup_operation_store.xml',
				'bluroperationpanel=true',
				'none'
			);

			elPopup.SetAttributeInt( "starsneeded", starsNeeded );
			                                                              
			
			var oOldStarsActivate = _UpdateOldStars();
			                                                                                                                                                            
			if ( oOldStarsActivate.ids.length > 0 )
			{
				elPopup.SetAttributeString( "oldstarstoactivate", oOldStarsActivate.ids.join( ',' ) );
				elPopup.SetAttributeInt( "oldstarstoactivatevalue", oOldStarsActivate.value );
			}
		}

		function _OpenStoreForPass( passId )
		{
			if( passId )
			{
				UiToolkitAPI.ShowCustomLayoutPopupParameters(
					'',
					'file://{resources}/layout/popups/popup_inventory_inspect.xml',
					'itemid=' + passId +
					'&' + 'asyncworktype=useitem' + 
					'&' + 'seasonpass=true' +
					'&' + 'bluroperationpanel=true'
				);
				return;
			}
			
			var passDefIndex = _GetPassFauxId();
			UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/popups/popup_inventory_inspect.xml',
				'itemid=' + passDefIndex +
				'&' + 'inspectonly=false' +
				'&' + 'asyncworkitemwarning=no' +
				'&' + 'bluroperationpanel=true' +
				'&' + 'storeitemid=' + passDefIndex +
				'&' + 'overridepurchasemultiple=0',
				'none'
			);

			                                                               
			                                                    
			var nSourceLayoutId = 0;
			var strSourceLayoutFile = $.GetContextPanel().layoutfile;
			if ( strSourceLayoutFile.endsWith( "operation_mainmenu.xml" ) )
			{
				nSourceLayoutId = 1; 
			}
			else if ( strSourceLayoutFile.endsWith( "operation_main.xml" ) )
			{
				nSourceLayoutId = 2; 
			}
			StoreAPI.RecordUIEvent( "OperationJournal_Purchase", nSourceLayoutId );
		}

		$.DispatchEvent( 'CSGOPlaySoundEffect', 'tab_mainmenu_inventory', 'MOUSE' );

		                                                
		var nActiveSeason = GameTypesAPI.GetActiveSeasionIndexValue();
		if ( nActiveSeason < 0 )
		{
			_IfOperationEndedGetExtendedSeasonWithRedeemableBalance( true );
			return;
		}

		var passId = InventoryAPI.GetActiveSeasonPassItemId();

		if ( m_bPremiumUser || bForceOpenStarsPurchase )
		{
			_OpenStarStore();
		}
		else
		{
			_OpenStoreForPass( passId );
		}
	}

	var _GetPassFauxId = function()
	{
		return  InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( m_passStoreId, 0 );
	};

	var _GetCoinDefIdxArray = function()
	{
		return m_aCoinDefIndexes;
	}

	var _GetOperationStarDefIdxArray = function()
	{
		return m_aStarDefIndexes;
	}

	var _UpdateOldStars = function()
	{
		var oDefNames = [ {},{},{} ];
		oDefNames[0] = {def:InventoryAPI.GetItemDefinitionName(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( m_aStarDefIndexes[0], 0 )),value:1};
		oDefNames[1] = {def:InventoryAPI.GetItemDefinitionName(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( m_aStarDefIndexes[1], 0 )),value:10};
		oDefNames[2] = {def:InventoryAPI.GetItemDefinitionName(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( m_aStarDefIndexes[2], 0 )),value:100};

		var oTotalStars = { ids: [], value: 0 };
		oDefNames.forEach( element =>
		{
			InventoryAPI.SetInventorySortAndFilters( 'inv_sort_age', false, 'item_definition:' + element.def, '', '' );
			var count = InventoryAPI.GetInventoryCount();
			for ( var i = 0; i < count; i++ )
			{
				oTotalStars.ids.push( InventoryAPI.GetInventoryItemIDByIndex( i ) );
				oTotalStars.value += element.value;
			}
		} );

		return oTotalStars;
	};
	
	var gameElementDetails = {
		exojump: {
			icon: "file://{images}/icons/ui/exojump_hud.svg",
			name: "Survival_SpawnEquip_exojump",
			tooltip: ""
		},
		breachcharge: {
			icon: "file://{images}/icons/equipment/breachcharge.svg",
			name: "SFUI_WPNHUD_BreachCharge",
			tooltip: ""
		},
		parachute: {
			icon: "file://{images}/icons/ui/parachute.svg",
			name: "Survival_SpawnEquip_parachute",
			tooltip: ""
		},
		bumpmine: {
			icon: "file://{images}/icons/equipment/bumpmine.svg",
			name: "SFUI_WPNHUD_BumpMine",
			tooltip: ""
		},
	};

	var _MissionsThatMatchYourMatchMakingSettings = function( SessionGameMode, sessionMaps, nSeasonAccess )
	{
		                                                                                              

		var numMissionCards = MissionsAPI.GetSeasonalOperationMissionCardsCount( nSeasonAccess );
		for ( var i = 0; i < numMissionCards; ++ i )
		{
			var jsoCardDetails = MissionsAPI.GetSeasonalOperationMissionCardDetails( nSeasonAccess, i );
			_GetMatchingMission( i, jsoCardDetails, SessionGameMode, sessionMaps );
		}
	};

	var _GetMatchingMission = function( idx, jsoCardDetails, SessionGameMode, sessionMaps )
	{
		var oMatchingMissions = {};
		for ( var iMission = 0; iMission < jsoCardDetails.quests.length; ++iMission )
		{
			var MissionItemID = InventoryAPI.GetQuestItemIDFromQuestID( Number( jsoCardDetails.quests[ iMission ] ) );
			var gameMode = InventoryAPI.GetQuestGameMode( MissionItemID );
			var mapGroup = InventoryAPI.GetQuestMapGroup( MissionItemID );

			if ( !mapGroup )
			{	                                                                               
				mapGroup = 'mg_' + InventoryAPI.GetQuestMap( MissionItemID );
			}

			if ( SessionGameMode === gameMode &&
				_HasMatchtingMapGroup( sessionMaps, mapGroup ) &&
				jsoCardDetails.isunlocked &&
				MissionsAPI.GetQuestPoints( jsoCardDetails.quests[ iMission ], "remaining" ) === 0 )
			{
				if ( !oMatchingMissions.hasOwnProperty( 'card' + idx ) )
				{
					oMatchingMissions[ 'card' + idx ] = idx;
					oMatchingMissions.missions = [];
				}
				
				oMatchingMissions.missions.push( MissionItemID );
			}
		}

		return oMatchingMissions;
	};

	var _IsMissionLockedBehindPremiumOperationPass = function( missionCardId, MissionItemID, nSeasonAccess )
	{
		                                     
		return false;

		                                                                                          
		var gameMode = InventoryAPI.GetQuestGameMode( MissionItemID );
		if ( gameMode !== 'competitive' )
			return false;

		var mapGroup = InventoryAPI.GetQuestMapGroup( MissionItemID );
		if ( !mapGroup )
		{
			mapGroup = 'mg_' + InventoryAPI.GetQuestMap( MissionItemID );
		}
		if ( mapGroup !== 'mg_lobby_mapveto' )
			return false;

		                                                    
		if ( _ValidateOperationInfo( nSeasonAccess ) && m_bPremiumUser )
			return false;
		
		return true;
	}

	var _HasMatchtingMapGroup = function( sessionMaps, mapGroup )
	{
		return sessionMaps.filter( element => mapGroup.includes( element ) ).length > 0 ? true : false;
	};

	                                                                                           
	var _GetQuestGameElements = function( questID )
	{
		return MissionsAPI.GetQuestGameElements( questID ).map( elem => gameElementDetails[ elem ] );
	};

	var _HasStoreItems = function ( )
	{
		return m_nRedeemableGoodsCount > 0 && m_nRedeemableGoodsCount !== null && m_nRedeemableGoodsCount != undefined ? true : false;
	};

	var _UnblurMenu = function( elPanel )
	{
		elPanel.SetHasClass( 'blur', false );
	};

	var _BlurMenu = function( elPanel)
	{
		elPanel.SetHasClass( 'blur', true );
	};

	var _ValidateCoinAndSeasonIndex = function( nSeasonAccess, nCoinRank )
	{
		if ( nSeasonAccess === -1 ||
			!nSeasonAccess ||
			nCoinRank === -1 ||
			nCoinRank === undefined ||
			nCoinRank === null )
		{
			return false;
		}

		return true;
	};


	var _GetOperationInfo = function()
	{
		return {
			nSeasonAccess: m_nSeasonAccess,
			nTierUnlocked: m_numTierUnlocked,
			nRewardsCount: m_nRewardsCount,
			bShopIsFreeForAll: false,
			nRedeemableGoodsCount: m_nRedeemableGoodsCount,
			nRedeemableBalance : m_numRedeemableBalance,
			nMissionsCompleted: m_numMissionsCompleted,
			nMissionsRewardThresholds: m_numMissionsRewardThresholds,
			bPremiumUser: m_bPremiumUser,
			nCoinRank: m_nCoinRank,
			nActiveCardIndex: m_nActiveCardIndex,
			bPrime: m_bPrime
		};
	};

	return {
		ValidateOperationInfo: _ValidateOperationInfo,
		ValidateCoinAndSeasonIndex: _ValidateCoinAndSeasonIndex,
		GetOperationInfo: _GetOperationInfo,
		GetRewardsData: _GetRewardsData,
		GetLootListForReward: _GetLootListForReward,
		OpenPopupCustomLayoutOperationHub: _OpenPopupCustomLayoutOperationHub,
		OpenPopupCustomLayoutOperationStore: _OpenPopupCustomLayoutOperationStore,
		IsMissionLockedBehindPremiumOperationPass: _IsMissionLockedBehindPremiumOperationPass,
		OpenUpSell: _OpenUpSell,
		GetQuestGameElements: _GetQuestGameElements,
		UpdateOldStars: _UpdateOldStars,
		GetPassFauxId: _GetPassFauxId,
		GetCoinDefIdxArray : _GetCoinDefIdxArray,
		GetOperationStarDefIdxArray: _GetOperationStarDefIdxArray,
		GettotalPointsFromAvailableFromMissions: _GettotalPointsFromAvailableFromMissions,
		MissionsThatMatchYourMatchMakingSettings: _MissionsThatMatchYourMatchMakingSettings,
		BlurMenu: _BlurMenu,
		UnblurMenu: _UnblurMenu,
		SetLocalizationStringAndVarsForMission: _SetLocalizationStringAndVarsForMission,
		GetMissionDetails: _GetMissionDetails,
		GetMissionCardEarnedPoints: _GetMissionCardEarnedPoints,
	};

})();
