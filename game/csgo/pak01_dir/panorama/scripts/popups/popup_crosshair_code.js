'use strict';

var PopupCrosshairCode = ( function(){

	var elTextEntry = $( '#Code' );
	var elNotFoundLabel = $( '#InvalidCode' );
	var elApplyCode = $( '#ApplyCode' );

	var _Init = function () 
	{
		var code = MyPersonaAPI.GetCrosshairCode();
		var onMouseOver = function ()
		{
			UiToolkitAPI.ShowTextTooltip( 'Copy', code );
		}

		var onMouseOut = function ()
		{
			UiToolkitAPI.HideTextTooltip();
		}
		
		var onActivate = function ()
		{
			SteamOverlayAPI.CopyTextToClipboard( code );
			UiToolkitAPI.ShowTextTooltip( 'Copy', 'Copied your code to clipboard' );
			$( '#Code' ).text = code;
		}

		var elYourCodeBtn = $( '#Copy' );

		elYourCodeBtn.SetPanelEvent( 'onmouseover', onMouseOver );
		elYourCodeBtn.SetPanelEvent( 'onmouseout', onMouseOut );
		elYourCodeBtn.SetPanelEvent( 'onactivate', onActivate );
		                              


		                                         
		elApplyCode.enabled = false;

		                                                
		elNotFoundLabel.visible = false;
	};

	var ValidateCode = function ()
	{
		let bCodeValid = MyPersonaAPI.BValidateCrosshairCode( elTextEntry.text );
		elNotFoundLabel.visible = !bCodeValid;
		elApplyCode.enabled = bCodeValid;
		return bCodeValid;
	}

	var _OnTextEntryChange = function ()
	{
		ValidateCode();
	}

	var _OnEntrySubmit = function ()
	{
		var bSuccess = MyPersonaAPI.BApplyCrosshairCode( elTextEntry.text );
		if( bSuccess )
		{
			$.DispatchEvent( 'RefreshSettingsPanels', '' );
			$.DispatchEvent( 'UIPopupButtonClicked', '' );
		}
		else
		{
			ValidateCode(); 
		}
	};

	return {
		Init:	_Init,
		OnEntrySubmit: _OnEntrySubmit,
		OnTextEntryChange: _OnTextEntryChange
	};

} )();

                                                                                                    
                                            
                                                                                                    
(function()
{
})();