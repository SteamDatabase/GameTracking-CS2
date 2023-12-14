'use strict';

var PopupPrimeStatus = ( function ()
{
	var m_bIsPerfectWorld = ( ( MyPersonaAPI.GetLauncherType() === "perfectworld" ) && !GameInterfaceAPI.HasCommandLineParm( '-perfectworld' ) ) ? true : false;
	var m_btnPurchase = $( '#PurchaseButton' );

	var _Init = function ()
	{
		_SetStatusPanel( MyPersonaAPI.GetElevatedState() );
	}

	function _SetStatusPanel( strState )
	{
		                                                       
		                                                        
		                                                                                                                                         
		    
		   	                                                                                                                                                                                 
		    

		if( strState !== "elevated" )
		{
			m_btnPurchase.visible = true;
			PrimeButtonAction.SetUpPurchaseBtn( m_btnPurchase );

			return;
		}

		m_btnPurchase.visible= false;
	}

	function _UpdateEleveatedStatusPanel()
	{
		_SetStatusPanel( MyPersonaAPI.GetElevatedState() );
	}

	return {
		Init						: _Init,
		UpdateEleveatedStatusPanel	:_UpdateEleveatedStatusPanel
	}

})();

(function()
{
	$.RegisterForUnhandledEvent( "PanoramaComponent_MyPersona_ElevatedStateUpdate", PopupPrimeStatus.UpdateEleveatedStatusPanel );
})();
