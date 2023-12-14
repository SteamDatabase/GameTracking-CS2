"use strict";

function SetupPopup()
{
	var strPopupValue = $.GetContextPanel().GetAttributeString( "popupvalue", "(not found)" );
	$.GetContextPanel().SetDialogVariable( "popupvalue", strPopupValue );
}

function OnOKPressed()
{
	                   
	                                                                  

	                                                      
	var callbackHandle = $.GetContextPanel().GetAttributeInt( "callback", -1 );
	if ( callbackHandle != -1 )
	{
		UiToolkitAPI.InvokeJSCallback( callbackHandle, 'OK' );
	}

	                                                                      
	                                    
	$.DispatchEvent( 'UIPopupButtonClicked', '' );
}

function OnQuitButtonPressed()
{
	UiToolkitAPI.ShowGenericPopupOneOptionCustomCancelBgStyle('Confirm Exit',
		'Are you sure you want to quit?',
		'',
		'Quit',
		function() {
			QuitGame('Option1')
		},
		'Return',
		function() {
		},
		'dim'
	);
}

function OnHomeButtonPressed()
{
	$.DispatchEvent( 'HideContentPanel' );

	                   
	$.DispatchEvent( 'UIPopupButtonClicked', '' );
}

function OnSettingsButtonPressed()
{
	UiToolkitAPI.ShowCustomLayoutPopup( '', 'file://{resources}/layout/popups/popup_settings.xml' );

	                   
	$.DispatchEvent( 'UIPopupButtonClicked', '' );
}

function QuitGame( msg )
{
	                                                 
	GameInterfaceAPI.ConsoleCommand('quit');
}
