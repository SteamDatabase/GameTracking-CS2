"use strict";

var _strStoreStatusOkCmd = null;
var _strStoreProceedAfterCheckoutConfirmation = "StoreProceedAfterCheckoutConfirmation";

var SetupPopup = function()
{
    var ctx = $.GetContextPanel();

    var strMsg = ctx.GetAttributeString('text', '');
    var strClose = ctx.GetAttributeString('close', '0');
    var strCancel = ctx.GetAttributeString('cancel', '0');
    _strStoreStatusOkCmd = ctx.GetAttributeString('okcmd', '');

    ctx.SetDialogVariable("message", $.Localize(strMsg));
    
    var bClose = !!parseInt(strClose);
    var bCancel = !!parseInt(strCancel);

                                                                        

    if (!bClose && !bCancel)
    {
                           
        $('#CancelButton').visible = false;
    }

    if ( bCancel )
    {
                       
        $('#OkButton').visible = false;
	}
	
	                                                                                         
	var bPurchaseConfirmation = _strStoreStatusOkCmd.startsWith( _strStoreProceedAfterCheckoutConfirmation );
	var elPurchaseConfirmation = $('#PurchaseConfirmation');
	elPurchaseConfirmation.visible = bPurchaseConfirmation;
	var sPurchaseConfirmation = bPurchaseConfirmation ? _strStoreStatusOkCmd.slice( 1 + _strStoreProceedAfterCheckoutConfirmation.length ) : '';
	elPurchaseConfirmation.text = sPurchaseConfirmation ? sPurchaseConfirmation : $.Localize( '#SFUI_MBox_OKButton' );

    if ( bCancel && !bClose && !bPurchaseConfirmation )
    {
                          
        $("#Spinner").AddClass("SpinnerVisible");
	}
};

function OnOKPressed()
{
    if ( _strStoreStatusOkCmd )
    {
		if ( _strStoreStatusOkCmd.startsWith( _strStoreProceedAfterCheckoutConfirmation ) )
			StoreAPI.StoreProceedAfterCheckoutConfirmation();
		else
        	GameInterfaceAPI.ConsoleCommand(_strStoreStatusOkCmd);
    }
    _strStoreStatusOkCmd = null;

                  
    $.DispatchEvent( 'UIPopupButtonClicked', '' );
}
