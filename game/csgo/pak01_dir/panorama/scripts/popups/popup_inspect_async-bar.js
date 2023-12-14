
'use-strict';

var InspectAsyncActionBar = ( function()
{
	var m_scheduleHandle = null;
	var m_itemid = '';                             
	var m_worktype = '';                                                                             
	var m_okButtonClass = 'Positive';                                             
	var m_toolid = '';                                                             
	var m_isDecodeableKeyless = false;                                                   
	var m_asynActionForceHide = false;
	var m_showAsyncActionDesc = false;
	var m_isXrayMode = false;
	var m_allowXrayClaim = false;
	var m_inspectOnly = false;
	var m_isSeasonPass = false;
	var m_panel = null;
	var _m_PanelRegisteredForEvents;
	
	var _Init = function( elPanel, itemId, funcGetSettingCallback, funcCallbackOnAction )
	{
		m_itemid = itemId;
		m_worktype = funcGetSettingCallback( 'asyncworktype', '' );
		m_toolid = funcGetSettingCallback( 'toolid', '' );
		m_isDecodeableKeyless = ( funcGetSettingCallback( 'decodeablekeyless', 'false' ) === 'true' ) ? true : false;
		m_asynActionForceHide = ( funcGetSettingCallback( 'asyncforcehide', 'false' ) === 'true' ) ? true : false;
		m_showAsyncActionDesc = ( funcGetSettingCallback( 'asyncactiondescription', 'no' ) === 'yes' ) ? true : false;
		m_isXrayMode = ( funcGetSettingCallback( "isxraymode", "no" ) === 'yes' ) ? true : false;
		m_allowXrayClaim = ( funcGetSettingCallback( "allowxrayclaim", "no" ) === 'yes' ) ? true : false;
		m_inspectOnly = ( funcGetSettingCallback( 'inspectonly', 'false' ) === 'true' ) ? true : false;
		m_isSeasonPass = ( funcGetSettingCallback( 'seasonpass', 'false' ) === 'true' ) ? true : false;

		                                      
		                               
		                               

		if ( m_asynActionForceHide ||
			!m_worktype || 
			( m_worktype === 'nameable' && !m_toolid ) ||
			_DoesNotMeetDecodalbeRequirements()
		)
		{
			elPanel.AddClass( 'hidden' );
			return;
		}

		m_panel = elPanel;
		elPanel.RemoveClass( 'hidden' );
		
		m_okButtonClass = funcGetSettingCallback( 'asyncworkbtnstyle', m_okButtonClass );

		_SetUpDescription( elPanel );
		_SetUpButtonStates( elPanel, funcGetSettingCallback, funcCallbackOnAction );

		if ( m_worktype === 'prestigecheck' )
		{	                                                      
			_OnAccept( elPanel );
		}
		
		if ( !_m_PanelRegisteredForEvents )
		{
			_m_PanelRegisteredForEvents = $.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_ItemCustomizationNotification', InspectAsyncActionBar.OnItemCustomization );

			if( m_worktype !== 'decodeable' && m_worktype !== 'nameable' && m_worktype !== 'remove_sticker' )
			{
				$.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', InspectAsyncActionBar.OnMyPersonaInventoryUpdated );
				$.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_PrestigeCoinResponse', InspectAsyncActionBar.OnInventoryPrestigeCoinResponse );
			}
		}
	};

	var _DoesNotMeetDecodalbeRequirements = function()
	{
		                                                                                                      
		if ( m_worktype === 'decodeable' )
		{
			var sRestriction = InventoryAPI.GetDecodeableRestriction( m_itemid );
			if ( sRestriction === 'restricted' || ( sRestriction === 'xray' && !m_isXrayMode ) ||  m_inspectOnly )
				return false;

			return ( !m_toolid && !m_isDecodeableKeyless );
		}
		return false;
	};

	var _PerformAsyncAction = function( funcGetSettingCallback, funcCallbackOnAction )
	{
		                                           
		if ( m_worktype === 'useitem' || m_worktype === 'usegift' )
		{
			InventoryAPI.UseTool( m_itemid, '' );
		}
		else if ( m_worktype === 'delete' )
		{
			InventoryAPI.DeleteItem( m_itemid );
		}
		else if ( m_worktype === 'prestigecheck' )
		{
			InventoryAPI.RequestPrestigeCoinCheck();
		}
		else if ( m_worktype === 'prestigeget' || m_worktype === 'prestigeupgrade' )
		{
			InventoryAPI.RequestPrestigeCoin( InventoryAPI.GetItemDefinitionIndex( m_itemid ) );
		}
		else if ( m_worktype === 'nameable' )
		{
			$.DispatchEvent( "CSGOPlaySoundEffect", "rename_applyConfirm", "MOUSE" );
			InventoryAPI.UseTool( m_toolid, m_itemid );
			funcCallbackOnAction();
		}
		else if ( m_worktype === 'remove_patch' )
		{
			var selectedSlot = parseInt( funcGetSettingCallback( 'selectedItemToApplySlot', '' ) );
			funcCallbackOnAction( m_itemid, m_toolid, selectedSlot );
		}
		else if ( m_worktype === 'remove_sticker' )
		{
			var selectedSlot = parseInt( funcGetSettingCallback( 'selectedItemToApplySlot', '' ) );
			$.DispatchEvent( 'CSGOPlaySoundEffect', 'sticker_scratchOff', 'MOUSE' );
			funcCallbackOnAction( m_itemid, m_toolid, selectedSlot );
		}
		else if ( m_worktype === 'can_sticker' || m_worktype === 'can_patch' )
		{
			$.DispatchEvent( 'CSGOPlaySoundEffect', 'sticker_applyConfirm', 'MOUSE' );

			var selectedSlot = parseInt( funcGetSettingCallback( 'selectedItemToApplySlot', '' ) );
			funcCallbackOnAction( m_itemid, m_toolid, selectedSlot);

		}
		else if ( m_worktype === 'decodeable' )
		{
			                                                                 
			if ( ItemInfo.ItemMatchDefName( m_itemid, 'spray' ) || ItemInfo.ItemDefinitionNameSubstrMatch(m_itemid, 'tournament_pass_') )
			{
				InventoryAPI.UseTool( m_itemid, '' );
			}
			else if ( InventoryAPI.GetDecodeableRestriction( m_itemid ) === "xray" && !m_allowXrayClaim )
			{
				InventoryAPI.UseTool( m_itemid, m_itemid );
			}
			else
			{
				InventoryAPI.UseTool( m_toolid, m_itemid );
			}

			if ( InventoryAPI.GetDecodeableRestriction( m_itemid ) !== "xray" )
			{
				$.DispatchEvent( 'StartDecodeableAnim' );
			}
		}
	};
	
	var _SetUpButtonStates = function( elPanel, funcGetSettingCallback, funcCallbackOnAction )
	{
		var elOK = elPanel.FindChildInLayoutFile( 'AsyncItemWorkAcceptConfirm' );

		function _SetPanelEventOnAccept ()
		{
			elOK.SetPanelEvent(
				'onactivate',
				_OnAccept.bind(
					undefined,
					elPanel,
					funcGetSettingCallback,
					funcCallbackOnAction
				) );
		}

		if ( m_worktype === 'decodeable' )                                                           
		{
			var sRestriction = InventoryAPI.GetDecodeableRestriction( m_itemid );
			var elDescLabel = elPanel.FindChildInLayoutFile( 'AsyncItemWorkDesc' );
			var elDescImage = elPanel.FindChildInLayoutFile( 'AsyncItemWorkDescImage' );

			                               
			if ( m_inspectOnly || sRestriction === 'restricted' )
			{
				                                        
				elOK.visible = false;
				elDescLabel.visible = false;
				elDescImage.visible = false;
				return;
			}

			if ( m_isXrayMode )
			{
				var enabled = m_allowXrayClaim ? true : false;
				_EnableDisableOkBtn( elPanel, enabled );
				elOK.AddClass( m_okButtonClass );
				elOK.text = '#popup_xray_claim_item';
				_SetPanelEventOnAccept();
				return;
			}

			if ( sRestriction === 'xray' && !m_inspectOnly )
			{
				                                         
				elOK.visible = true;
				elOK.text = '#popup_xray_button_goto';
				elOK.AddClass( m_okButtonClass );

				elOK.SetPanelEvent( 'onactivate', function()
				{
					$.DispatchEvent( "ShowXrayCasePopup", m_toolid, m_itemid, true );
					_ClosePopup();

				} );

				                                               
				elDescLabel.visible = true;
				elDescLabel.text = '#popup_decodeable_async_xray_desc';
				elDescImage.visible = false;

				return;
			}
		}

		var sOkButtonText = '#popup_'+m_worktype+'_button';
		var itemDefName = ItemInfo.GetItemDefinitionName( m_itemid );
		if ( m_worktype === 'decodeable' )
		{
			if ( itemDefName && itemDefName.indexOf( "spray" ) != -1 )
				sOkButtonText = sOkButtonText + "_graffiti";
			else if ( itemDefName && itemDefName.indexOf( "tournament_pass_" ) != -1 )
				sOkButtonText = sOkButtonText + "_fantoken";
		}

		if ( m_worktype === 'nameable' && itemDefName === 'casket' )
		{
			sOkButtonText = '#popup_newcasket_button';
		}

		elOK.text = sOkButtonText;
		elOK.AddClass( m_okButtonClass );
		_SetPanelEventOnAccept();
	};

	var _SetUpDescription = function( elPanel )
	{
		var elDescLabel = elPanel.FindChildInLayoutFile( 'AsyncItemWorkDesc' );
		var elDescImage = elPanel.FindChildInLayoutFile( 'AsyncItemWorkDescImage' );

		elDescLabel.SetHasClass( 'popup-capability-faded', m_isXrayMode && !m_allowXrayClaim );
		elDescImage.SetHasClass( 'popup-capability-faded', m_isXrayMode && !m_allowXrayClaim );
		
		if ( m_showAsyncActionDesc )
		{
			elDescImage.itemid = m_toolid;
			var itemName = ItemInfo.GetName( m_toolid );

			if ( itemName )
			{
				elDescLabel.SetDialogVariable( 'itemname', itemName);
				elDescLabel.text = $.Localize( '#popup_' + m_worktype + '_async_desc', elDescLabel );
			}
		}	

		elDescLabel.visible = m_showAsyncActionDesc;
	};

	var _EnableDisableOkBtn = function( elPanel, bEnable )
	{
		var elOK = elPanel.FindChildInLayoutFile( 'AsyncItemWorkAcceptConfirm' );

		if( !elOK.visible )
			return;

		if( elOK.enabled !== bEnable )
			elOK.TriggerClass( 'popup-capability-update-anim');

		elOK.enabled = bEnable;
	};

	var _OnAccept = function( elPanel, funcGetSettingCallback, funcCallbackOnAction )
	{	
		_ResetTimeouthandle();

		elPanel.FindChildInLayoutFile( 'NameableSpinner' ).RemoveClass( 'hidden' );
		elPanel.FindChildInLayoutFile( 'AsyncItemWorkAcceptConfirm' ).AddClass( 'hidden' );

		if ( m_worktype !== 'remove_patch' && m_worktype !== 'remove_sticker')
		{
			m_scheduleHandle = $.Schedule( 5, _CancelWaitforCallBack.bind( undefined, elPanel ) );
		} 
		
		_PerformAsyncAction( funcGetSettingCallback, funcCallbackOnAction );
	};

	var _OnCloseRemove = function ()
	{
		                                                                                         
		if ( m_panel.IsValid() )
		{
			m_panel.FindChildInLayoutFile( 'NameableSpinner' ).AddClass( 'hidden' );
			m_panel.FindChildInLayoutFile( 'AsyncItemWorkAcceptConfirm' ).RemoveClass( 'hidden' );	
		}
	}
	
	var _ClosePopup = function()
	{
		_ResetTimeouthandle();
		$.DispatchEvent( 'HideSelectItemForCapabilityPopup' );
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
		$.DispatchEvent( 'CapabilityPopupIsOpen', false );
	};

	var _SetCallbackTimeout = function ()
	{
		$.Schedule( 5, _CancelWaitforCallBack.bind( undefined, $.GetContextPanel()) )
	}

	var _CancelWaitforCallBack = function( elPanel )
	{
		m_scheduleHandle = null;
		                        
		
		var elSpinner = elPanel.FindChildInLayoutFile( 'NameableSpinner' );
		elSpinner.AddClass( 'hidden' );

		_ClosePopup();

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

	var _OnEventToClose = function( bCloseForLootlistPreview = false )
	{
		_ResetTimeouthandle();

		if( !bCloseForLootlistPreview )
		{
			$.DispatchEvent( 'UnblurOperationPanel' );
		}
	
		_ClosePopup();
	};

	var _ResetTimeouthandle = function()
	{
		if ( m_scheduleHandle )
		{
			$.CancelScheduled( m_scheduleHandle );
			m_scheduleHandle = null;
		}
	};

	var _OnItemCustomization = function( numericType, type, itemid )
	{
		if ( _IgnoreClose() )
		{
			_ResetTimeouthandle();
			return;
		}

		_OnEventToClose();
		$.DispatchEvent( 'ShowAcknowledgePopup', type, itemid );
	};

	var _IgnoreClose = function()
	{
		return m_worktype === 'decodeable';
	};

	var _OnMyPersonaInventoryUpdated = function()
	{
		if( m_isSeasonPass && InventoryAPI.IsValidItemID( m_itemid ))
		{
			return;
		}
		
		_OnEventToClose();
	};

	var _OnInventoryPrestigeCoinResponse = function( defidx, upgradeid, hours, prestigetime )
	{
		_OnEventToClose();

		if ( m_worktype === 'prestigecheck' )
		{
			UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/popups/popup_inventory_inspect.xml',
				'itemid=' + InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( defidx, 0 ) +                                                                                          
				'&' + 'asyncworkitemwarning=no' +
				'&' + 'asyncworktype='+( ( upgradeid === '0' ) ? 'prestigeget' : 'prestigeupgrade')
			);
		}
		else if ( upgradeid !== '0' )
		{
			InventoryAPI.AcknowledgeNewItembyItemID( upgradeid );
			InventoryAPI.SetItemSessionPropertyValue( upgradeid, 'recent', '1' );
			$.DispatchEvent( 'InventoryItemPreview', upgradeid );
		}
	};

	return {
		Init: _Init,
		SetCallbackTimeout: _SetCallbackTimeout,
		OnItemCustomization: _OnItemCustomization,
		ResetTimeouthandle: _ResetTimeouthandle,
		OnCloseRemove: _OnCloseRemove,
		OnMyPersonaInventoryUpdated : _OnMyPersonaInventoryUpdated,
		OnInventoryPrestigeCoinResponse: _OnInventoryPrestigeCoinResponse,
		ClosePopup: _ClosePopup,
		OnEventToClose : _OnEventToClose,
		EnableDisableOkBtn : _EnableDisableOkBtn
	};
} )();