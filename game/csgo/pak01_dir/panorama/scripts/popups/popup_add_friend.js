'use strict';

var PopupAddFriend = ( function(){

	var m_xuidToInvite = '';

	var _Init = function() 
	{
		var yourCode = MyPersonaAPI.GetFriendCode();
		
		var onMouseOver = function()
		{
			UiToolkitAPI.ShowTextTooltip( 'JsPopupYourFriendCode', yourCode );
		}

		var onMouseOut = function()
		{
			UiToolkitAPI.HideTextTooltip();
		}
		
		var onActivate = function()
		{
			SteamOverlayAPI.CopyTextToClipboard( yourCode );
			UiToolkitAPI.ShowTextTooltip( 'JsPopupYourFriendCode', '#AddFriend_copy_code_Hint' );
		}

		var elYourCodeBtn = $( '#JsPopupYourFriendCode' );

		elYourCodeBtn.SetPanelEvent( 'onmouseover', onMouseOver );
		elYourCodeBtn.SetPanelEvent( 'onmouseout', onMouseOut );
		elYourCodeBtn.SetPanelEvent( 'onactivate', onActivate );

		                                         
		$( '#JsPopupYourSendRequest' ).enabled = false;

		                                                 
		$( '#JsFriendCodeNotFound' ).visible = false;
		$( '#JsFriendCodeFound' ).visible = false;

		$( '#JsAddFriendTextEntryLabel' ).SetFocus();
		$( '#JsAddFriendTextEntryLabel' ).SetPanelEvent( 'ontextentrychange', _OnEntrySubmit );

		                           
	};

	var _SetUpEnterTextButton = function()
	{
		var elBtn = $.GetContextPanel().FindChildTraverse( 'JsEnterNameBtn' );
		elBtn.SetPanelEvent( 'onactivate', _OnEntrySubmit );
	};

	var _OnEntrySubmit = function ()
	{
		var elNotFoundLabel = $( '#JsFriendCodeNotFound' ),
		elTextEntry = $( '#JsAddFriendTextEntryLabel' );

		var xuid = FriendsListAPI.GetXuidFromFriendCode( elTextEntry.text.toUpperCase() );
		
		if( xuid )
		{
			              
			var elTile = $.GetContextPanel().FindChildTraverse( 'JsPopupFriendTile' );

			if( !elTile )
			{
				elTile = $.CreatePanel( "Panel", $( '#JsFriendCodeFound' ), 'JsPopupFriendTile' );
				elTile.SetAttributeString( 'xuid', xuid );
				elTile.BLoadLayout('file://{resources}/layout/friendtile.xml', false, false);
			}
			
			                                                               
			$.Schedule( .1, function () { 
				friendTile.Init( elTile ); 
				elTile.RemoveClass( 'hidden' );
			});

			$( '#JsAddFriendInviteImg' ).AddClass('hidden');
			$( '#JsFriendCodeFound' ).visible = true;
			$( '#JsPopupYourSendRequest' ).enabled = true;

			elNotFoundLabel.visible = false;
			$.GetContextPanel().FindChildInLayoutFile( 'JSFriendValidIcon' ).SetHasClass( 'valid', true );

			m_xuidToInvite = xuid;
		}
		else
		{
			if( elTextEntry.text === '' )
			{
				elNotFoundLabel.visible = false;
				return;
			}
			
			                          
			elNotFoundLabel.SetDialogVariable( 'code', elTextEntry.text.toUpperCase() );
			elNotFoundLabel.text = $.Localize( '#AddFriend_not_found', elNotFoundLabel );
			$.GetContextPanel().FindChildInLayoutFile( 'JSFriendValidIcon' ).SetHasClass( 'valid', false );
			
			elNotFoundLabel.visible = true;

			$( '#JsPopupYourSendRequest' ).enabled = false;
			$( '#JsFriendCodeFound' ).visible = false;
		}
	};

	var _OnSendInvite = function ()
	{
		$( '#JsAddFriendInviteImg' ).RemoveClass('hidden');
		$( '#JsPopupYourSendRequest' ).enabled = false;
		SteamOverlayAPI.InteractWithUser( m_xuidToInvite, 'friendadd' );
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	};

	var _OnCancelEntry = function ()
	{
		
	};

	var _FriendsListUpdateName = function( xuid )
	{
		var elTile = $.GetContextPanel().FindChildTraverse( 'JsPopupFriendTile' );

		if ( elTile && elTile.IsValid() && ( xuid === elTile.GetAttributeString( 'xuid', '' )))
		{
			friendTile.Init( elTile ); 
		}
	};

	return {
		Init:	_Init,
		OnSendInvite:	_OnSendInvite,
		OnCancelEntry:	_OnCancelEntry,
		OnEntrySubmit: _OnEntrySubmit,
		FriendsListUpdateName: _FriendsListUpdateName
	};

} )();

                                                                                                    
                                            
                                                                                                    
(function()
{
	
	$.RegisterForUnhandledEvent( 'PanoramaComponent_FriendsList_NameChanged', PopupAddFriend.FriendsListUpdateName );
})();