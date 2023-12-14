'use strict';


var OperationMain = ( function() 
{
	var _m_cp = $.GetContextPanel();
	var _m_nSeasonAccess;
	var _m_oProgressFlipModule = null;
	var _m_oNamesFlipModuleInspect = null;
	var _m_activeRewardBtn = null;
	const SECTIONS_IN_BAR = 100;

	var _Init = function()
	{
		_SetUpFlipAnimForProgressBar();
		_SetUpFlipAnimForInspect();
		_CheckUsersOperationStatus();

		                                     
		if ( OperationUtil.UpdateOldStars().ids.length > 0 )
		{
			$.Schedule( .3, OperationUtil.OpenUpSell );
		}
		StoreAPI.RecordUIEvent( "OperationJournal_View" );
	};

	var _CheckUsersOperationStatus = function()
	{
		_m_nSeasonAccess = $.GetContextPanel().GetAttributeInt( "season_access", 0 );

		OperationUtil.ValidateOperationInfo( _m_nSeasonAccess );
		var oStatus = OperationUtil.GetOperationInfo();

		if ( _m_nSeasonAccess === -1 ||
			!_m_nSeasonAccess ||
			oStatus.nCoinRank === -1 ||
			oStatus.nCoinRank === undefined ||
			oStatus.nCoinRank === null )
		{
			return;
		}

		_m_activeRewardBtn = null;
		_SetupHeader( oStatus );

		var indexToOpenTo = _m_cp.GetAttributeInt( "start_reward", -1 );
		                                                                                   
		_m_cp.SetAttributeInt( "start_reward", -1 );

		                                         
		_UpdateDefaultProgressData( oStatus, indexToOpenTo );

		                        
		_UpdateRewardTiles();

		var elVisibleBar = _m_oProgressFlipModule.DetermineVisiblePanel(
			_m_oProgressFlipModule.oData.animPanelA,
			_m_oProgressFlipModule.oData.animPanelB
		);

		                                                         
		_UpdateProgressBarSections( _m_oProgressFlipModule.oData, elVisibleBar );
		
		                                                                    
		var oRewardToHighlight = _GetRewardToHighlight( indexToOpenTo );

		                                                                 
		_UpdateRewardsOnProgressBar( elVisibleBar, oRewardToHighlight );
		
		var aChildren = elVisibleBar.FindChildInLayoutFile( 'op-main-progressbar-rewards' ).Children();
		                        

		_m_activeRewardBtn = aChildren.filter( element =>
			element.Data().oReward.itempremium.ids[ 0 ] === oRewardToHighlight.itempremium.ids[ 0 ] &&
			element.Data().oReward.idx === oRewardToHighlight.idx
		)[ 0 ];
		
		_SetActiveReward( _m_activeRewardBtn );
		_ShowPurchaseSpecificStarsBtn();
		_SetCheckedMatchingTile();

		                                                                                                                    
		$.Schedule( 0.3, _UpdateInspectPanel );
		_SetPurchaseBtn();
	};

	var _SetupHeader = function( oStatus )
	{
		if ( oStatus.bPremiumUser )
		{
			$.GetContextPanel().SetDialogVariableInt( 'total_value', oStatus.nTierUnlocked );
		}

		$.GetContextPanel().FindChildInLayoutFile( 'id-op-main-header' ).visible = oStatus.bPremiumUser;
		$.GetContextPanel().FindChildInLayoutFile( 'id-op-main-header-preview' ).visible = !oStatus.bPremiumUser;
	};

	var _SetPurchaseBtn = function( )
	{
		var elUpSell = $.GetContextPanel().FindChildInLayoutFile( 'op-main-upsell' );

		var bPremiumUser = OperationUtil.GetOperationInfo().bPremiumUser;
		var sUserOwnedOperationPassItemID = InventoryAPI.GetActiveSeasonPassItemId();
		var sFauxPassItemID = OperationUtil.GetPassFauxId();

		elUpSell.FindChildInLayoutFile( 'op-main-upsell-label' ).text = $.Localize( bPremiumUser ?
			'#op_get_more_stars' : sUserOwnedOperationPassItemID ? 
			'#SFUI_ConfirmBtn_ActivatePassNow' : '#op_get_premium'
			).toUpperCase();

		var imgPath = bPremiumUser ?
			'file://{images}/icons/ui/shoppingcart.svg' :
			'file://{images}/icons/ui/ticket.svg';
		
		elUpSell.FindChildInLayoutFile( 'op-main-upsell-image' ).SetImage( imgPath );
		elUpSell.SetPanelEvent( 'onactivate', OperationUtil.OpenUpSell.bind( undefined ) );

		  
		                               
		  
		var elPassSaleDiscount = elUpSell.FindChildInLayoutFile( 'id-op-reward-open-operation-hub-passsalediscount' );
		elPassSaleDiscount.visible = ( !bPremiumUser && sUserOwnedOperationPassItemID ) ? false : true;
		var sPctReduction = StoreAPI.GetStoreItemPercentReduction( sFauxPassItemID );
		if ( bPremiumUser )
		{
			sPctReduction = '';
			var minDiscount, maxDiscount;
			var storeids = OperationUtil.GetOperationStarDefIdxArray();
			storeids.forEach( function( defIndex )
			{
				var sPctReductionPerStar = StoreAPI.GetStoreItemPercentReduction(
					InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( defIndex, 0 )
					);
				if ( sPctReductionPerStar && sPctReductionPerStar !== '-0%' )
				{
					var numericStarDiscount = parseInt( sPctReductionPerStar );
					if ( sPctReduction )
					{
						sPctReduction += ' / ';
					}
					else
					{
						minDiscount = numericStarDiscount;
						maxDiscount = numericStarDiscount;
					}
					sPctReduction += sPctReductionPerStar;

					if ( numericStarDiscount < minDiscount ) minDiscount = numericStarDiscount;
					if ( numericStarDiscount > maxDiscount ) maxDiscount = numericStarDiscount;
				}
			} );
			
			if ( sPctReduction )
			{
				elPassSaleDiscount.SetDialogVariable( 'salediscount', ''+minDiscount+'%' );
				sPctReduction = $.Localize( '#Store_Price_UpToSale', elPassSaleDiscount ).toUpperCase();
			}
		}
		if ( sPctReduction && sPctReduction !== '-0%' )
			elPassSaleDiscount.text = sPctReduction;
		else
			elPassSaleDiscount.visible = false;
	};

	var _UpdateDefaultProgressData = function( oStatus, openToRewardIndex )
	{
		var oCallbackData = {
			nTierUnlocked: oStatus.nTierUnlocked,
			sectionStart: 0,
			sectionEnd: 0
		};

		                                    
		                                                
		                                                         
		var activeIndex = openToRewardIndex > -1 ? Math.floor( openToRewardIndex / SECTIONS_IN_BAR ) : Math.floor( oStatus.nTierUnlocked / SECTIONS_IN_BAR );
		_m_oProgressFlipModule.CallbackData = oCallbackData;
		_m_oProgressFlipModule.ActiveIndex = activeIndex;
		_m_oProgressFlipModule.AddParamToCallbackData( 'maxIndex', activeIndex );
		_m_oProgressFlipModule.AddParamToCallbackData( 'sectionStart', ( SECTIONS_IN_BAR * activeIndex ) );
		_m_oProgressFlipModule.AddParamToCallbackData( 'sectionEnd', ( SECTIONS_IN_BAR * activeIndex ) + SECTIONS_IN_BAR );

		_UpdateProgressBarEnableDisable( _m_oProgressFlipModule.oData );
		
		                                                                  
		                                        
	};

	                        
	                        
	                        
	var _UpdateRewardTiles = function(  )
	{
		var aTiles = _GetRewardsForTiles();

		if ( aTiles.length < 1 )
		{
			return;
		}

		function GetPanel ( idPrefix, modifier, elParent, panelType, snippetToLoad = '' )
		{
			var elPanel = elParent.FindChildInLayoutFile( idPrefix + modifier );
			if ( !elPanel )
			{
				elPanel = $.CreatePanel( panelType, elParent, idPrefix + modifier );

				if ( snippetToLoad )
				{
					elPanel.BLoadLayoutSnippet( snippetToLoad );
				}
			}
			
			return elPanel;
		}
		var elParent = _m_cp.FindChildInLayoutFile( 'id-op-rewards-list' );
		                                                                      
		var currentRow = 0;
		var maxTiles = 12;
		var numTileRow = 0;

		for ( var i = 0; i < maxTiles; i++ )
		{
			                                                            
			numTileRow = aTiles[ i ] ? parseInt( aTiles[ i ].rewardsData[ 0 ].uiOrder ) : numTileRow;
			if( numTileRow !== currentRow )
			{
				currentRow = numTileRow;
				var elTitle  = GetPanel( 'id-op-rewards-section-', currentRow, elParent, 'Label' );
				elTitle.text = $.Localize( '#op_rewards_section_'+ currentRow );
				elTitle.AddClass( 'op-main-progress__title' );

				var elRow = GetPanel( 'id-op-rewards-row-', currentRow, elParent, 'Panel' );
				elRow.AddClass( 'op-main-rewards_row' );
			}

			var elTile = GetPanel( 'id-op-rewards-list-tile-', i, elRow, 'RadioButton', 'reward-tile' );

			if( i >= aTiles.length)
			{
				elTile.SetHasClass( 'hidden', true );
				if( elTile.checked )
				{
					elTile.checked = false;
				}
				return;
			}

			elTile.SetHasClass( 'hidden', false );
			if ( aTiles[ i ].rewardsData[ 0 ].imagePath )
			{
				elTile.FindChildInLayoutFile( 'id-op-reward-image' ).SetImage( 'file://{images}' + aTiles[ i ].rewardsData[ 0 ].imagePath + '.png' );
			}
			else
			{
				elTile.FindChildInLayoutFile( 'id-op-reward-image' ).itemid = aTiles[ i ].rewardId;
			}

			elTile.SetHasClass( 'small', currentRow !== 1 );
			elTile.FindChildInLayoutFile( 'id-op-reward-name' ).text = InventoryAPI.GetItemName( aTiles[ i ].rewardId );
			                                                                                                 

			                                                                                                                                
			elTile.Data().oReward = aTiles[ i ].rewardsData[ 0 ];
			elTile.Data().showSingleReward = aTiles[ i ].rewardsData.length === 1 ? true : false;
			elTile.Data().nCategoryButtonIdx = i;                                                                                                                         
			elTile.SetPanelEvent( 'onactivate', _OnSelectReward.bind( undefined, elTile ) );

			_CacheWeaponMouseOver( elTile, aTiles[ i ].rewardId  );
		}
	};

	var _GetRewardsForTiles = function()
	{
		var aRewards = OperationUtil.GetRewardsData();
		var aTiles = [];

		for ( var i = _m_oProgressFlipModule.oData.oCallbackData.sectionStart;
			i < _m_oProgressFlipModule.oData.oCallbackData.sectionEnd;
			i++ )
		{
			if ( aRewards[ i ].isGap !== "none" )
			{
				var rewardId = aRewards[ i ].itempremium.ids[ 0 ];

				                                                                     

				if ( !aTiles.find( tile =>
				{
					return tile[ 'rewardId' ] && ( tile[ 'rewardId' ] === rewardId ) ? true : false;
				} ) )
				{
					aTiles.push( {
						rewardId: rewardId,
						rewardsData: aRewards.filter( reward =>
							( reward.idx >= _m_oProgressFlipModule.oData.oCallbackData.sectionStart &&
							reward.idx <= _m_oProgressFlipModule.oData.oCallbackData.sectionEnd ) &&
							reward.itempremium.ids[ 0 ] === rewardId )
					} );
				}
			}
		}
		aTiles.sort( function( a, b ) { return parseInt( a.rewardsData[ 0 ].uiOrder ) - parseInt( b.rewardsData[ 0 ].uiOrder ); } );
		return aTiles;
	};

	                        
	                        
	                       
	var _SetUpFlipAnimForProgressBar = function()
	{
		_m_oProgressFlipModule = new FlipPanelAnimation.Constructor( {
			controlBtnPrev: _m_cp.FindChildInLayoutFile( 'id-op-progress-prev' ),
			controlBtnNext: _m_cp.FindChildInLayoutFile( 'id-op-progress-next' ),
			animPanelA: _m_cp.FindChildInLayoutFile( 'id-op-progressbar-1' ),
			animPanelB: _m_cp.FindChildInLayoutFile( 'id-op-progressbar-2' ),
			parentPanel: _m_cp.FindChildInLayoutFile( 'id-op-progressbars' ),
			funcCallback: _UpdateProgressBarDisplay,
			activeIndex: 0,
			oCallbackData: null
		} );
		
		_m_oProgressFlipModule[ 'ControlBtnActions' ]();

		_TransitionEvent( _m_cp.FindChildInLayoutFile( 'id-op-progressbar-1' ) );
		_TransitionEvent( _m_cp.FindChildInLayoutFile( 'id-op-progressbar-2' ) );
	};

	var _TransitionEvent = function( elBar )
	{
			elBar.OnPropertyTransitionEndEvent = function( panelName, propertyName )
			{

				if ( elBar.id === panelName && propertyName === 'transform' )
				{
					                                
					                                        
					if ( !elBar.BIsTransparent() &&
						( elBar.BHasClass( 'flip-panel-anim-up-show' ) || elBar.BHasClass( 'flip-panel-anim-down-show' ) ) )
					{
						_UpdateRewardTiles();
						_ShowPurchaseSpecificStarsBtn();

						var aChildren = _m_cp.FindChildInLayoutFile( 'id-op-rewards-list' ).FindChildrenWithClassTraverse( 'op-main-reward' );
						var aSelected = aChildren.filter( element => element.checked );

						                                                                         
						_m_activeRewardBtn = aSelected.length < 1 ? aChildren[ 0 ] : aSelected[ 0 ];
						_SetActiveReward( _m_activeRewardBtn );
						_SetCheckedMatchingTile();
						_UpdateRewardsOnProgressBar( elBar );
			
						                                                                                                                    
						_UpdateInspectPanel();
					}
				}

				if ( elBar.id === panelName && propertyName === 'opacity' )
				{
					                                       
					if ( elBar.visible === true && elBar.BIsTransparent() )
					{
						_HideRewardsOnProgressBar( elBar );
					}
				}
				return false;
			};

			$.RegisterEventHandler( 'PropertyTransitionEnd', elBar, elBar.OnPropertyTransitionEndEvent );
	};

	                   
	                   
	                   
	var _UpdateProgressBarDisplay = function( oData, isPrev = false )
	{
		function UpdateData( oData )
		{
			oData.oCallbackData.sectionStart = ( SECTIONS_IN_BAR *  oData.activeIndex );
			oData.oCallbackData.sectionEnd = ( SECTIONS_IN_BAR * oData.activeIndex ) + SECTIONS_IN_BAR;

			var NextPanel = _m_oProgressFlipModule.DetermineHiddenPanel( oData.animPanelA, oData.animPanelB );

			                   
			_m_activeRewardBtn = null;
			_UpdateProgressBarSections( oData, NextPanel );
		}
		
		if ( isPrev )
		{
			--oData.activeIndex;
			UpdateData( oData );
			_m_oProgressFlipModule.BtnPressPrevAnim( oData.animPanelA, oData.animPanelB );
		}
		else
		{
			++oData.activeIndex;
			UpdateData( oData );
			_m_oProgressFlipModule.BtnPressNextAnim( oData.animPanelA, oData.animPanelB );
		}
		_UpdateProgressBarEnableDisable( oData )
	};

	var _UpdateProgressBarEnableDisable = function( oData )
	{
		oData.controlBtnPrev.enabled = oData.activeIndex > 0;
		oData.controlBtnNext.enabled = oData.activeIndex < oData.oCallbackData.maxIndex;

		                                                                         
		oData.controlBtnPrev.visible = oData.oCallbackData.nTierUnlocked >= 100;
		oData.controlBtnNext.visible = oData.oCallbackData.nTierUnlocked >= 100;
	};

	var _UpdateProgressBarSections = function( oData, elBarParent )
	{
		                                                                  
		                                        
		
		var elBar = elBarParent.FindChildInLayoutFile( 'op-main-progressbar-sections' );
		elBar.RemoveAndDeleteChildren();

		for ( var i = oData.oCallbackData.sectionStart; i <= oData.oCallbackData.sectionEnd; i++ )
		{
			var elSection = $.CreatePanel( "Panel", elBar, "bar-section-" + i );
			elSection.BLoadLayoutSnippet( "progressbar-section" );
			elSection.SetHasClass( 'op-main-progress__bar__inner--fill', i < oData.oCallbackData.nTierUnlocked );
		}
	};

	var _UpdateRewardsOnProgressBar = function( elBar, oRewardTohighlight = null )
	{
		var aGetRewardsInRange = _GetRewardsInRange();

		if ( !aGetRewardsInRange || aGetRewardsInRange.length < 1 )
		{
			return;
		}

		_UpdateRewardPanelsOnProgressBar( _GetRewardsInRange(), elBar, oRewardTohighlight );
	};

	var _HideRewardsOnProgressBar = function( elBar )
	{
		var elRewards = elBar.FindChildInLayoutFile( 'op-main-progressbar-rewards' );

		if ( elRewards )
		{
			elRewards.RemoveAndDeleteChildren();
		}
	};

	var _GetRewardToHighlight = function( rewardTohighlightIndex )
	{
		                                                                                         
		var oRewards = OperationUtil.GetRewardsData();
		var count = oRewards.length;

		if ( rewardTohighlightIndex > -1 )
		{
			return oRewards[ rewardTohighlightIndex ];
		}

		for ( var i = _m_oProgressFlipModule.oData.oCallbackData.nTierUnlocked; i < count; i++ )
		{
			if ( !oRewards[ i ].isUnlocked && !oRewards[ i ].isGap )
			{
				                                                            
				return oRewards[ i ];
			}
		}

		return undefined;
	};

	var _GetRewardsInRange = function()
	{
		var oAllRewards = OperationUtil.GetRewardsData();
		var aGetRewardsInRange = oAllRewards.filter( reward => !reward.isGap  &&
			( reward.idx >= _m_oProgressFlipModule.oData.oCallbackData.sectionStart &&
			reward.idx <= _m_oProgressFlipModule.oData.oCallbackData.sectionEnd ) 
		);
		
		return aGetRewardsInRange;
	};

	var _UpdateRewardPanelsOnProgressBar = function( aGetRewardsInRange, elBar, oRewardToHighlight = null )
	{
		var elRewardsPanel = elBar.FindChildInLayoutFile( "op-main-progressbar-rewards" );
		                                           

		aGetRewardsInRange.forEach(function( reward, index )
		{
			var elReward = elRewardsPanel.FindChildInLayoutFile( "bar-reward-" + reward.idx );
			var bPlayAnim = false;                                                   

			if ( !elReward )
			{
				var elReward = $.CreatePanel( "RadioButton", elRewardsPanel, "bar-reward-" + reward.idx, { group: 'bar-reward' } );
				elReward.BLoadLayoutSnippet( "progressbar-reward" );
				bPlayAnim = true;
				elReward.Data().showSingleReward = true;
				elReward.Data().oReward = reward;
			}

			                                                                                                          
			                                                       
			                                                                                          
			if( reward.idx !== elReward.Data().oReward.idx )
			{
				elReward.Data().oReward = reward;

				if( elReward.BHasClass( 'highlight' ) )
				{
					elReward.RemoveClass( 'highlight' );
				}
			}

			if ( reward.imagePathThumbnail )
			{
				elReward.FindChildInLayoutFile( 'id-op-progressbar-reward-image' ).SetImage( 'file://{images}' + reward.imagePathThumbnail + '.png' );
			}
			else
			{
				elReward.FindChildInLayoutFile( 'id-op-progressbar-reward-image' ).itemid = reward.itempremium.ids[ 0 ];
			}
	
			elReward.SetDialogVariableInt( 'reward_index', reward.idx + 1 );
			elReward.FindChildInLayoutFile( 'id-op-progressbar-reward-hitbox' ).SetPanelEvent(
				'onactivate',
				_OnSelectReward.bind(
					undefined,
					elReward,
					elBar
				) );
			
			var oAnimInfo = {
				panel: elReward,
				bar: elBar,
				idx: reward.idx,
				play_anim: bPlayAnim
			};

			_CacheWeaponMouseOver( elReward ,reward.itempremium.ids[ 0 ] );
			
			                                                                                           
			                                                                                                                             
			var rewardTohighlight = _m_activeRewardBtn ? _m_activeRewardBtn.Data().oReward : oRewardToHighlight;
			
			if ( rewardTohighlight )
			{
				if ( oRewardToHighlight || _m_activeRewardBtn.Data().showSingleReward )
				{
					elReward.SetHasClass( 'highlight',
						reward.idx === rewardTohighlight.idx
					);
				}
				else
				{
					elReward.SetHasClass( 'highlight',
						reward.itempremium.ids[ 0 ] === rewardTohighlight.itempremium.ids[ 0 ]
					);
				}
			}

			elReward.SetHasClass( 'claimed', reward.idx < _m_oProgressFlipModule.oData.oCallbackData.nTierUnlocked );

			if ( bPlayAnim )
			{
				$.Schedule( 0.25, _PositionRewardOnProgressBar.bind( undefined, oAnimInfo ) );
			}
		} );
	};

	var _PositionRewardOnProgressBar = function( oAnimInfo )
	{
		var elSectionsContainer = oAnimInfo.bar.FindChildInLayoutFile( "op-main-progressbar-sections" );
		var elSection = elSectionsContainer.FindChild( "bar-section-" + ( oAnimInfo.idx ));
		let pos = elSection.GetPositionWithinWindow();

		var widthOffset = -( Math.floor( oAnimInfo.panel.actuallayoutwidth / 2 ) - Math.floor( elSection.actuallayoutwidth / 2 ) ) /
			oAnimInfo.panel.actualuiscale_x;
		
		oAnimInfo.panel.style.x = (( pos.x / oAnimInfo.panel.actualuiscale_x ) + widthOffset ) + 'px;';

		if ( oAnimInfo.play_anim )
		{
			oAnimInfo.panel.TriggerClass( 'op-main-progress__bar__reward__show-anim' );
		}
	};

	                          
	                          
	                          
	var _OnSelectReward = function( elSelected, elBar = undefined, bTrackStats = true )
	{
		if ( _m_activeRewardBtn === elSelected )
		{
			return;
		}
		
		_SetActiveReward( elSelected );

		var visibleBar = elBar ?
			elBar : _m_oProgressFlipModule.DetermineVisiblePanel(
				_m_oProgressFlipModule.oData.animPanelA,
				_m_oProgressFlipModule.oData.animPanelB
			);

		_UpdateRewardsOnProgressBar( visibleBar );

		if ( _m_activeRewardBtn.Data().showSingleReward )
		{
			_SetCheckedMatchingTile();
		}

		_ShowPurchaseSpecificStarsBtn();
		
		                                                               
		$.Schedule( .3, _UpdateInspectPanel );

		                                               
		if ( bTrackStats )
		{
			if ( elSelected.Data().nCategoryButtonIdx !== undefined )
			{
				StoreAPI.RecordUIEvent( "OperationJournal_RewardTrackSelection_Category", elSelected.Data().nCategoryButtonIdx );
			}
			else
			{
				StoreAPI.RecordUIEvent( "OperationJournal_RewardTrackSelection_Individual", elSelected.Data().oReward.idx );
			}
		}
	};

	var _SetActiveReward = function( elSelected )
	{
		if ( _m_activeRewardBtn )
		{
			_m_activeRewardBtn.checked = false;
		}
		
		elSelected.checked = true;
		_m_activeRewardBtn = elSelected;
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE' );
	};

	var _SetCheckedMatchingTile = function()
	{
		var aChildren = _m_cp.FindChildInLayoutFile( 'id-op-rewards-list' ).FindChildrenWithClassTraverse( 'op-main-reward' );
		aChildren.forEach(element => {
			if (element.Data().oReward) {
				element.checked = element.Data().oReward.itempremium.ids[0] ===
					_m_activeRewardBtn.Data().oReward.itempremium.ids[0]
			}
		});
	};

	var _ShowPurchaseSpecificStarsBtn = function()
	{
		var elPurchaseBtn = _m_cp.FindChildInLayoutFile( 'id-op-rewards-upsell-stars-btn' );

		var bShow = _m_activeRewardBtn &&
			_m_activeRewardBtn.Data().showSingleReward && OperationUtil.GetOperationInfo().bPremiumUser &&
			( _m_activeRewardBtn.Data().oReward.idx >= OperationUtil.GetOperationInfo().nTierUnlocked );
		
		elPurchaseBtn.SetHasClass( 'hidden', !bShow );
		
		if ( bShow )
		{
			var starsNeeded = ( _m_activeRewardBtn.Data().oReward.idx + 1 ) - OperationUtil.GetOperationInfo().nTierUnlocked;
			elPurchaseBtn.SetDialogVariableInt( 'stars_needed', starsNeeded );
			elPurchaseBtn.TriggerClass( 'update' );
			elPurchaseBtn.SetPanelEvent( 'onactivate',
				OperationUtil.OpenUpSell.bind(
					undefined,
					starsNeeded
			) );
		}
	};

	                  
	                  
	                  
	var _UpdateInspectPanel = function()
	{
		if ( !_m_activeRewardBtn )
		{
			return;
		}

		_m_cp.FindChildInLayoutFile( 'id-op-main-inspect' ).SetHasClass( 'show', true );

		var rewardId = _m_activeRewardBtn.Data().oReward.itempremium.ids[ 0 ];
		_m_cp.FindChildInLayoutFile( 'id-op-reward-tag' ).SetHasClass( 'hidden', rewardId !== _GetRewardToHighlight().itempremium.ids[ 0 ] );

		var itemsList = [];
		var toolsKey = InventoryAPI.GetRawDefinitionKey( rewardId, "inv_container_and_tools" );
		var bIsCase = ( toolsKey === "weapon_case" );
		var bIsGraffiti = ( toolsKey === "graffiti_box" );
		var bIsCoin = ( InventoryAPI.GetRawDefinitionKey( rewardId, "item_type" ) === "operation_coin" );

		_m_activeRewardBtn.Data().bIsGraffiti = bIsGraffiti;
		_m_activeRewardBtn.Data().bIsCoin = bIsCoin;
		_UpdateWarning( bIsCoin, bIsCase );

		var btnPreviewCase = _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-preview-item' );
		if( bIsCase )
		{
			if( bIsCase )
			{
				btnPreviewCase.SetPanelEvent( 'onactivate', function()
				{
					UiToolkitAPI.ShowCustomLayoutPopupParameters(
						'',
						'file://{resources}/layout/popups/popup_capability_decodable.xml',
						'key-and-case=,' + rewardId +
						'&' + 'inspectonly=true' +
						'&' + 'asyncworktype=decodeable' +
						'&' + 'asyncworkbtnstyle=hidden' +
						'&' + 'bluroperationpanel=true'
					);
				});
				btnPreviewCase.SetPanelEvent( 'onmouseover', function()
				{	                                                                                                        
				});
			}
		}
		else
		{
			var count = ItemInfo.GetLootListCount( rewardId );
			
			if ( !count )
			{
				itemsList.push( rewardId );
			}
			else
			{
				for ( var i = 0; i < count; i++ )
				{
					itemsList.push( ItemInfo.GetLootListItemByIndex( rewardId , i ) );
				}
			}

			if( ItemInfo.IsCharacter( itemsList[0] )|| ItemInfo.IsWeapon( itemsList[0] ) )
			{
				var _getSelectedIdInLayoutChildrenRow = function() {
					var selectedId = '';
					var aPips = _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-rarity' ).Children();
					if( aPips.length > 0 )
					{
						selectedId = aPips[0].GetSelectedButton().Data().itemid;
					}
					return selectedId;
				};

				btnPreviewCase.SetPanelEvent( 'onactivate', function()
				{
					var selectedId = _getSelectedIdInLayoutChildrenRow();
					UiToolkitAPI.ShowCustomLayoutPopupParameters(
						'',
						'file://{resources}/layout/popups/popup_inventory_inspect.xml',
						'itemid=' + selectedId +
						'&' + 'inspectonly=true' +
						'&' + 'showequip=false' +
						'&' + 'allowsave=false' +
						'&' + 'bluroperationpanel=true' +
						'&' + 'showitemcert=false',
						'none'
					);
				});
				btnPreviewCase.SetPanelEvent( 'onmouseover', function()
				{
					var selectedId = _getSelectedIdInLayoutChildrenRow();
					var settingsForSelectedCharacter = ItemInfo.GetOrUpdateVanityCharacterSettings( selectedId );
					ItemInfo.PrecacheVanityCharacterSettings( settingsForSelectedCharacter );
				});
			}
		}

		btnPreviewCase.visible = bIsCase || ItemInfo.IsCharacter( itemsList[ 0 ] )|| ItemInfo.IsWeapon( itemsList[0] );

		_m_cp.SetDialogVariable(
			'reward_name',
			ItemInfo.GetName(
				rewardId
			));

		_m_activeRewardBtn.Data().bShowPips = ( !bIsCoin && !bIsGraffiti && !bIsCase );

		_MakePips( itemsList, rewardId );
		_UpdateInpsectNameFlipModule( itemsList, rewardId );
	};

	var _UpdateWarning = function( bIsCoin, bIsCase, rewardId  )
	{
		var elWarning = _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-warning' );
		var bHideWarning = bIsCase || ( bIsCoin && !OperationUtil.GetOperationInfo().bPremiumUser );
		elWarning.SetHasClass( 'hidden', bHideWarning );

		if ( bHideWarning )
		{
			return;
		}

		var warningText = '';
		if ( bIsCoin )
		{
			var id = InventoryAPI.GetActiveSeasonCoinItemId();
			var missionsThreshold = InventoryAPI.GetItemAttributeValue( id, 'upgrade threshold' );

			                                                                                  
			if ( !missionsThreshold || missionsThreshold < 0 || missionsThreshold > 1000 )
			{
				elWarning.SetHasClass( 'hidden', true );
				return;
			}

			var missionsRemaining = missionsThreshold - OperationUtil.GetOperationInfo().nMissionsCompleted;
			_m_cp.SetDialogVariableInt( 'missions_remaining', missionsRemaining );

			var missionText = missionsRemaining === 1 ? $.Localize( '#op_rewards_mission' ) : $.Localize( '#op_rewards_missions' );
			_m_cp.SetDialogVariable( 'mission_plural', missionText );
			warningText = $.Localize( '#op_rewards_inspect_coin_progress', _m_cp );
		}
		else
		{
			warningText = $.Localize( '#op_rewards_inspect_warning' );
		}

		elWarning.text = warningText;
	};

	var _MakePips = function( itemsList, rewardId )
	{
		var elPips = _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-rarity' );
		elPips.RemoveAndDeleteChildren();

		elPips.SetHasClass( 'hidden', ( !_m_activeRewardBtn.Data().bShowPips ) );
		if( !_m_activeRewardBtn.Data().bShowPips )
		{
			return;
		}

		itemsList.forEach( function( itemId, index )
		{
			var elPip = $.CreatePanel(
				"RadioButton",
				elPips,
				'id-tier-pip-' + itemId, {
					class: 'op-mission-reward__rarity__pip',
					group:'rewardPip'
				}
			);

			$.CreatePanel(
				"ItemImage",
				elPip,
				'', {
					itemid: itemId,
					scaling:"stretch-to-fit-y-preserve-aspect"
				}
			);

			$.CreatePanel(
				"Panel",
				elPip,
				'id-pip-rarity', {
					class:"op-mission-reward__rarity__pip__rarity"
				}
			);

			elPip.Data().itemid = itemId;

			if ( ( itemsList.length <= 1 ) )
			{
				elPip.visible = false;
			}

			elPip.SetPanelEvent( 'onactivate', _OnPipActivate.bind( undefined, itemId, rewardId, index, itemsList.length ) );

			var rarityColor = ( itemId === '0' && bIsCase ) ?
				'#ffd700' :
				ItemInfo.GetRarityColor( itemId );
		
			if ( ItemInfo.IsWeapon( itemId ) )
			{
				elPip.SetPanelEvent( 'onmouseover', _CacheWeapon.bind( undefined, itemId ) );
			}

			if ( rarityColor )
			{
				elPip.FindChild( 'id-pip-rarity' ).style.backgroundColor = rarityColor + ';';
			}
			elPip.checked = index === 0;
		} );
	};

	var _IsCase = function( rewardId )
	{
		return ItemInfo.ItemHasCapability( rewardId, 'decodable' ) &&
			InventoryAPI.GetAssociatedItemsCount( rewardId ) > 0 ?
			true :
			false;
	};

	var _OnPipActivate = function( itemId, rewardId, index )
	{
		if ( _m_oNamesFlipModuleInspect.ActiveIndex === index )
		{
			return;
		}
		
		_m_oNamesFlipModuleInspect.ActiveIndex = index - 1;
		_m_oNamesFlipModuleInspect.UseCallback();
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE' );
	};

	var _UpdateInpsectNameFlipModule = function( aItems, rewardId )
	{	
		_m_oNamesFlipModuleInspect.CallbackData = {
			items: aItems,
			rewardid: rewardId
		};

		_m_oNamesFlipModuleInspect.ActiveIndex = -1;
		_m_oNamesFlipModuleInspect.AddParamToCallbackData( 'maxIndex', aItems.length - 1 );
		_m_oNamesFlipModuleInspect.UseCallback();
	};

	var _SetUpFlipAnimForInspect = function()
	{	 	
		_m_oNamesFlipModuleInspect = new FlipPanelAnimation.Constructor( {
			controlBtnPrev: _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-prev' ),
			controlBtnNext: _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-next' ),
			animPanelA: _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-name-1' ),
			animPanelB: _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-name-2' ),
			parentPanel: _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-names' ),
			funcCallback: _UpdateInspectName,
			activeIndex: 0,
			oCallbackData: null
		} );
		
		_m_oNamesFlipModuleInspect[ 'ControlBtnActions' ]();
	};

	var _UpdateInspectName = function( oData, isPrev = false )
	{
		var activeTileId = _m_activeRewardBtn.Data().oReward.itempremium.ids[0];
		var bIsCase = _IsCase( activeTileId );

		function UpdateData( oData )
		{
			var NextPanel = _m_oNamesFlipModuleInspect.DetermineHiddenPanel( oData.animPanelA, oData.animPanelB );
			var displayItemId = '';

			if ( _m_activeRewardBtn.Data().bShowPips === false )
			{
				NextPanel.GetParent().visible = false;
			}
			else
			{
				displayItemId = bIsCase ? activeTileId : oData.oCallbackData.items[ oData.activeIndex ];
				NextPanel.GetParent().visible = true;
				NextPanel.SetDialogVariable( 'reward_item_name', ItemInfo.GetName( displayItemId ));
	
				var aPips = _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-rarity' ).Children();
				if( aPips.length > 0 )
				{
					aPips[ oData.activeIndex ].checked = true;
				}
			}

			_UpdateInspectModelPanelOrImage( displayItemId, oData.oCallbackData.rewardid );
		}
		
		if ( isPrev )
		{
			--oData.activeIndex;
			UpdateData( oData );
			_m_oNamesFlipModuleInspect.BtnPressPrevAnim( oData.animPanelA, oData.animPanelB );
			if ( oData.oCallbackData.items[ oData.activeIndex - 1 ] )
				_CacheWeapon( oData.oCallbackData.items[ oData.activeIndex - 1 ] );
		}
		else
		{
			++oData.activeIndex;
			UpdateData( oData );
			_m_oNamesFlipModuleInspect.BtnPressNextAnim( oData.animPanelA, oData.animPanelB );
			if ( oData.oCallbackData.items[ oData.activeIndex + 1 ] )
				_CacheWeapon( oData.oCallbackData.items[ oData.activeIndex + 1 ] );
		}

		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.generic_button_press', 'MOUSE' );

		oData.controlBtnPrev.visible = _m_activeRewardBtn.Data().bShowPips;
		oData.controlBtnNext.visible = _m_activeRewardBtn.Data().bShowPips;
		oData.controlBtnPrev.enabled = oData.activeIndex > 0;
		oData.controlBtnNext.enabled = oData.activeIndex < oData.oCallbackData.maxIndex;

		if( oData.oCallbackData.items[ oData.activeIndex + 1 ])
		{
			_CacheWeaponMouseOver( oData.controlBtnNext, oData.oCallbackData.items[ oData.activeIndex + 1 ], true );
		}

		if( oData.oCallbackData.items[ oData.activeIndex - 1 ])
		{
			_CacheWeaponMouseOver( oData.controlBtnPrev, oData.oCallbackData.items[ oData.activeIndex - 1 ], true );
		}
	};
	
	function _UpdateInspectModelPanelOrImage ( itemId, rewardId )
	{
		var elModel = _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-model' );
		var elImage = _m_cp.FindChildInLayoutFile( 'id-op-main-inspect-image' );

		elModel.visible = false; 
		elImage.visible = false;
	
		var isCharacter = false;
		var displayItemId = '';
		if( _m_activeRewardBtn.Data().bIsCoin && OperationUtil.GetOperationInfo().bPremiumUser )
		{
			displayItemId = InventoryAPI.GetActiveSeasonCoinItemId();
		}
		else
		{
			displayItemId = ( !_m_activeRewardBtn.Data().bShowPips ) ? rewardId : itemId;
		}
		
		var model = ItemInfo.GetModelPathFromJSONOrAPI( displayItemId );
		if ( model && !_m_activeRewardBtn.Data().bIsGraffiti)
		{
			elModel.visible = true;
			elModel.SetScene( "resource/ui/econ/ItemModelPanelCharWeaponInspect.res",
				model,
				false
			);

			isCharacter = ItemInfo.IsCharacter( displayItemId );
			elModel.SetHasClass( 'character', isCharacter );

			if ( isCharacter )
			{
				var settings = ItemInfo.GetOrUpdateVanityCharacterSettings( displayItemId, 'unowned' );
				settings.panel = elModel;

				CharacterAnims.PlayAnimsOnPanel( settings );
				elModel.SetSceneIntroFOV( 1.6, 50000 );
				elModel.SetFlashlightColor( 4.16, 4.06, 5.20 );
				elModel.SetFlashlightFOV( 60 );
				                                            
		  		                                 
				elModel.SetDirectionalLightModify( 1 );
				elModel.SetDirectionalLightDirection( 66.83, -23.02, 121.82);
				elModel.SetDirectionalLightColor(0.29, 0.09, 0.63);
				elModel.SetAmbientLightColor( 0.17, 0.18, 0.36);
				elModel.SetCameraPosition(118.85, 0.41, 50.22);
				elModel.SetCameraAngles( 5.66, 179.31, 0.00 );
				
				          
				                                      
				                                                     
				                                                                        
			}
			else
			{
				elModel.SetSceneIntroFOV( 0.7, 50000  );
			}
		}
		else
		{
			elImage.visible = true;
			elImage.SetImage( 'file://{images}' + _m_activeRewardBtn.Data().oReward.imagePathInspect + '.png' );
		}
	}
	
	var _CacheWeapon = function( id )
	{
		InventoryAPI.PrecacheCustomMaterials( id );
	};

	var _CacheWeaponMouseOver = function( elTile, id, islootlistItem = false)
	{
		var count = 0;
		if( !islootlistItem )
		{
			count = ItemInfo.GetLootListCount( id );
		}

		if ( count > 0 || islootlistItem )
		{
			var lootListItem = islootlistItem ? id : ItemInfo.GetLootListItemByIndex( id, 0 );
			if( ItemInfo.IsWeapon( lootListItem ) )
			{
				elTile.SetPanelEvent( 'onmouseover', _CacheWeapon.bind( undefined, lootListItem ) );
			}
		}
	};

	return {
		Init: _Init,
		CheckUsersOperationStatus: _CheckUsersOperationStatus,
	};
} )();

(function () {

	$.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', OperationMain.CheckUsersOperationStatus );
	                                                                                                          
	                                                                                                      
})();

