"use strict";

var m_LicenseRegisterTimer = null;

var SetupPopup = function()
{
                             
    var spinnerVisible = $.GetContextPanel().GetAttributeInt( "spinner", 0 );
    $( "#Spinner" ).SetHasClass( "SpinnerVisible", spinnerVisible );
    
    m_LicenseRegisterTimer = $.Schedule( 11, PanelTimedOut );
    $.Schedule( 1, PrepareToStartAgreementSessionInGame );

    $.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_StartAgreementSessionInGame', StartAgreementSessionInGame );
};

var PanelTimedOut = function()
{
                                      
    m_LicenseRegisterTimer = null;
    $.DispatchEvent( 'UIPopupButtonClicked', '' );

    UiToolkitAPI.ShowGenericPopupOk(
        $.Localize( '#SFUI_SteamConnectionErrorTitle' ),
        $.Localize( '#SFUI_Steam_Error_LinkUnexpected' ),
        '',
        function()
        {
        },
        function()
        {
        }
    );
};

var _CancelLicenseRegisterTimer  = function()
{
    if ( m_LicenseRegisterTimer )
    {
        $.CancelScheduled( m_LicenseRegisterTimer );
        m_LicenseRegisterTimer = null;
    }
};

function StartAgreementSessionInGame ( url )
{
	_CancelLicenseRegisterTimer();
	$.DispatchEvent( 'UIPopupButtonClicked', '' );
	                                   
	SteamOverlayAPI.OpenURL( '!'+url );                        
}

function PrepareToStartAgreementSessionInGame ()
{
	MyPersonaAPI.ActionStartAgreementSessionInGame();
}
