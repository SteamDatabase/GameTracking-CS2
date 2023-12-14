
'use-strict';

var CapabilityCanStatTrackSwap = ( function()
{
	var m_scheduleHandle = null;

	var m_toolId = '';                                                                 
	var m_itemids = [ '', '' ];                            
	var m_statNumbersOriginal = [ 0, 0 ];                                                     
	var m_distanceLerped = 9999999;                                                       
	var m_flLerpProgress = 0.0;                                                  

	var _Init = function()
	{
		m_toolId = $.GetContextPanel().GetAttributeString( "swaptool", "" );
		m_itemids = [
			$.GetContextPanel().GetAttributeString( "swapitem1", "" ),
			$.GetContextPanel().GetAttributeString( "swapitem2", "" )
		];

		m_itemids.forEach( function( item, idx ) {
			m_statNumbersOriginal[idx] = parseInt( InventoryAPI.GetItemAttributeValue( item, "kill eater" ) );
			_SetItemModel( idx );
		} );

		_SetUpButtonStates();
		$.DispatchEvent( 'CapabilityPopupIsOpen', true );

		m_scheduleHandle = $.Schedule( 0.01, _LerpTimer );
	};

	var _SetItemModel = function( idx )
	{
		var elPanel = $.GetContextPanel().FindChildInLayoutFile( 'StatTrackSwapItemModel'+idx );
		                                                                       
		InspectModelImage.Init( elPanel, m_itemids[idx] );

		  
		                                                                         
			          
			     
		  
		  

		elPanel.AddClass( 'darken' );

		                                                                                                                                              
		elPanel.RemoveClass( 'full-width' );
		elPanel.RemoveClass( 'full-height' );
	};


	var _SetUpButtonStates = function()
	{
		$.GetContextPanel().FindChildInLayoutFile( 'StatTrackSwapAcceptConfirm' ).SetPanelEvent(
			'onactivate',
			_OnAccept
		);

		$.GetContextPanel().FindChildInLayoutFile( 'StatTrackSwapCancelBtn' ).SetPanelEvent(
			'onactivate',
			_ClosePopup
		);
	};

	var _LerpTimer = function()
	{
		m_scheduleHandle = null;

		var originalLen = m_statNumbersOriginal[1] - m_statNumbersOriginal[0];
		var newDistanceLerped = ( m_flLerpProgress < 1.0 )
			? Math.round( m_flLerpProgress * originalLen ) : originalLen;
		if ( newDistanceLerped != m_distanceLerped )
		{
			                                                                                                               
			m_distanceLerped = newDistanceLerped;
			$.DispatchEvent( 'CSGOPlaySoundEffectMuteBypass', 'popup_accept_match_waitquiet', 'MOUSE', 1.0 );
			
			$.GetContextPanel().FindChildInLayoutFile( 'StatTrackSwapNumber0' ).text = ( m_statNumbersOriginal[0] + m_distanceLerped ).toString().padStart( 6, "0" );
			$.GetContextPanel().FindChildInLayoutFile( 'StatTrackSwapNumber1' ).text = ( m_statNumbersOriginal[1] - m_distanceLerped ).toString().padStart( 6, "0" );
		}

		if ( m_flLerpProgress < 1.0 )
		{
			m_flLerpProgress += 0.01;
			                                                                                            
			m_scheduleHandle = $.Schedule( 0.04, _LerpTimer );
		}
		else
		{
			                                          
			                                                        
		}
	};

	var _OnAccept = function()
	{
		if ( m_scheduleHandle )
		{
			$.CancelScheduled( m_scheduleHandle );
			m_flLerpProgress = 1.0;
			_LerpTimer();                    
		}

		$.GetContextPanel().FindChildInLayoutFile( 'NameableSpinner' ).RemoveClass( 'hidden' );
		m_scheduleHandle = $.Schedule( 5, _CancelWaitforCallBack );

		InventoryAPI.SetStatTrakSwapToolItems( m_itemids[0], m_itemids[1] );
		InventoryAPI.UseTool( m_toolId, '' );
	};

	var _ClosePopup = function()
	{
		$.DispatchEvent( 'HideSelectItemForCapabilityPopup' );
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
		$.DispatchEvent( 'CapabilityPopupIsOpen', false );
	};

	var _CancelWaitforCallBack = function()
	{
		var elSpinner = $.GetContextPanel().FindChildInLayoutFile( 'NameableSpinner' );
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

	var _OnItemCustomization = function( numericType, type, itemid )
	{
		if ( m_scheduleHandle )
		{
			$.CancelScheduled( m_scheduleHandle );
			m_scheduleHandle = null;
		}

		_ClosePopup();
		$.DispatchEvent( 'ShowAcknowledgePopup', type, itemid );
	};

	return {
		Init: _Init,
		OnItemCustomization: _OnItemCustomization,
		ClosePopup: _ClosePopup
	}
} )();

( function()
{
	$.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_ItemCustomizationNotification', CapabilityCanStatTrackSwap.OnItemCustomization );
} )();