'use strict';

var AdvertisingToggle = ( function()
{
    var _m_elParent = $.GetContextPanel().FindChildInLayoutFile( 'id-friendslist-broadcast-toggle' );
    var _m_elBtn = _m_elParent.FindChildInLayoutFile( 'id-slider-btn' );
    var _m_lobbyListerFilter = '';

    var _Init = function()
    {
        _m_elBtn.SetPanelEvent( 'onactivate', _OnActivateToggle );
    };

    var _OnFilterPressed = function( sFilter )
    {
        _m_lobbyListerFilter = sFilter;
        _UpdateToggle();
        _UpdateTooltip( PartyListAPI.GetCount() > 1  );
    }

                                                    
    var _UpdateToggle = function()
    {
        if ( PartyListAPI.GetCount() > 1 )
        {
            _m_elBtn.checked = false;
            _m_elBtn.enabled = false;
            _UpdateTooltip( true );
            return;
        }

        _m_elBtn.enabled = true;
        _m_elBtn.checked = _GetAdvertisingSetting() === _m_lobbyListerFilter;
        _m_elBtn.SetDialogVariable( 'slide_toggle_text', $.Localize( "#advertising_for_hire_" + _m_lobbyListerFilter ) );
        _UpdateTooltip( false );
    };

                                            
    var _OnActivateToggle = function()
    {
        var currentSetting = _GetAdvertisingSetting();
        var newSetting = currentSetting === _m_lobbyListerFilter ? '' : _m_lobbyListerFilter;
        PartyListAPI.SetLocalPlayerForHireAdvertising( newSetting );
    }

    var _GetAdvertisingSetting = function()
    {
        var strAdvertising = PartyListAPI.GetLocalPlayerForHireAdvertising();
                                                                     
                                                                                             

        return strAdvertising.split( '-' )[ 0 ];
    }

    var _AdvertisingChanged = function()
    {
        var currentSetting = _GetAdvertisingSetting();
        _m_elBtn.checked = ( currentSetting !== '' && currentSetting === _m_lobbyListerFilter );
        PartyBrowserAPI.Refresh();
    }
    
    var _UpdateTooltip = function( isDisabled ) 
    {
        var OnMouseOver = function()
        {
            var tooltipText = isDisabled === true ? '#advertising_for_hire_tooltip_disabled' : '#advertising_for_hire_tooltip';
            UiToolkitAPI.ShowTitleTextTooltip( _m_elBtn.id, '#advertising_for_hire_tooltip_title', tooltipText );
        };
        
        _m_elBtn.SetPanelEvent( 'onmouseover', OnMouseOver );
        _m_elBtn.SetPanelEvent( 'onmouseout', function() { UiToolkitAPI.HideTitleTextTooltip(); } );
    };


    return {
        Init: _Init,
        OnFilterPressed: _OnFilterPressed,
        UpdateToggle: _UpdateToggle,
        AdvertisingChanged: _AdvertisingChanged,
        GetAdvertisingSetting: _GetAdvertisingSetting
    };

} )();

                                                                                                    
                                           
                                                                                                    
( function()
{
    AdvertisingToggle.Init();
    $.RegisterForUnhandledEvent( 'PanoramaComponent_PartyBrowser_LocalPlayerForHireAdvertisingChanged', AdvertisingToggle.AdvertisingChanged );
    $.RegisterForUnhandledEvent( "PanoramaComponent_PartyList_RebuildPartyList", AdvertisingToggle.UpdateToggle );
} )();
