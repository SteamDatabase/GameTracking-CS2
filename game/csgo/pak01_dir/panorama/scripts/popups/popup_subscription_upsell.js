"use strict";

var SetupPopup = function()
{
	var sPrice = StoreAPI.GetStoreItemSalePrice( InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( 4748, 0 ), 1, '' );
	$.GetContextPanel().SetDialogVariable( "price", sPrice ? sPrice : '$0' );
};

function OnOKPressed()
{
    MyPersonaAPI.ActionManageRecurringSubscription();
    $.DispatchEvent( 'UIPopupButtonClicked', '' );

    SendCallback();
}

function OnCancelPressed()
{
    $.DispatchEvent( 'UIPopupButtonClicked', '' );
    SendCallback();
}

function SendCallback()
{
    var callbackHandle = $.GetContextPanel().GetAttributeInt( "callback", -1 );
    if ( callbackHandle != -1 )
    {
        UiToolkitAPI.InvokeJSCallback( callbackHandle, 'close' );
    }
}
