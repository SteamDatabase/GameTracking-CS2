"use strict";

var OpBalanceReminder = ( function()
{
    var _Init = function()
    {
        var nSeasonIndex = 9;                                                                                                                   
        if( OperationUtil.ValidateOperationInfo( nSeasonIndex ) )
        {
            var isPremium = OperationUtil.GetOperationInfo().bPremiumUser;
			var nBalance = OperationUtil.GetOperationInfo().nRedeemableBalance;
			if ( !isPremium || !nBalance || nBalance <= 0 ) {
				nBalance = 0;                                                                         
			}
			$.GetContextPanel().FindChildInLayoutFile( 'id-op_balance-container').visible = ( nBalance > 0 );
			$.GetContextPanel().FindChildInLayoutFile('id-store-operation-balance').SetDialogVariableInt( "your_stars", nBalance );
        }
    }

    return{
        Init: _Init
    }
} )();

( function()
{
	OpBalanceReminder.Init();
	$.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', OpBalanceReminder.Init );
} )();