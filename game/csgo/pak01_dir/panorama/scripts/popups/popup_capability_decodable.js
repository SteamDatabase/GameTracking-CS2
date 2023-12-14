'use-strict';

              
                                                
             

var CapabilityDecodable = ( function()
{
	var m_aItemsInLootlist = [];
	var m_scrollListsPanelIds = [ 'ScrollList', 'ScrollListMagnified' ];
	var m_caseId = '';
	var m_existingRewardFromXrayId = '';
	var m_itemFromContainer = '';
	var m_InspectPanel = $.GetContextPanel();
	var m_keyId = '';
	var m_keyToSellId = '';
	var m_isKeyless = false;
	var m_storeItemId = '';
	var m_unusualItemImagePath = '';
	var m_showInspectScheduleHandle = null;
	var m_isAllowedToInteractWithLootlistItems = true;
	var m_styleforPopUpInspectFullScreenHostContainer = '';
	var m_isXrayMode = false;
	var m_blurOperationPanel = false;
	var m_elCaseModelImagePanel = null;
	
	var _Init = function()
	{
		function GetItemVarsFromMsg()
		{
			var idList = strMsg.split( ',' );
			return { key: idList[ 0 ], case: idList[ 1 ] };
		}
		
		function SetsItemVarsFromMsg()
		{
			var oData = GetItemVarsFromMsg();
			m_keyId = oData.key;
			m_caseId = oData.case;
		}
		
		var strMsg = $.GetContextPanel().GetAttributeString( "key-and-case", "" );
		                
		
		m_isXrayMode = $.GetContextPanel().GetAttributeString( "isxraymode", "no" ) === 'yes' ? true : false;
		m_isAllowedToInteractWithLootlistItems = ( $.GetContextPanel().GetAttributeString( 'allowtointeractwithlootlistitems', 'true' ) === 'true' ) ? true : false;
		m_blurOperationPanel = ( $.GetContextPanel().GetAttributeString( 'bluroperationpanel', 'false' ) === 'true' ) ? true : false;

		if ( m_blurOperationPanel )
		{
			$.DispatchEvent( 'BlurOperationPanel' );
		}

		if ( m_isXrayMode )
		{
			m_InspectPanel.SetHasClass( 'popup-in-xray', m_isXrayMode ); 
			var oData = ItemInfo.GetItemsInXray();
			m_existingRewardFromXrayId = oData.reward;

			if ( m_existingRewardFromXrayId )
			{
				if ( m_existingRewardFromXrayId )
				{
					                                                         
					if ( InventoryAPI.IsFauxItemID( m_existingRewardFromXrayId ) )
					{
						var elPopup = UiToolkitAPI.ShowGenericPopupOk( '#popup_xray_first_use_title', '#popup_xray_first_use_desc', '', function() { } );
						elPopup.FindChildInLayoutFile( 'MessageLabel' ).html = true;
						elPopup.SetDialogVariable( 'itemname', ItemInfo.GetName( m_existingRewardFromXrayId ) );
						elPopup.FindChildInLayoutFile( 'MessageLabel' ).text = $.Localize( '#popup_xray_first_use_desc', elPopup );
					}
					else if( $.GetContextPanel().GetAttributeString( "showxraypopup", "no" ) === 'yes' )
					{
						UiToolkitAPI.ShowGenericPopupOk( '#popup_xray_in_use_title', '#popup_xray_in_use_desc', '', function() { } );
					}
				}

				m_caseId = oData.case;
			}
			else
			{
				SetsItemVarsFromMsg();
			}

			                                                                               
			                                                     
			if ( !GetItemVarsFromMsg().key )
			{
				var keyId = ItemInfo.GetKeyForCaseInXray( m_caseId );
			
				if ( keyId )
				{
					m_keyId = keyId;
				}
			}
			else
			{
				m_keyId = GetItemVarsFromMsg().key;
			}
		}
		else
		{
			SetsItemVarsFromMsg();
		}

		m_styleforPopUpInspectFullScreenHostContainer = $.GetContextPanel().GetAttributeString( 'extrapopupfullscreenstyle', '' );
		if ( m_styleforPopUpInspectFullScreenHostContainer )
		{
			var elPopUpInspectFullScreenHostContainer = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectFullScreenHostContainer' );
			elPopUpInspectFullScreenHostContainer.AddClass( m_styleforPopUpInspectFullScreenHostContainer );
		}

		                                           
		if ( !m_keyId )
		{
			var associatedItemCount = InventoryAPI.GetAssociatedItemsCount( m_caseId );

			if ( !InventoryAPI.IsItemInfoValid( m_caseId ) )
			{
				return;
			}

			m_storeItemId = $.GetContextPanel().GetAttributeString( "storeitemid", "" );
			if ( ( associatedItemCount === 0 || !associatedItemCount ) && !m_storeItemId )
			{
				                                                           
				m_isKeyless = true;
			}
			else if ( !m_storeItemId )
			{
				                                                      
				m_keyToSellId = InventoryAPI.GetAssociatedItemIdByIndex( m_caseId, 0 );
			}
		}
		else
		{
			                 
			if ( !InventoryAPI.IsItemInfoValid( m_keyId ) )
			{
				return;
			}
		}

		_SetUpPanelElements();
		$.DispatchEvent( 'CapabilityPopupIsOpen', true );
	};

	var _SetUpPanelElements = function()
	{
		                                                                            
		if ( !m_keyId )
		{
			$.GetContextPanel().SetAttributeString( 'asyncworkitemwarning', 'no' );
			$.GetContextPanel().SetAttributeString( 'asyncactiondescription', 'no' );

			if ( m_existingRewardFromXrayId )
			{
				$.GetContextPanel().SetAttributeString( 'allowxraypurchase', 'yes' );
			}
		}
		else
		{
			$.GetContextPanel().SetAttributeString( 'toolid', m_keyId );
			$.GetContextPanel().SetAttributeString( 'asyncworkitemwarning', 'yes' );
			$.GetContextPanel().SetAttributeString( 'asyncactiondescription', 'yes' );

			if ( m_existingRewardFromXrayId )
			{
				$.GetContextPanel().SetAttributeString( 'allowxrayclaim', 'yes' );
			}
		}

		if ( m_isKeyless )
		{
			if ( m_existingRewardFromXrayId )
			{
				$.GetContextPanel().SetAttributeString( 'allowxrayclaim', 'yes' );
			}
			
			$.GetContextPanel().SetAttributeString( 'decodeablekeyless', 'true' );
			$.GetContextPanel().SetAttributeString( 'asyncworkitemwarning', 'yes' );
			$.GetContextPanel().SetAttributeString( 'asyncactiondescription', 'yes' );
		}

		                                                                  
		var sRestriction = m_storeItemId ? '' : InventoryAPI.GetDecodeableRestriction( m_caseId );
		                                                                                                              
		if ( sRestriction !== 'restricted' && sRestriction !== 'xray' || ( m_isXrayMode && sRestriction === 'xray' ) )
		{
			_ShowPurchase( ( m_keyId ) ? '' : m_keyToSellId );

			var category = ItemInfo.GetLoadoutCategory( m_caseId );
			if ( category == "musickit" )
			{
				InventoryAPI.PlayItemPreviewMusic( m_caseId, '' );
			}
		}

		_SetupHeader( m_caseId );
		_SetupDescription( m_caseId );
		_SetUpAsyncActionBar( m_caseId );

		if ( m_isXrayMode )
		{
			_SetUpXrayPanel();
		}
		else
		{
			_SetCaseModelImage( m_caseId, 'PopUpInspectModelOrImage' );
			                                   

			if ( !ItemInfo.ItemMatchDefName( m_caseId, 'spray' ) && !ItemInfo.ItemDefinitionNameSubstrMatch( m_caseId, 'tournament_pass_' ) )
			{
				_PlayCaseModelAnim( 'fall' );
				_PlayContainerSound( m_caseId, 'fall' );
			}

			_SetLootListItems( m_caseId, m_keyId );
		}
	};

	var _SetupHeader = function( caseId )
	{
		var elCapabilityHeaderPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpCapabilityHeader' );
		CapabilityHeader.Init( elCapabilityHeaderPanel, caseId, _GetSettingCallback );
	};

	var _SetupDescription = function( caseId )
	{
		var elPanel = $.GetContextPanel().FindChildInLayoutFile( 'InspectItemDesc' );
		var count = ItemInfo.GetLootListCount( caseId );
		
		if ( count === 0 && m_storeItemId )
		{
			elPanel.visible = true;
			elPanel.text = InventoryAPI.GetItemDescription( caseId, '' );
		}
		else
		{
			elPanel.visible = false;
		}
	};

	var _GetSettingCallback = function( settingname, defaultvalue )
	{
		return m_InspectPanel.GetAttributeString( settingname, defaultvalue );
	};

	                                                                                                    
	                                                   
	                                                                                                    
	var _SetCaseModelImage = function( caseId, PanelId )
	{
		var elItemModelImagePanel = $.GetContextPanel().FindChildInLayoutFile( PanelId );
		InspectModelImage.Init( elItemModelImagePanel, caseId );

		m_elCaseModelImagePanel = InspectModelImage.GetModelPanel();
	};

	var _PlayCaseModelAnim = function( anim )
	{
		                                                                             
		if (m_elCaseModelImagePanel && m_elCaseModelImagePanel.IsValid() && m_elCaseModelImagePanel.PlaySequence ) {
			m_elCaseModelImagePanel.PlaySequence(anim, true);
        }
	};

	                                                                                                    
	              
	                                                                                                    
	var _SetUpAsyncActionBar = function( itemId )
	{
		var elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
		
		InspectAsyncActionBar.Init(
			elAsyncActionBarPanel,
			itemId,
			_GetSettingCallback
		);
	};

	var _ShowPurchase = function( m_keyToSellId )
	{
		var elPurchase = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectPurchaseBar' );

		InspectPurchaseBar.Init(
			elPurchase,
			m_keyToSellId,
			_GetSettingCallback
		);
	};

	                                                                                                    
	                
	                                                                                                    
	var _SetLootListItems = function( caseId, keyId )
	{
		var count = ItemInfo.GetLootListCount( caseId );
		var elLootList = $.GetContextPanel().FindChildInLayoutFile( 'DecodableLootlist' );

		if ( count === 0 )
		{
			_ShowHideLootList( false );
			return;
		}

		if( m_elCaseModelImagePanel && m_elCaseModelImagePanel.IsValid() && m_elCaseModelImagePanel.id ==='ImagePreviewPanel' )
		{
			m_elCaseModelImagePanel.AddClass( 'y-offset' );
		}

		_ShowHideLootList( true );
		_SetLootlistHintText( caseId, count );
		
		for ( var i = 0; i < count; i++ )
		{
			var itemid = ItemInfo.GetLootListItemByIndex( caseId, i );
			var elItem = elLootList.FindChildInLayoutFile( itemid );
			
			if ( !elItem )
			{
				var elItem = $.CreatePanel( 'Panel', elLootList, itemid );
				elItem.SetAttributeString( 'itemid', itemid );
				elItem.BLoadLayoutSnippet( 'LootListItem' );

				_UpdateLootListItemInfo( elItem, itemid, caseId );
				var funcActivation = m_isAllowedToInteractWithLootlistItems ? _OnActivateLootlistTile : _OnActivateLootlistTileDummy;
				elItem.SetPanelEvent( 'onactivate', funcActivation.bind( undefined, itemid, caseId, keyId ) );
				elItem.SetPanelEvent( 'oncontextmenu', funcActivation.bind( undefined, itemid, caseId, keyId ) );

				if ( i === 0 && m_isAllowedToInteractWithLootlistItems )
				{
					$.GetContextPanel().FindChildInLayoutFile( 'CanDecodableBrowseBtn' ).SetPanelEvent( 'onactivate', callBackFunc.bind( undefined, itemid, caseId, keyId ) );
				}

				if ( itemid !== '0' )
				{
					m_aItemsInLootlist.push( {
						id: itemid,
						weight: _GetDisplayWeightForScroll( itemid ),
					} );
				}
			}
		}
	};

	var _OnActivateLootlistTileDummy = function( itemid, caseId, keyId )
	{
	}

	var _OnActivateLootlistTile = function( itemid, caseId, keyId )
	{
		if ( !InventoryAPI.IsValidItemID( itemid ) )
			return;

		                                 
		InventoryAPI.PrecacheCustomMaterials( itemid );

		var items = [];
		items.push( { label: '#UI_Inspect', jsCallback: callBackFunc.bind( undefined, itemid, caseId, keyId ) } );

		if ( MyPersonaAPI.GetLauncherType() !== "perfectworld" )
		{
			items.push( { label: '#SFUI_Store_Market_Link', jsCallback: _ViewOnMarket.bind( undefined, itemid ) } );
		}

		UiToolkitAPI.ShowSimpleContextMenu( '', 'ControlLibSimpleContextMenu', items );
	};

	var callBackFunc = function( itemid, caseId, keyId )
	{
		$.DispatchEvent( 'ContextMenuEvent', '' );
		                 
		_HidePanelForLootlistItemPreview();

		var storeid = ( m_storeItemId ) ? m_storeItemId : '';
		var bluroperationpanel = m_blurOperationPanel ? 'bluroperationpanel=true' : '';

		                                                                
		var additionalParams = _GetSettingCallback( 'inspectonly', 'false' ) === 'true' ? 'inspectonly=true,' : '';
		additionalParams = _GetSettingCallback( 'asyncworkbtnstyle', 'positive' ) === 'hidden' ? additionalParams + 'asyncworkbtnstyle=hidden' : '';
		additionalParams = m_blurOperationPanel ? additionalParams + ',' + 'bluroperationpanel=true' : '';
			
		$.DispatchEvent(
			"LootlistItemPreview",
			itemid,
			keyId +
			',' + caseId +
			',' + storeid +
			',' + bluroperationpanel +
			',' + m_styleforPopUpInspectFullScreenHostContainer +
			',' + additionalParams
		);
	};

	var _ViewOnMarket = function( id )
	{
		SteamOverlayAPI.OpenURL( ItemInfo.GetMarketLinkForLootlistItem( id ) );
		StoreAPI.RecordUIEvent( "ViewOnMarket" );
	};

	var _GetDisplayWeightForScroll = function( itemid )
	{
		var rarityVal = InventoryAPI.GetItemRarity( itemid );
		                                                         
		var displayItemWeight = [ 150000, 30000, 6000, 1250, 250, 50, 10 ];

		return displayItemWeight[ rarityVal ];
	};

	var _UpdateLootListItemInfo = function( elItem, itemid, caseId )
	{
		if ( itemid == '0' )
		{
			                                                                  
			m_unusualItemImagePath = InventoryAPI.GetLootListUnusualItemImage( caseId ) + ".png";
			_UpdateUnusualItemInfo( elItem, caseId, m_unusualItemImagePath, true );

		}
		else
		{
			elItem.FindChildInLayoutFile( 'ItemImage' ).itemid = itemid;
			elItem.FindChildInLayoutFile( 'JsRarity' ).style.backgroundColor = ItemInfo.GetRarityColor( itemid );
			ItemInfo.GetFormattedName( itemid ).SetOnLabel( elItem.FindChildInLayoutFile( 'JsItemName' ) );
		}
	};

	var _ShowHideLootList = function( bshow )
	{
		var elLootListContainer = $.GetContextPanel().FindChildInLayoutFile( 'DecodableLootlistContainer' );
		elLootListContainer.SetHasClass( 'hidden', !bshow );
	};

	var _SetLootlistHintText = function( caseId, count )
	{
		var bAllItems = InventoryAPI.GetLootListAllEntriesAreAdditionalDrops( caseId );
	
		$.GetContextPanel().FindChildInLayoutFile( 'CanDecodableDesc' ).visible = !bAllItems;

		if ( count > 1 || bAllItems )
		{
			$.GetContextPanel().FindChildInLayoutFile( 'CanDecodableDescMulti' ).SetDialogVariableInt( 'num_items', count );
			$.GetContextPanel().FindChildInLayoutFile( 'CanDecodableDescMulti' ).visible = ( count > 1 && bAllItems );
		}
	}

	var _UpdateUnusualItemInfo = function( elItem, caseId, unusualItemImagePath, bisDisplayedInLootlist = false )
	{
		if( !elItem || !elItem.IsValid() )
		{
			return;
		}

		elItem.FindChildInLayoutFile( 'ItemImage' ).SetImage( "file://{images}/" + unusualItemImagePath );
		
		if( bisDisplayedInLootlist )
		{
			elItem.FindChildInLayoutFile( 'JsRarity' ).AddClass( 'popup-decodable-wash-color-unusual' );

			var elBg = elItem.FindChildInLayoutFile( 'ItemTileBg' );
			elBg.AddClass( 'popup-decodable-wash-color-unusual-bg' );

			var elName = elItem.FindChildInLayoutFile( 'JsItemName' );
			elName.text = InventoryAPI.GetLootListUnusualItemName( caseId );
		}
		else
		{
			                                                             
			
			elItem.FindChildInLayoutFile( 'JsRarity' ).style.washColor = '#ffd700';
			elItem.FindChildInLayoutFile( 'JItemTint' ).style.washColor = '#ffd700';
		}
	};

	                                                                                                    
	                  
	                                                                                                    
	var _SetUpCaseOpeningScroll = function()
	{
		_ShowHideLootList( false );

		var delay = 0;
		
		if ( m_elCaseModelImagePanel && 
			m_elCaseModelImagePanel.IsValid() && 
			m_elCaseModelImagePanel.id == 'ImagePreviewPanel' && 
			!m_elCaseModelImagePanel.BHasClass( 'hidden' ) )
		{
			m_elCaseModelImagePanel.RemoveClass( 'y-offset' );
			delay = 0.1;
		}
		else
		{
			$.Schedule( 1, _PlayCaseModelAnim.bind( undefined, 'open' ) );
			delay = 2.3;
		}

		$.Schedule( delay, _ShowScroll.bind( undefined, m_elCaseModelImagePanel ) );
	};

	var _ShowScroll = function( elCase )
	{
		var elScroll = $.GetContextPanel().FindChildInLayoutFile( 'DecodableItemsScroll' );

		if ( !elScroll || !elScroll.IsValid() || !elCase || !elCase.IsValid() )
		{
			return;
		}
		
		elScroll.RemoveClass( 'hidden' );
		elCase.AddClass( 'popup-inspect-modelpanel_darken_blur' );

		
		_FillScrollsWithItems( m_scrollListsPanelIds );
		$.Schedule( 0.1, _PlayScrollAnim.bind( undefined, m_scrollListsPanelIds ) );
	};

	var _PlayScrollAnim = function( scrolllists )
	{
		var targetId = 'ItemFromContainer';

		var xOffsetSlackPercent = ( Math.floor( Math.random() * ( ( 90 ) - 10 + 1 ) + 10 ) / 100 );
		
		scrolllists.forEach( element =>
		{
			var xPos = _GetStopPosition( $.GetContextPanel().FindChildInLayoutFile( element ), targetId, xOffsetSlackPercent );
			var elScroll = $.GetContextPanel().FindChildInLayoutFile( element );
			elScroll.ScrollToFitRegion( xPos, xPos, 0, 0, 3, true, false );
		} );
		
		var revealDelay = 6;
		m_showInspectScheduleHandle = $.Schedule( revealDelay, _ShowInspect );

		var itemDefName = ItemInfo.GetItemDefinitionName( m_caseId );

		var soundEventName = "container_weapon_ticker";
		if ( itemDefName && itemDefName.indexOf( "sticker" ) != -1 )
		{
			soundEventName = "container_sticker_ticker";
		}
			

		for ( var i = 0; i < _TickSoundIntervals.length; ++i )
		{
			$.Schedule( _TickSoundIntervals[ i ], _ScrollTick.bind( undefined, soundEventName ) );
		}
	};

	                                                                                                                                 
	var _TickSoundIntervals = [ 0.000, 0.063, 0.125, 0.188, 0.250, 0.313, 0.375, 0.438, 0.500, 0.563, 0.625, 0.688, 0.750, 0.813, 0.875, 0.938, 1.000, 1.063, 1.125, 1.188, 1.250, 1.313, 1.375, 1.483, 1.351, 1.620, 1.701, 1.786, 1.872, 2.003, 2.154, 2.313, 2.466, 2.615, 2.773, 2.941, 3.104, 3.339, 3.630, 3.953, 4.385, 5.004, ];

	var _ScrollTick = function( soundEventName )
	{
		$.DispatchEvent( "CSGOPlaySoundEffect", soundEventName, "MOUSE" );
	};

	var _GetStopPosition = function( elParent, targetId, xOffsetSlackPercent )
	{
		var elTile = elParent.FindChildInLayoutFile( targetId );
		if( !elTile || !elTile.IsValid() )
			return;

		var tileWidth = elTile.contentwidth;

		return ( elTile.actualxoffset + ( tileWidth * xOffsetSlackPercent ) );
	};

	var _ShowInspect = function()
	{
		m_showInspectScheduleHandle = null;

		if ( m_itemFromContainer )
		{
			                                                                                
			                                                                                         
			                                                                                                 
			                                            
			InventoryAPI.SetItemSessionPropertyValue( m_itemFromContainer, 'recent', '1' );
			InventoryAPI.AcknowledgeNewItembyItemID( m_itemFromContainer );

			if ( ItemInfo.ItemDefinitionNameSubstrMatch( m_itemFromContainer, 'tournament_journal_' ) )
			{
				$.Schedule( 0.2, function()
				{
					UiToolkitAPI.ShowCustomLayoutPopupParameters(
						'',
						'file://{resources}/layout/popups/popup_tournament_journal.xml',
						'journalid=' + m_itemFromContainer
					);
				} );
			}
			else
			{
				$.DispatchEvent( "InventoryItemPreview", m_itemFromContainer );
			}

			CapabilityDecodable.ClosePopUp();

			var rarityVal = InventoryAPI.GetItemRarity( m_itemFromContainer );
			var soundEvent = "ItemRevealRarityCommon";
			if ( rarityVal == 4 )
			{
				soundEvent = "ItemRevealRarityUncommon";
			} else if ( rarityVal == 5 )
			{
				soundEvent = "ItemRevealRarityRare";
			} else if ( rarityVal == 6 )
			{
				soundEvent = "ItemRevealRarityMythical";
			} else if ( rarityVal == 7 )
			{
				soundEvent = "ItemRevealRarityLegendary";
			} else if ( rarityVal == 8 )
			{
				soundEvent = "ItemRevealRarityAncient";
			}
	
			$.DispatchEvent( "CSGOPlaySoundEffect", soundEvent, "MOUSE" );
		}
		else
		{
			_TimeoutPopup();
		}
	};

	var _TimeoutPopup = function()
	{
		CapabilityDecodable.ClosePopUp();
			
		                                                               
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
	};
	
	                                                                                                    
	                         
	                                                                                                    
	var _FillScrollsWithItems = function( lists )
	{
		var numTilesInScroll = 38;
		var indexItemsFromContainer = 3;
		var indexStart = ( numTilesInScroll - 3 );

		var totalWeight = 0;
		m_aItemsInLootlist.forEach( element =>
		{
			totalWeight += element.weight;
		} );
		
		var displayItemsList = [];
		
		for ( var i = 0; i < numTilesInScroll; i++ )
		{
			var itemToAdd = GetItemBasedOnDisplayWeight( totalWeight, m_aItemsInLootlist );
			
			if ( itemToAdd )
				displayItemsList.push( itemToAdd );
		}
		
		lists.forEach( element =>
		{
			var elParent = $.GetContextPanel().FindChildInLayoutFile( element );

			for ( var i = 0; i < displayItemsList.length; i++ )
			{
				var itemId = displayItemsList[ i ];
				var tileId = ( i === indexItemsFromContainer ) ? 'ItemFromContainer' : ( i === indexStart ) ? 'ItemStart' : itemId;

				var elTile = $.CreatePanel( 'Panel', elParent, tileId );
				elTile.BLoadLayoutSnippet( 'ScrollItem' );

				_UpdateScrollTile( element, elTile, itemId );
			}
		} );
	};

	var _UpdateScrollTile = function( listId, elTile, itemId )
	{
		if ( listId === 'ScrollListMagnified' )
		{
			elTile.AddClass( 'magnified' );
		}

		                                                                                 
		itemId = ( elTile.id === 'ItemFromContainer' && m_itemFromContainer ) ? m_itemFromContainer : itemId;

		if ( InventoryAPI.IsItemUnusual( itemId ) && m_unusualItemImagePath )
		{
			_UpdateUnusualItemInfo( elTile, m_caseId, m_unusualItemImagePath );
			                                                                                                          
		}
		else
		{
			elTile.FindChildInLayoutFile( 'ItemImage' ).itemid = itemId;
			elTile.FindChildInLayoutFile( 'JsRarity' ).style.washColor = ItemInfo.GetRarityColor( itemId );
			elTile.FindChildInLayoutFile( 'JItemTint' ).style.washColor = ItemInfo.GetRarityColor( itemId );
		}
	};

	var GetItemBasedOnDisplayWeight = function( totalWeight, aItemsInLootlist )
	{
		                                         
		var weightOfItem = 0;
		
		var Random = Math.floor( Math.random() * totalWeight );

		for ( var i = 0; i < aItemsInLootlist.length; i++ )
		{
			weightOfItem += aItemsInLootlist[ i ].weight;
			
			if ( Random <= weightOfItem )
				return aItemsInLootlist[ i ].id;
		}
	};

	                                                                                                    
	            
	                                                                                                    
	var _SetUpCaseOpeningCountdown = function()
	{
		_UpdateOpeningCounter.SetIsGraffiti( _GetContainerType( m_caseId ) === 'graffiti' );
		_UpdateOpeningCounter.ShowCounter();
		_UpdateOpeningCounter.UpdateCounter();
		_ShowHideLootList( false );
	};

	var _UpdateOpeningCounter = ( function()
	{
		var counterVal = 6;
		var elCountdown = $.GetContextPanel().FindChildInLayoutFile( 'DecodableCountdown' );
		var elCountdownLabel = elCountdown.FindChildInLayoutFile( 'DecodableCountdownLabel' );
		var elCountdownRadial = elCountdown.FindChildInLayoutFile( 'DecodableCountdownRadial' );
		var timerHandle = null;
		var isGraffitiUnseal = false;

		var _UpdateCounter = function()
		{
			timerHandle = null;
			counterVal = counterVal - 1;

			if ( counterVal === 0 )
			{
				                                      
				elCountdown.AddClass( 'hidden' );
				_ShowInspect();
			}
			else
			{
				$.DispatchEvent( "CSGOPlaySoundEffect", "container_countdown", "MOUSE" );

				elCountdownLabel.text = counterVal;
				
				if ( !isGraffitiUnseal )
				{
					elCountdownLabel.visible = true;
					elCountdownLabel.RemoveClass( 'popup-countdown-anim' );
					elCountdownLabel.AddClass( 'popup-countdown-anim' );
				}
				else
				{
					elCountdownLabel.visible = false;
				}

				elCountdownRadial.RemoveClass( 'popup-countdown-timer-circle-anim' );
				elCountdownRadial.AddClass( 'popup-countdown-timer-circle-anim' );

				timerHandle = $.Schedule( 1, _UpdateCounter );
			}
		};

		var _ShowCounter = function()
		{
			elCountdown.RemoveClass( 'hidden' );
		};

		var _CancelTimer = function()
		{
			if ( timerHandle )
			{
				$.CancelScheduled( timerHandle );
				timerHandle = null;
			}
		};

		var _SetIsGraffiti = function( isGraffiti )
		{
			isGraffitiUnseal = isGraffiti;
		};

		return {
			UpdateCounter: _UpdateCounter,
			ShowCounter: _ShowCounter,
			CancelTimer: _CancelTimer,
			SetIsGraffiti: _SetIsGraffiti
		};
	} )();

	                                                                                                    
	        
	                                                                                                   
	var _SetUpXrayPanel = function()
	{
		if ( !m_caseId )
		{
			                                
			                 
			return;
		}

		var elActionsPanel = $.GetContextPanel().FindChildInLayoutFile( 'XrayItemsActionPanel' );
		elActionsPanel.AddClass( 'hidden' );
		if ( !m_existingRewardFromXrayId )
		{
			                                                 
			elActionsPanel.RemoveClass( 'hidden' );
			_SetCaseModelImage( m_caseId, 'PopUpXrayModelOrImage' );

			var elBtn = $.GetContextPanel().FindChildInLayoutFile( 'ConfirmXray' );
			elBtn.SetPanelEvent( 'onactivate', _OnActivateXray.bind( undefined, elBtn ) );

			$.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayStatusLabel' ).text = $.Localize( "#popup_xray_ready_for_use" );
		}
		else if( m_existingRewardFromXrayId )
		{
			                                         
			var elHeaderPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectHeader' );
			InspectHeader.Init( elHeaderPanel, m_existingRewardFromXrayId, _GetSettingCallback );

			$.GetContextPanel().FindChildInLayoutFile( 'XrayItemsActionPanelItemName' ).RemoveClass( 'hidden' );
			var elImagePanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayModelOrImageReveal' );

			if ( !elImagePanel.BHasClass( 'popup-xray-reverse-effect' ) )
			{
				elImagePanel.AddClass( 'no-anim' );
				elImagePanel.AddClass( 'popup-xray-reverse-effect' );
				_SetCaseModelImage( m_existingRewardFromXrayId, 'PopUpXrayModelOrImageReveal' );
			}

			$.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayStatusLabel' ).text = $.Localize( "#popup_xray_already_in_use" );
			$.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayStatusDot' ).AddClass( 'in-use' );
		}
		
		var elXrayPanel = $.GetContextPanel().FindChildInLayoutFile( 'XrayItemsPanel' );
		elXrayPanel.RemoveClass( 'hidden' );

		var aPanels = $.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayBgSquares' ).Children();
		_AnimSquares( aPanels );
	};

	var _OnActivateXray = function( elBtn )
	{
		InventoryAPI.UseTool( m_caseId, m_caseId );
		elBtn.enabled = false;
		_XrayReveal();
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'XrayStart', 'MOUSE' );
	};

	var _XrayReveal = function()
	{
		var revealDelay = 3.5;
		                                                                                         
		m_showInspectScheduleHandle = $.Schedule( revealDelay, _ShowXrayReward );

		var oData = {
			clipValue: 0,
			lineValue: 100,
			clipPanel: $.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayModelOrImage' ),
			linePanel: $.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayModelOrImageRevealLine' )
		};
	
		oData.clipPanel.AddClass( 'popup-xray-inverse-effect' );
		$.GetContextPanel().FindChildInLayoutFile( 'PopUpXrayModelOrImageReveal' ).AddClass( 'popup-xray-reverse-effect' );
	
		$.Schedule( 1, function()
		{
			oData.linePanel.visible = true;
			_AnimClip( oData );
		} );
	};

	var _AnimClip = function( oData )
	{
		if ( oData.clipValue <= 100 )
		{
			oData.clipPanel.style.clip = 'rect( 0%, 100%, 100%, ' + oData.clipValue + '% );';
			oData.clipValue = oData.clipValue  + 1;

			oData.linePanel.style.transform = 'translatex( -' + oData.lineValue + '%);';
			oData.lineValue = oData.lineValue - 1;

			$.Schedule( 0.02, _AnimClip.bind( undefined, oData ) );
		}
		else
		{
			oData.linePanel.AddClass( 'hide' );
			oData.clipPanel.AddClass( 'hide' );
			_SetUpPanelElements();
		}
	};

	var _AnimSquares = function( aPanels )
	{
		if ( $.GetContextPanel().FindChildInLayoutFile( 'XrayItemsPanel' ).visible )
		{
			aPanels.forEach( panel =>
			{
				panel.style.backgroundColor = 'rgba(255, 255, 255, 0.0' + Math.ceil( Math.random() * 10 ) + ');';
			} );
			
			$.Schedule( 1, _AnimSquares.bind( undefined, aPanels ) );
		}
	};

	var _ShowXrayReward = function()
	{
		m_showInspectScheduleHandle = null;

		if ( m_existingRewardFromXrayId )
		{
			                                
			_SetUpPanelElements();
			                                                    
		}
		else
		{
			_TimeoutPopup();
		}
	};

	var _UpdateXrayRewardTile = function( itemId )
	{
		
		                                                             
		var oData = ItemInfo.GetItemsInXray();
		m_existingRewardFromXrayId = itemId === oData.reward ? oData.reward : '';
		
		_SetCaseModelImage( itemId, 'PopUpXrayModelOrImageReveal' );
		                                                                                                              


	};

	                                                                                                   
	                        
	                                                                                                   
	var _UpdateScrollResultTile = function( numericType, type, itemId )
	{
		                                                                     
		
		                                            
		                              
		                                  
		                                                         

		if ( type === "crate_unlock" ||
			type === 'graffity_unseal' ||
			type === 'xray_item_reveal' ||
			type === "xray_item_claim"
		)
		{
			if ( m_isXrayMode )
			{
				var oData = ItemInfo.GetItemsInXray();

				if ( oData.reward && type === 'xray_item_reveal' )
				{
					_UpdateXrayRewardTile( itemId );
					return;
				}
				else if ( type === 'xray_item_claim' )
				{
					m_itemFromContainer = itemId;
					_ShowInspect();
					return;
				}
			}
			else
			{
				m_itemFromContainer = itemId;
			}
	
			                                                                                         
			if ( $.GetContextPanel().FindChildInLayoutFile( 'DecodableItemsScroll' ).BHasClass( 'hidden' ) )
			{
				if ( type === 'graffity_unseal' )
				{
					_ShowInspect();
				}
				
				return;
			}
			else
			{
				                                                                                                                 
				m_scrollListsPanelIds.forEach( element =>
				{
					var elScroll = $.GetContextPanel().FindChildInLayoutFile( element );
					var elTile = elScroll.FindChildInLayoutFile( 'ItemFromContainer' );
					_UpdateScrollTile( element, elTile, itemId );
				} );
			}
		}
		else if ( type === "ticket_activated" )
		{
			m_itemFromContainer = itemId;
			_ShowInspect();
		}
	};

	var _ItemAcquired = function( ItemId )
	{
		$.DispatchEvent( "CSGOPlaySoundEffect", "rename_purchaseSuccess", "MOUSE" );
		
		if ( !m_keyId && m_keyToSellId )
		{
			var matchingKeyDefName = ItemInfo.GetItemDefinitionName( m_keyToSellId );
			
			if (  ItemInfo.ItemMatchDefName( ItemId, matchingKeyDefName ) )
			{
				m_keyId = ItemId;
				$.DispatchEvent( 'HideStoreStatusPanel' );
				_AcknowledgeMatchingKeys( matchingKeyDefName );
				_SetUpPanelElements();
			}
		}
		else if( m_storeItemId )
		{
			_ClosePopUp();
			$.DispatchEvent( 'ShowAcknowledgePopup', '', ItemId );
			$.DispatchEvent( 'HideStoreStatusPanel' );
		}
	};

	var _AcknowledgeMatchingKeys = function( matchingKeyDefName )
	{
		var bShouldAcknowledge = true;
		AcknowledgeItems.GetItemsByType( [ matchingKeyDefName ], bShouldAcknowledge );
	};

	var _ShowUnlockAnimation = function()
	{		
		var lootListCount = InventoryAPI.GetLootListItemsCount( m_caseId );

		if ( lootListCount === undefined )
		{
			if ( InventoryAPI.IsValidItemID( m_itemFromContainer ) )
			{
				_ShowInspect();
			}
			else
			{
				_SetUpCaseOpeningCountdown();
			}

			return;
		}

		if ( lootListCount <= 1 )
		{
			_SetUpCaseOpeningCountdown();
		}
		else
		{
			_SetUpCaseOpeningScroll();
		}

		_PlayContainerSound( m_caseId, 'open' );

		_PlayContainerSound( m_caseId, 'ticker' );
	};

	var _PlayContainerSound = function(caseId, soundName) {
		$.DispatchEvent( "CSGOPlaySoundEffect", "container_" + _GetContainerType(caseId) + "_" + soundName, "MOUSE" );
	};

	var _GetContainerType = function(caseId) {
		var itemDefName = ItemInfo.GetItemDefinitionName( m_caseId );
		if(itemDefName && ( itemDefName.indexOf("spray") != -1 || itemDefName.indexOf("tournament_pass_") != -1 ) ) {
			return 'graffiti';
		} else if(itemDefName && itemDefName.indexOf("sticker") != -1) {
			return 'sticker';
		} else if(itemDefName && itemDefName.indexOf("coupon") == 0) {
			return 'music';
		} else {
			return 'weapon';
		}
	};

	var _m_handlerForHideEvent = null;
	var _HidePanelForLootlistItemPreview = function()
	{
		if ( !m_InspectPanel.IsValid() )
			return;

		                                  
		if ( !_m_handlerForHideEvent )
		{
			_m_handlerForHideEvent = $.RegisterEventHandler( 'PropertyTransitionEnd', m_InspectPanel, function ( panel, propertyName )
			{
				if ( m_InspectPanel.id === panel.id && propertyName === 'opacity' )
				{
					                                         
					if ( m_InspectPanel.visible === true && m_InspectPanel.BIsTransparent() )
					{
						                                               
						m_InspectPanel.visible = false;
						return true;
					}
					else if ( m_InspectPanel.visible === true )
					{
					}
				}
				return false;
			} );
		}

		m_InspectPanel.SetHasClass( 'hide-for-lootlist', true );
	}

	var _ClosePopUp = function()
	{
		InventoryAPI.StopItemPreviewMusic();

		if ( m_InspectPanel.IsValid() )
		{ 
			if ( m_showInspectScheduleHandle )
			{
				$.CancelScheduled( m_showInspectScheduleHandle );
				m_showInspectScheduleHandle = null;
			}

			var elAsyncActionBarPanel = m_InspectPanel.FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
			var elPurchase = m_InspectPanel.FindChildInLayoutFile( 'PopUpInspectPurchaseBar' );
			if ( !elAsyncActionBarPanel.BHasClass( 'hidden' ) )
			{
				InspectAsyncActionBar.OnEventToClose();
			}
			else if ( !elPurchase.BHasClass( 'hidden' ) )
			{
				InspectPurchaseBar.ClosePopup();
			}
		}

		_UpdateOpeningCounter.CancelTimer();
	};

	var _Refresh = function()
	{
		if( !m_caseId || !InventoryAPI.IsValidItemID( m_caseId ) )
		{
			
			_ClosePopUp();
			return;
		}
		
		_SetUpPanelElements();
	}
	
	return {
		Init: _Init,
		SetUpCaseOpening: _SetUpCaseOpeningScroll,
		ClosePopUp: _ClosePopUp,
		UpdateScrollResultTile: _UpdateScrollResultTile,
		ItemAcquired: _ItemAcquired,
		ShowUnlockAnimation: _ShowUnlockAnimation,
		Refresh: _Refresh
	};
} )();

( function()
{
	                             
	var _m_PanelRegisteredForEvents;
	if ( !_m_PanelRegisteredForEvents )
	{
		_m_PanelRegisteredForEvents = $.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_ItemCustomizationNotification', CapabilityDecodable.UpdateScrollResultTile );
		$.RegisterForUnhandledEvent( 'PanoramaComponent_Store_PurchaseCompleted', CapabilityDecodable.ItemAcquired );
		$.RegisterForUnhandledEvent( 'StartDecodeableAnim', CapabilityDecodable.ShowUnlockAnimation );

		$.RegisterForUnhandledEvent( 'CSGOShowMainMenu', CapabilityDecodable.Refresh );
		$.RegisterForUnhandledEvent( 'PopulateLoadingScreen', CapabilityDecodable.ClosePopUp );
	}
} )();
