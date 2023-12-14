'use strict';

var PopupRedeemSouvenir = ( function()
{
    var m_scheduleHandle = null;
    var m_tournamentIndex = null;
	var m_matchId = '';
	var m_redeemsAvailable = 0;
    
    var _Init = function()
	{
        $.GetContextPanel().FindChildInLayoutFile( 'popup-redeem-spinner' ).visible = false;
        m_tournamentIndex = $.GetContextPanel().GetAttributeString( "tournamentindex", "" );
        m_matchId = $.GetContextPanel().GetAttributeString( "matchid", "" );

        if ( !m_tournamentIndex || !m_matchId )
        {
            _OnClose();
            return;
        }

        _SetMatchTile();
        _SetDescText();
    };
    
    var _SetMatchTile = function()
    {
        var elMatchtile = $.CreatePanel( 'Panel', $.GetContextPanel().FindChildInLayoutFile( 'id-popup-matchtile-redeem' ),
            'id-match-tile',
            {
                class: 'MatchTile--Redeem'
            }
        );

        elMatchtile.matchId = m_matchId;
        
        elMatchtile.BLoadLayout( 'file://{resources}/layout/matchtiles/tournament.xml', false, false );
        elMatchtile.RemoveClass( 'MatchTile--Collapse' );
        watchTile.Init( elMatchtile );
    };

    var _SetDescText = function()
    {
        var coinId = InventoryAPI.GetActiveTournamentCoinItemId( m_tournamentIndex );
        var elLabel = $.GetContextPanel().FindChildInLayoutFile( 'MessageLabel' );
        if ( !coinId || coinId === '0' || coinId === 0 )
        {
            elLabel.visible = false;
            return;
        }

		var coinLevel = InventoryAPI.GetItemAttributeValue( coinId, "upgrade level" );
		
		var coinRedeemsPurchased = InventoryAPI.GetItemAttributeValue( coinId, "operation drops awarded 1" );
		if ( coinRedeemsPurchased )                                                                          
			coinLevel += coinRedeemsPurchased;

        var redeemed = InventoryAPI.GetItemAttributeValue( coinId, "operation drops awarded 0" );
		var redeemsAvailable = coinLevel - redeemed;
		m_redeemsAvailable = redeemsAvailable;

        elLabel.SetDialogVariableInt( 'redeems', redeemsAvailable );

        elLabel.text = ( redeemsAvailable > 1 ) ?
            $.Localize( '#popup_redeem_souvenir_desc', elLabel ) :
            $.Localize( '#popup_redeem_souvenir_desc_single', elLabel );
        
        elLabel.visible = true;
    };

    var _OnRedeem = function()
    {
        _ResetTimeouthandle();

        var coinId = InventoryAPI.GetActiveTournamentCoinItemId( m_tournamentIndex );
        if ( !coinId || coinId === '0' || coinId === 0)
        {
            return;
		}
		
		if ( m_redeemsAvailable <= 0 )
		{	                                                                                      
			_OnClose();

			UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/popups/popup_tournament_journal.xml',
				'journalid=' + coinId
			);

			return;
		}

        m_scheduleHandle = $.Schedule( 5, _CancelWaitforCallBack.bind( undefined, $.GetContextPanel() ) );
        $.GetContextPanel().FindChildInLayoutFile( 'popup-redeem-spinner' ).visible = true;
        $.GetContextPanel().FindChildInLayoutFile( 'id-popup-redeem-btn' ).visible = false;

        MatchInfoAPI.RequestMatchTournamentSouvenir( m_matchId, coinId );
    };

    var _ItemCustomizationNotification = function( numericType, type, itemid )
    {
        _ResetTimeouthandle();
        
        if ( type === 'souvenir_generated' )
        {
            InventoryAPI.AcknowledgeNewItembyItemID( itemid );

            UiToolkitAPI.ShowCustomLayoutPopupParameters(
                '',
                'file://{resources}/layout/popups/popup_inventory_inspect.xml',
                'itemid=' + itemid +
                '&' + 'inspectonly=true' +
                '&' + 'showcharselect=false' +
                '&' + 'showequip=false' +
                '&' + 'showmarketlink=false' +
                '&' + 'showitemcert=false' +
                '&' + 'allowsave=false'+
                'none'
            );

            _OnClose();
        }
    };

    var _ResetTimeouthandle = function()
	{
		if ( m_scheduleHandle )
		{
			$.CancelScheduled( m_scheduleHandle );
			m_scheduleHandle = null;
		}
	};

    var _CancelWaitforCallBack = function( elPanel )
	{
		m_scheduleHandle = null;
		
        var elPanel = $.GetContextPanel();
        if ( !elPanel || !elPanel.IsValid() )
        {
            return;
        }

        elPanel.FindChildInLayoutFile( 'popup-redeem-spinner' ).visible = false;

        $.DispatchEvent( 'UIPopupButtonClicked', '' );

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
    
    var _OnClose = function()
    {
        _ResetTimeouthandle();
        $.DispatchEvent( 'UIPopupButtonClicked', '' );
    }

    return {
        Init: _Init,
        OnRedeem: _OnRedeem,
        OnClose: _OnClose,
        ItemCustomizationNotification: _ItemCustomizationNotification

    };
} )();


( function()
{
    $.RegisterForUnhandledEvent( 'PanoramaComponent_Inventory_ItemCustomizationNotification', PopupRedeemSouvenir.ItemCustomizationNotification );
} )();