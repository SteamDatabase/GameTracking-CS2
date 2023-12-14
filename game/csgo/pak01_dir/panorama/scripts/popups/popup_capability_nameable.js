
'use-strict';

var CapabilityNameable = ( function()
{
	var m_Inspectpanel = $.GetContextPanel(),
		m_elTextEntry = $.GetContextPanel().FindChildInLayoutFile( 'NameableTextEntry' ),
		m_elRemoveConfirm = $.GetContextPanel().FindChildInLayoutFile( 'NameableRemoveConfirm' ),
		m_elValidBtn = $.GetContextPanel().FindChildInLayoutFile( 'NameableValidBtn' ),
		m_elRemoveBtn = $.GetContextPanel().FindChildInLayoutFile( 'NameableRemoveBtn' );

	var m_itemId = '';
	var m_toolId = '';

	var _Init = function()
	{
		var strMsg = $.GetContextPanel().GetAttributeString( "nametag-and-itemtoname", "(not found)" );

		var idList = strMsg.split( ',' );
		m_toolId = idList[ 0 ];
		m_itemId = idList[ 1 ];

		                                     
		var defName = InventoryAPI.GetItemDefinitionName( m_itemId );
		$.GetContextPanel().SetHasClass( 'isstorageunit', ( defName === 'casket' ) );

		_SetUpPanelElements();
		                       

		$.DispatchEvent( 'CapabilityPopupIsOpen', true );
	};

	var _SetItemModel = function( id )
	{
		var elItemModelImagePanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectModelOrImage' );
		InspectModelImage.Init( elItemModelImagePanel, id );

		elItemModelImagePanel.AddClass( 'popup-inspect-modelpanel_darken' );
		
		var elNameTagModel = $.GetContextPanel().FindChildInLayoutFile('id-inspect-nametag-model');
		if ( elNameTagModel && elNameTagModel.IsValid() )
		{
			elNameTagModel.TransitionToCamera( 'cam_nametag', 1.0);
			elNameTagModel.SetItemModel( 'weapons/models/shared/nametag/nametag_module.vmdl' );
			elNameTagModel.SetItemLabel( '' );
		}
	};

	var _SetUpPanelElements = function()
	{
		if ( !m_toolId )
		{
			$.GetContextPanel().SetAttributeString( 'asyncworkitemwarning', 'no' );
		}
		else
		{
			$.GetContextPanel().SetAttributeString( 'toolid', m_toolId );
		}

		_SetUpAsyncActionBar( m_itemId );
		_ShowPurchase( m_toolId );
		_SetupHeader( m_itemId );
		_SetItemModel( m_itemId );
		_SetUpNameTagModel();

		var noTool = ( m_toolId === '' ) ? true : false;
		var hasName = InventoryAPI.HasCustomName( m_itemId );

		_SetUpButtonStates( m_toolId, m_itemId, hasName, noTool );
		_UpdateAcceptState();
	};
	
	var _SetUpAsyncActionBar = function( itemId )
	{
		var elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
		
		InspectAsyncActionBar.Init(
			elAsyncActionBarPanel,
			itemId,
			_GetSettingCallback,
			_AsyncActionPerformedCallback
		);
	};

	var _ShowPurchase = function( toolId )
	{
		var elPurchase = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectPurchaseBar' );
		var fakeItem = '';

		if( !toolId )
		{
			var nameTagStoreId = 1200;
			fakeItem = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( nameTagStoreId, 0 );
			$.GetContextPanel().SetAttributeString( 'purchaseItemId', fakeItem );
		}

		InspectPurchaseBar.Init(
			elPurchase,
			fakeItem,
			_GetSettingCallback
		);
	};

	var _SetupHeader = function ( itemId )
	{
		var elCapabilityHeaderPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpCapabilityHeader' );
		CapabilityHeader.Init( elCapabilityHeaderPanel, itemId, _GetSettingCallback );
	}

	var _GetSettingCallback = function( settingname, defaultvalue )
	{
		return m_Inspectpanel.GetAttributeString( settingname, defaultvalue );
	};

	var _AsyncActionPerformedCallback = function()
	{
		m_Inspectpanel.FindChildInLayoutFile( 'NameableRemoveConfirm' ).enabled = false;
		m_Inspectpanel.FindChildInLayoutFile( 'NameableValidBtn' ).enabled = false;
	};

	var _SetUpNameTagModel = function ()
	{
		var elNameTagModel = $.GetContextPanel().FindChildInLayoutFile( 'id-inspect-nametag-model' );
		
		                                                                  
		                                                      
		                                                   
		   
			                                                                        
			                                                      
		   
	}

	var _SetUpButtonStates = function( toolId, itemId, hasName, noTool )
	{
		var elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
		InspectAsyncActionBar.EnableDisableOkBtn( elAsyncActionBarPanel, false );

		m_elValidBtn.SetHasClass( 'hidden', noTool );

		m_elValidBtn.SetPanelEvent( 'onactivate', function()
		{
			$.DispatchEvent( "CSGOPlaySoundEffect", "rename_select", "MOUSE" );
			InspectAsyncActionBar.EnableDisableOkBtn( elAsyncActionBarPanel, true );
			m_elTextEntry.enabled = false;
			                               
			m_elRemoveBtn.SetHasClass( 'hidden', false );
			m_elValidBtn.SetHasClass( 'hidden', true );
		} );

		m_elRemoveBtn.SetPanelEvent( 'onactivate', _RemoveButtonAction );

		m_elRemoveConfirm.SetPanelEvent( 'onactivate',
			_OnRemoveConfirm.bind( undefined, itemId ) );

		m_elRemoveConfirm.SetHasClass( 'hidden', !hasName );
		m_elTextEntry.SetFocus();
		m_elTextEntry.SetMaxChars( 20 );
		m_elTextEntry.text = _SetDefaultTextForTextEntry( hasName, itemId );
	};

	var _RemoveButtonAction = function()
	{
		var elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
		
		InspectAsyncActionBar.EnableDisableOkBtn( elAsyncActionBarPanel, false );
		m_elTextEntry.enabled = true;
		m_elTextEntry.SetFocus();
		m_elRemoveBtn.SetHasClass( 'hidden', true );
		m_elValidBtn.SetHasClass( 'hidden', false );
		m_elTextEntry.text = '';
	}

	var _SetDefaultTextForTextEntry = function( hasName, itemId )
	{
		if ( m_elTextEntry.text !== '' )
		{
			return m_elTextEntry.text;
		}

		if ( !hasName )
		{
			return '';
		}

		let nameWithQuotes = ItemInfo.GetName( itemId );
		if ( nameWithQuotes && nameWithQuotes.length > 4
			&& nameWithQuotes[0] == "'" && nameWithQuotes[1] == "'"
			&& nameWithQuotes[nameWithQuotes.length-1] == "'" && nameWithQuotes[nameWithQuotes.length-2] == "'"
			)
		{
			return nameWithQuotes.substr( 2, nameWithQuotes.length - 4 );
		}
		else
		{
			return nameWithQuotes;
		}
	};

	var _OnRemoveConfirm = function( itemId )
	{
		                                       

		var temp = UiToolkitAPI.ShowGenericPopupOkCancel(
			$.Localize( '#popup_nameable_remove_confirm_title' ),
			$.Localize( '#tooltip_nameable_remove' ),
			'',
			function()
			{
				                                        
				InventoryAPI.ClearCustomName( itemId );
				_ClosePopup();
				$.DispatchEvent( 'HideSelectItemForCapabilityPopup' );
			},
			function()
			{
			}
		);
	};

	var _OnEntryChanged = function()
	{
		var elNameTagModel = $.GetContextPanel().FindChildInLayoutFile('id-inspect-nametag-model');		
		if ( elNameTagModel && elNameTagModel.IsValid() )
		{
			elNameTagModel.SetItemLabel( m_elTextEntry.text );	
			$.DispatchEvent( "CSGOPlaySoundEffect", "rename_teletype", "MOUSE" );
			_UpdateAcceptState();
		}
	};

	var _UpdateAcceptState = function()
	{
		var isValid = InventoryAPI.SetNameToolString( m_elTextEntry.text );
		                               
		m_elValidBtn.enabled = isValid;

		var onMouseOver = function( isValid )
		{
			if ( !isValid )
				UiToolkitAPI.ShowTextTooltip( 'NameableValidBtn', '#tooltip_nameable_invalid' );
		}

		m_elValidBtn.SetPanelEvent( 'onmouseover', onMouseOver.bind( undefined, isValid ) );
		m_elValidBtn.SetPanelEvent( 'onmouseout', function()
		{
			UiToolkitAPI.HideTextTooltip();
		} );
	};

	var _NameTagAcquired = function( ItemId )
	{
		if ( m_toolId === '' )
		{
			if ( ItemInfo.ItemMatchDefName( ItemId, 'name tag' ) )
			{
				m_toolId = ItemId;
				                                 
				$.DispatchEvent( 'HideStoreStatusPanel' );
				_SetUpPanelElements();
				_AcknowlegeNameTags();
			}
		}
	};

	var _AcknowlegeNameTags = function()
	{
		var bShouldAcknowledge = true;
		AcknowledgeItems.GetItemsByType( [ 'name tag' ], bShouldAcknowledge );
	};

	var _ClosePopup = function()
	{
		var elAsyncActionBarPanel = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectAsyncBar' );
		var elPurchase = $.GetContextPanel().FindChildInLayoutFile( 'PopUpInspectPurchaseBar' );

		if( !elAsyncActionBarPanel.BHasClass( 'hidden' ))
		{
			InspectAsyncActionBar.OnEventToClose();
		}
		else if ( !elPurchase.BHasClass( 'hidden' ) )
		{
			InspectPurchaseBar.ClosePopup();
		}
	};

	var _Refresh = function()
	{
		                                                         
		var elNameTagModel = $.GetContextPanel().FindChildInLayoutFile('id-inspect-nametag-model');		
		if ( elNameTagModel && elNameTagModel.IsValid() )
		{
			_SetUpPanelElements();

			return;
		}

		_ClosePopup();
	}

	return {
		Init: _Init,
		OnEntryChanged: _OnEntryChanged,
		NameTagAcquired: _NameTagAcquired,
		ClosePopup: _ClosePopup,
		Refresh: _Refresh
	}
} )();

( function()
{
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Store_PurchaseCompleted', CapabilityNameable.NameTagAcquired );

	$.RegisterForUnhandledEvent( 'CSGOShowMainMenu', CapabilityNameable.Init );
	$.RegisterForUnhandledEvent( 'PopulateLoadingScreen', CapabilityNameable.ClosePopup );
} )();
