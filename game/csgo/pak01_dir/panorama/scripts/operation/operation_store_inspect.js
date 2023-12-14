'use strict';

var OperationStoreInspect = ( function() 
{
	var _m_rewardId = '';
	var _m_aLootist= '';
	var _m_aLootlistGroups = undefined;
	var _m_rewardtype = '';
	var _m_rewardIndex = undefined;
	var _m_rewardCost = undefined;
	var _m_rewardFlags = undefined;
	var _m_cp = $.GetContextPanel();
	var _m_rewardImagePath = '';
	var _m_nSeasonAccess = 0;
	var _m_modelContainer = _m_cp.FindChildInLayoutFile( 'id-op-inspect-models-container' );
	var _m_recievedRewardId = '';
	
	var _Init = function()
	{
		                                                                                                                   
		_m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-more-points-btn_label' ).AddClass( 'op-store-progress__pass-upsell__text-btn');
		_m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-reward-btn_label' ).AddClass( 'op-store-progress__pass-upsell__text-btn');
		_m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-reward-btn_label' ).AddClass( 'op-store-progress__pass-upsell__text-btn--fit-children');

		_m_cp.FindChildInLayoutFile( 'id-store-inspect-loading' ).AddClass('hide');
		
		_m_nSeasonAccess =  Number( $.GetContextPanel().GetAttributeString( 'seasonaccess', null ) );

		OperationUtil.ValidateOperationInfo( _m_nSeasonAccess );
		var oStatus = OperationUtil.GetOperationInfo();
		
		                                                                                                     

		if( !OperationUtil.ValidateCoinAndSeasonIndex( _m_nSeasonAccess, oStatus.nCoinRank ) )
		{
			return;
		}

		                                                                                                                              
		var aRewards = OperationUtil.GetRewardsData();
		var oReward = aRewards.find(element => element.itempremium.ids[ 0 ] === $.GetContextPanel().GetAttributeString( "rewardid", null ) );
		if( !oReward)
		{
			return;
		}

		                                 
		_m_rewardId = oReward.itempremium.ids[ 0 ] ;
		_m_aLootist = oReward.lootlist;
		if ( oReward.lootlistGroups )
			_m_aLootlistGroups = oReward.lootlistGroups;

		_m_rewardtype = oReward.containerType;
		_m_rewardImagePath = oReward.imagePath;
		_m_rewardIndex = Number( oReward.idx );
		_m_rewardCost = oReward.points;
		_m_rewardFlags = oReward.flags;

		                                       

		                                                
		if( _m_rewardtype === "isCharacterLootlist" )
		{
			$.Schedule( 0.1, _SetUpCharModels);
			_m_cp.FindChildInLayoutFile( 'id-op-inspect-rewards-tray-container' ).SetHasClass( 'has-model-panel', true );
			_m_cp.FindChildInLayoutFile('id-op-store-inspect-floor').visible = true;
		}
		else if( _m_rewardtype === "isWeaponLootlist" || _m_rewardtype === "isStickerLootlist" || _m_rewardtype === "isGraffitiBox" )
		{
			_SetupItemTray();
			_m_modelContainer.SetHasClass( 'narrow', _m_rewardtype !== "isGraffitiBox");
			_m_modelContainer.SetHasClass( 'graffiti', _m_rewardtype == "isGraffitiBox");
			_m_cp.SetHasClass( 
				'single-line', 
				oReward.lootlist.length <= 8 );
			_m_cp.FindChildInLayoutFile('id-op-store-inspect-floor').visible = false;
		}
		else
		{
			_SetUpWeaponCaseModel();
			_SetupItemTray();
			_m_cp.FindChildInLayoutFile('id-op-store-inspect-floor').visible = false;
		}

		_UpdateTitle();
		_UpdateBtns();

		$.DispatchEvent( "CSGOPlaySoundEffect", "inventory_inspect_weapon", "MOUSE" );
	};

	                       
	var _SetUpCharModels = function()
	{
		var numRewards = _m_aLootist.length;
		var numParentWidth = _m_modelContainer.actuallayoutwidth/_m_modelContainer.actualuiscale_x;

		var sizePerPanel = Math.floor(( numParentWidth/numRewards));
		var aPosModels = [];

		                                       

		_m_aLootist.forEach( function( rewardId, index )
		{
			var elPlayerModel = _m_modelContainer.FindChildInLayoutFile( "id-op-shop-tile-char-model" + index );
			if( !elPlayerModel )
			{
				elPlayerModel = $.CreatePanel( "ItemPreviewPanel", _m_modelContainer , "id-op-store-inspect-char-model" + index );
				elPlayerModel.BLoadLayoutSnippet( 'snippet-model-char' );


				var model = ItemInfo.GetModelPathFromJSONOrAPI( rewardId );
				elPlayerModel.SetScene( "resource/ui/econ/ItemModelPanelCharWeaponInspect.res",
					model,
					false
				);

				elPlayerModel.mouse_rotate = false;
				elPlayerModel.rewardId = rewardId;
				
				var settings = ItemInfo.GetOrUpdateVanityCharacterSettings( rewardId, 'unowned' );
				settings.panel = elPlayerModel;

				CharacterAnims.PlayAnimsOnPanel( settings );
				_MakeCharButton( _m_modelContainer, elPlayerModel, settings );
				_UpdateCheerBtn( elPlayerModel, settings );
				           
				                                                    

				var elNameLabel = elPlayerModel.FindChildInLayoutFile( 'id-store-inspect-item-name' );
				_UpdateItemName( elNameLabel, rewardId );

				var elPanel = elPlayerModel.FindChildInLayoutFile( 'id-store-inspect-item-rarity' );
				_UpdateItemRarityColor( elPanel, rewardId );

				                                                     
				                                                                                          
				aPosModels.push( _PlaceCharsEvenlyInPanel( elPlayerModel, sizePerPanel, index ));
			}
		});

		                                                          
		                                                                              
		$.Schedule( 0.1, _CenterCharsInPanel.bind( undefined, numParentWidth, aPosModels ));
	};

	var _MakeCharButton = function( elParent, elPlayerModel, settings )
	{
		var elPlayerButton = elPlayerModel.FindChildInLayoutFile( "id-op-store-inspect-char-button" );

		                                                                                                                           
		elPlayerButton.SetPanelEvent( 'onactivate', _OnActivateOpenInSeperateInspect.bind( undefined, elPlayerModel.rewardId ) );
		elPlayerButton.SetPanelEvent( "onmouseover", function()
		{
			elPlayerModel.SetDirectionalLightModify( 0 );
			elPlayerModel.SetDirectionalLightColor( 7.00, 3.96, 2.07);

			$.DispatchEvent( "CSGOPlaySoundEffect", "submenu_dropdown_option_select", "MOUSE" );
		});

		elPlayerButton.SetPanelEvent( "onmouseout", function()
		{
			elPlayerModel.SetDirectionalLightModify( 0 );
			elPlayerModel.SetDirectionalLightColor(0.21, 0.21, 0.22);
		});
	};

	var _UpdateCheerBtn = function( elPlayerModel, settings )
	{
		var elCheerBtn = elPlayerModel.FindChildInLayoutFile("id-op-store-inspect__char-cheer");

		var cheer = ItemInfo.GetDefaultCheer( settings.charItemId );
		if( !cheer )
		{
			elCheerBtn.visible = false;
			return;
		}
		else
		{
			elCheerBtn.visible = true;
			elCheerBtn.SetPanelEvent( 'onactivate', function(){
				                                                                                        
				                                                
				settings.cheer = cheer;
				CharacterAnims.PlayAnimsOnPanel( settings, false, false );
			} );
		}
	};

	var _PlaceCharsEvenlyInPanel = function( elPlayerModel, sizePerPanel, index )
	{
		elPlayerModel.style.x = (sizePerPanel * index) + 'px';
		return sizePerPanel * index;
	};

	var _CenterCharsInPanel = function( numParentWidth, aPosModels )
	{
		var numChildWidth = _m_modelContainer.Children()[0].actuallayoutwidth/_m_modelContainer.actualuiscale_x;
		var numAllCharsWidth = aPosModels[aPosModels.length-1]+ numChildWidth;
		var numOffset = (numAllCharsWidth - numParentWidth)/2;

		_m_modelContainer.Children().forEach( function( child, index )
		{
			$.Schedule( .1, function() {
				var prevPosString = child.style.position;
				var prevPosX = Number( prevPosString.split( ' ' )[ 0 ].split( 'px' )[ 0 ] );

				                               
				child.style.x = prevPosX- numOffset +'px';
				child.AddClass( 'show' );
			});
		});
	};

	                   
	var _SetupItemTray = function()
	{
		var elParent = _m_cp.FindChildInLayoutFile( 'id-op-inspect-rewards-tray-container' );
		elParent.SetHasClass( 'has-model-panel', _m_rewardtype ==='isWeaponsCase');

		if ( _m_aLootlistGroups )
		{
			_m_aLootlistGroups.forEach( function( grp, index )
			{
				var isEnabled = false;
				var elGroup = fnMakeLootlistGroup( grp, elParent, index, isEnabled);
				elGroup.SetPanelEvent( 'onactivate', _PlaceGroupExpandedPanel.bind( undefined, elGroup, grp) );

				var offest = 0;

				var zIndex = elGroup.Children().length;
				elGroup.Children().forEach( function( tile, index ){
					tile.style.transform = "translateX("+offest+"px);";
					tile.style.zIndex = zIndex;
					tile.style.brightness = 1/(index + 1 );
					offest+=14;
					zIndex--;
				});
			});
		}
		else
		{
			for ( var i = 0; i < _m_aLootist.length; ++ i )
			{
				fnMakeItemTrayButton( _m_aLootist[i], elParent );
			}
		}
	};

	var _PlaceGroupExpandedPanel = function ( elGroup, grp ) 
	{
		var elGroupExpanded = _m_cp.FindChildInLayoutFile('id-lootlist-grp-expanded');
		if( elGroupExpanded && elGroupExpanded.IsValid())
		{
			elGroupExpanded.DeleteAsync(0);
		}

		var elParent =_m_cp.FindChildInLayoutFile('id-op-inspect-all-models-container-group-expanded');
		elParent.hittest = true;
		elParent.visible = true;
	
		var isEnabled = true;
		elGroupExpanded = fnMakeLootlistGroup( grp, elParent, 'expanded', isEnabled );
		$.DispatchEvent( "PlaySoundEffect", "submenu_dropdown_option_select", "MOUSE" );
		
		$.Schedule( .1, function()
		{
			var  tileWidth = elGroupExpanded.Children()[0].actuallayoutwidth/elGroupExpanded.actualuiscale_x;
			var numGroupWidth = tileWidth * elGroupExpanded.Children().length;
			elGroupExpanded.style.width = numGroupWidth+'px;';
			
			elGroupExpanded.Children().forEach( function( tile, index ){
				tile.style.x = (tileWidth * index) +"px;";
			} );
			
		});
	

			_m_cp.FindChildInLayoutFile('id-op-inspect-rewards-tray-container').AddClass( 'blur');
	};

	var _RemoveGroupExpandedPanel = function( elGroupExpanded )
	{
		_m_cp.FindChildInLayoutFile('id-lootlist-grp-expanded').DeleteAsync(0);
		_m_cp.FindChildInLayoutFile('id-lootlist-grp-expanded').GetParent().visible = false
		_m_cp.FindChildInLayoutFile( 'id-op-inspect-rewards-tray-container' ).RemoveClass( 'blur' );
		$.DispatchEvent( "PlaySoundEffect", "ui_custom_lobby_dialog_slide", "MOUSE" );
	};

	
	var fnMakeLootlistGroup = function( grp, elParent, index, isEnabled )
	{
		var elGroup = $.CreatePanel( 'Panel', elParent, 'id-lootlist-grp-' + index );
		elGroup.BLoadLayoutSnippet('snippet-tray-group');

		for ( var i = grp.idxBegin; i < grp.idxEnd; ++ i )
		{
			var elImage = fnMakeItemTrayButton( _m_aLootist[i], elGroup );
			elImage.enabled = isEnabled;
		}

		return elGroup;
	}

	var fnMakeItemTrayButton = function( rewardId, elParent )
	{
		var elThumbnail = null;
		if ( rewardId !== '0' )
		{
			elThumbnail = MakeThumbnailImageForTray( elParent, rewardId, "RadioButton" );
			elThumbnail.SetPanelEvent( 'onactivate', _OnActivateOpenInSeperateInspect.bind( undefined, rewardId ) );
			elThumbnail.SetPanelEvent( 'onmouseover', _CacheWeapon.bind( undefined, rewardId ) );
			_UpdateItemRarityColor( elThumbnail.FindChildInLayoutFile('id-store-inspect-rewards-tray-rarity'), rewardId );

		}
		else if( _m_rewardtype ==='isWeaponsCase' )
		{
			elThumbnail = MakeThumbnailImageForTray( elParent, rewardId, "RadioButton" );
			elThumbnail.FindChildInLayoutFile('id-store-inspect-rewards-tray-rarity').visible = false;
		}

		return elThumbnail;
	};

	                                                 
	    
	   	                                                      

	   	                                                   

	   	                                          
	   	 
	   		                                                           
	   		                                        
	   		                                     

	   		                            
	   			                                                                                         
	   			                                                                                                    
	   			                                                                                                  
	   			                                   
	   		   
	   	 
	     

	var _SetUpWeaponCaseModel = function()
	{
		var elModelPanel = _MakeModelPanel( _m_modelContainer );
		var model = ItemInfo.GetModelPathFromJSONOrAPI( _m_rewardId );

		elModelPanel.SetScene( "resource/ui/econ/ItemModelPanelCharWeaponInspect.res", model, false );
		elModelPanel.PlaySequence( 'fall', true );

		$.DispatchEvent( "CSGOPlaySoundEffect", "container_" + 'weapon_fall', "MOUSE" );

		elModelPanel.FindChildInLayoutFile( 'id-store-inspect-item-name' ).text =$.Localize( "#SFUI_InvUse_Items_InContainer_Header" );
		elModelPanel.FindChildInLayoutFile( 'id-store-inspect-item-rarity' ).visible = false;
	};

	var _OnActivateOpenInSeperateInspect = function( itemId )
	{
		if ( !InventoryAPI.IsValidItemID( itemId ) )
			return;

		                                 
		InventoryAPI.PrecacheCustomMaterials( itemId );

		                                                                
		UiToolkitAPI.ShowCustomLayoutPopupParameters(
			'',
			'file://{resources}/layout/popups/popup_inventory_inspect.xml',
			'itemid=' + itemId +
			'&' + 'inspectonly=true'+
			'&' + 'asyncworkitemwarning=no' +
			'&' + 'showequip=false' +
			'&' + 'showitemcert=false' +
			'&' + 'showmarketlink=false' +
			'&' + 'asyncworkbtnstyle=hidden'+
			'&' + 'bluroperationpanel=true'
		);
	};

	var MakeThumbnailImageForTray = function( elParent, rewardId )
	{
		var elThumbnail = $.CreatePanel( "RadioButton", elParent, "", {
				group: 'reward_tray'
			});

		elThumbnail.BLoadLayoutSnippet('snippet-tray-btn');

		var elImage = elThumbnail.FindChildInLayoutFile('id-op-store-inspect-rewards-tray-image');

		if( rewardId === '0' )
		{
			var unusualItemImagePath = InventoryAPI.GetLootListUnusualItemImage( _m_rewardId ) + ".png";
			elImage.SetImage( "file://{images}/" + unusualItemImagePath );
			                                                               
		}
		else
		{
			elImage.itemid = rewardId;
			elImage.SetHasClass( 'graffiti', _m_rewardtype == "isGraffitiBox" );
			TintSprayIcon.CheckIsSprayAndTint( rewardId, elImage );
		}

		return elThumbnail;
	};

	                

	var _MakeModelPanel = function( )
	{	
		var elModel = _m_cp.FindChildInLayoutFile( 'id-op-shop-inspect-item-model');
		if( !elModel )
		{
			var elModel = $.CreatePanel( "ItemPreviewPanel", _m_modelContainer , "id-op-shop-inspect-item-model" );
			elModel.BLoadLayoutSnippet( 'snippet-model-item' );
		}
	
		return elModel;
	};

	var _CacheWeapon = function( id )
	{
		InventoryAPI.PrecacheCustomMaterials( id );
	};

	var _UpdateTitle = function()
	{
		_m_cp.FindChildInLayoutFile( 'id-op-inspect-title').text = InventoryAPI.GetItemName( _m_rewardId );

		                                                 
		_m_cp.FindChildInLayoutFile( 'id-op-inspect-title-icon').itemid = _m_rewardId;

	};

	var _UpdateItemName = function( elLabel, itemId )
	{
		ItemInfo.GetFormattedName( itemId ).SetOnLabel( elLabel );
	};

	var _UpdateItemRarityColor = function( elPanel, itemId )         
	{
		elPanel.style.washColor = ItemInfo.GetRarityColor( itemId );
	};

	var _OnItemCustomizationNotification = function( numericType, type, itemid )
	{
		if ( type === 'reward_redeemed' )
		{
			_m_recievedRewardId = itemid;
			if ( ItemInfo.IsWeapon(itemid) )
			{
				_CacheWeapon.bind( undefined, itemid );
			}
		}
	};
	
	var _UpdateBtns = function()
	{
		OperationUtil.ValidateOperationInfo( _m_nSeasonAccess );
		
		                          
		_m_cp.SetDialogVariableInt( "your_stars", OperationUtil.GetOperationInfo().nRedeemableBalance );
		_m_cp.SetDialogVariable( "cost_stars", _m_rewardCost );
		_m_cp.SetDialogVariable( "item_name", ItemInfo.GetName( _m_rewardId ));

		if ( _m_rewardFlags )
		{
			var elFlagsNotice = _m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-confirm-flags-notice-' + _m_rewardFlags );
			if ( elFlagsNotice )
			{
				elFlagsNotice.RemoveClass( 'hide' );
			}
		}

		var bSingularReward = ( _m_rewardtype === "isWeaponsCase" || 
			( _m_rewardtype === "isCharacterLootlist" && _m_aLootist.length === 1 ) );

		var elRewardGetDesc = _m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-reward-text' );
		elRewardGetDesc.text = bSingularReward ? 
			$.Localize( '#op_coin_get_reward_case', _m_cp ) :
			$.Localize( '#op_coin_get_reward_item', _m_cp );

		                  
		var elCostBtn = _m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-reward-btn' );

		elCostBtn.enabled = _m_rewardCost <= OperationUtil.GetOperationInfo().nRedeemableBalance &&
			OperationUtil.GetOperationInfo().bPremiumUser;

		elCostBtn.SetPanelEvent( 'onactivate', OnActivateShowHideConfirm.bind( undefined, true) );

		                   
		var elGetStars = _m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-more-points-btn_label' );
		if( !OperationUtil.GetOperationInfo().bPremiumUser )
		{
			elGetStars.text = $.Localize( '#op_pass_upsell' );

			_m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-more-points-btn' ).SetPanelEvent( 
				'onactivate', OperationUtil.OpenUpSell.bind( undefined )
			);
		}
		else
		{
			var starsNeeded = ( _m_rewardCost - OperationUtil.GetOperationInfo().nRedeemableBalance );
			if( starsNeeded > 0 )
			{
				elGetStars.SetDialogVariableInt( 'stars_needed', starsNeeded );
				elGetStars.text = starsNeeded > 1 ? 
					$.Localize( '#op_stars_upsell_star_number', elGetStars ) :
					$.Localize( '#op_stars_upsell_star_number_single', elGetStars );
			}
			else{
				elGetStars.text = $.Localize( '#op_stars_upsell' );
			}

			_m_cp.FindChildInLayoutFile( 'id-op-store-inspect-get-more-points-btn' ).SetPanelEvent( 
				'onactivate', OperationUtil.OpenUpSell.bind( undefined, starsNeeded )
			);
		}

		                 
		_m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-reward-btn_cancel' ).SetPanelEvent( 
			'onactivate',
			function(){ $.DispatchEvent( 'UIPopupButtonClicked', '' ) }
		);

		                       
		_m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-confirm-btn_label' ).SetPanelEvent( 
			'onactivate',
			OnActivateConfirmReward
		);

		_m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-confirm-btn_cancel' ).SetPanelEvent( 
			'onactivate',
			OnActivateShowHideConfirm.bind( undefined, false )
		);

		_m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-confirm-desc-label' ).text = bSingularReward ?
			$.Localize( '#op_stars_use_confirm_case', _m_cp) :
			$.Localize( '#op_stars_use_confirm_item', _m_cp );
		
	};

	var OnActivateShowHideConfirm = function( bshow )
	{
		var elCostRow = _m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-reward' );
		var elStarsRow = _m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-balance-panel' );
		elCostRow.SetHasClass( 'hide', bshow );
		elStarsRow.SetHasClass( 'hide', bshow );

		var elConfrimRow = _m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-confirm' );
		elConfrimRow.SetHasClass( 'hide', !bshow );

		_m_cp.FindChildInLayoutFile("id-op-inspect-all-models-container").SetHasClass( 'in-confirm-mode', bshow );
		_m_cp.FindChildInLayoutFile("id-op-inspect-all-models-container").hittestchildren = !bshow;
	};

	var OnActivateConfirmReward = function()
	{
		MissionsAPI.ActionRedeemOperationGoods( _m_nSeasonAccess, _m_rewardIndex );
		_m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-confirm-btn_label' ).enabled = false;
		_m_cp.FindChildInLayoutFile( 'id-op-inspect-shop-get-confirm-btn_cancel' ).enabled = false;
		_StartRevealAnim();
	};

	var _StartRevealAnim = function()
	{
		_m_cp.FindChildInLayoutFile( 'id-store-inspect-container' ).AddClass( 'hide' );
		_m_cp.FindChildInLayoutFile( 'id-store-inspect-movie' ).AddClass( 'unblur' );
		_m_cp.FindChildInLayoutFile( 'id-store-inspect-loading' ).RemoveClass('hide');

		$.Schedule( 4, function(){
			
			$.DispatchEvent( 'UIPopupButtonClicked', '' );
			
			if( _m_recievedRewardId )
			{
				var isSticker = ItemInfo.ItemMatchDefName( _m_recievedRewardId, 'sticker' );
				var isPatch = ItemInfo.ItemMatchDefName( _m_recievedRewardId, 'patch' );
				var isSpraySealed = ItemInfo.IsSpraySealed( _m_recievedRewardId );

				var showEquip = ( isSticker || isPatch || isSpraySealed ) ? 'false' : 'true';

				$.DispatchEvent( 'BlurOperationPanel' );
				UiToolkitAPI.ShowCustomLayoutPopupParameters(
					'',
					'file://{resources}/layout/popups/popup_inventory_inspect.xml',
					'itemid=' + _m_recievedRewardId +
					'&' + 'inspectonly=true'+
					'&' + 'showequip='+ showEquip +
					'&' + 'bluroperationpanel=true',
					'none'
				);
			}
			else{
				                                                               
				UiToolkitAPI.ShowGenericPopupOk(
					$.Localize( '#SFUI_SteamConnectionErrorTitle' ),
					$.Localize( '#SFUI_InvError_Item_Not_Given' ),
					'',
					function()
					{
					},
					function()
					{
					}
				);
			}
		});

	};

	var _OnCancel = function()
	{
		var elGroupExpanded = _m_cp.FindChildInLayoutFile('id-lootlist-grp-expanded');
		if ( elGroupExpanded && elGroupExpanded.IsValid() )
		{
			_RemoveGroupExpandedPanel();
		}
		else
		{
			$.DispatchEvent( 'UIPopupButtonClicked', '' );
		}
	}

	return {
		Init: _Init,
		OnItemCustomizationNotification: _OnItemCustomizationNotification,
		RemoveGroupExpandedPanel: _RemoveGroupExpandedPanel,
		UpdateBtns: _UpdateBtns,
		OnCancel: _OnCancel
	};
})();

(function () {
	var _m_cp = $.GetContextPanel();
	$.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', OperationStoreInspect.UpdateBtns );
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_ItemCustomizationNotification', OperationStoreInspect.OnItemCustomizationNotification );
	$.RegisterForUnhandledEvent( 'UnblurOperationPanel', function(){ OperationUtil.UnblurMenu( _m_cp); } );
	$.RegisterForUnhandledEvent( 'BlurOperationPanel', function(){ OperationUtil.BlurMenu( _m_cp); } );
})();

