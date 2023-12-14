"use strict";

                                                                                                    
                                                                                         
                                                                                               
  
                                                                                                            
                                                                                                                 
  
                                                                                              
  
                                                      
                                                                                          
  
                                                                                                    

( function() {
    $.DefineEvent( 'SidebarContextMenuActive', 1, 'bActive', 'Let the sidebar panel know if a context menu is active on a section of it.' );
    $.DefineEvent( 'SidebarIsCollapsed', 1, 'bActive', 'Is sidebar collapsed.' );
    $.DefineEvent( 'InventoryItemPreview', 1, 'itemId', 'Just itemid' );
    $.DefineEvent( 'LootlistItemPreview', 2, 'itemId', 'typeParams', 'Requesting an item preview popup for the given item id. typeParams, caseid, key id' );
    $.DefineEvent( 'ShowXrayCasePopup', 3, 'toolid', 'caseId', 'showpopup', 'The case id for the container to xray' );
    $.DefineEvent( 'HideContentPanel', 0, 'no args', 'Hide all the content panels and show the default home dashboard' );
    $.DefineEvent( 'ShowContentPanel', 0, 'no args', 'Show a content panel' );
    $.DefineEvent( 'InitAvatar', 2, 'xuid, type of panel', 'Update the avatar panel data for a xuid' );
    $.DefineEvent( 'ForceRestartVanity', 0, '' );
    $.DefineEvent( 'OpenPlayMenu', 0, 'no args', 'opens the play menu from anywhere. EXAMPLE from party menu settings button from client' );
    $.DefineEvent( 'OpenInventory', 0, 'no args', 'opens the inventory menu from anywhere.' );
    $.DefineEvent( 'OpenWatchMenu', 0, 'no args', 'opens the watch menu from anywhere.' );
    $.DefineEvent( 'OpenStatsMenu', 0, 'no args', 'opens the stats page from anywhere.' );
    $.DefineEvent( 'OpenSubscriptionUpsell', 0, 'no args', 'Open the upsell popup' );
    $.DefineEvent( 'OpenSidebarPanel', 1, 'auto close', 'open the sidebar from a abutton click from anywhere pass setting if you wasnt it to autoclose' );
    $.DefineEvent( 'StartDecodeableAnim', 0, 'no args', 'tells the decode panel to play the animation' );
    $.DefineEvent( 'HideMainMenuNewsPanel', 0, 'no args', 'hide mainmenu news panel' )
    $.DefineEvent( 'StreamPanelClosed', 0, '', "Notify that user has closed stream panel" );

    $.DefineEvent( 'Scoreboard_CycleStats', 0, '', "Cycle the stats." );
    
    $.DefineEvent( 'MainMenuSwitchVanity', 1, 'team', '' );
	$.DefineEvent( 'MainMenuGoToCharacterLoadout', 1, 'team', '' );
	$.DefineEvent( 'MainMenuGoToSettings', 0, '', "Got to the settings screen." );

              
                                                                                                                    
              
    $.DefineEvent( 'Scoreboard_UnborrowMusicKit', 0, '', "Cancel Music Kit borrowing" );

    $.DefineEvent( 'Scoreboard_MuteVoice', 0, '', "Toggle voice_enable" );
    $.DefineEvent( 'Scoreboard_BlockUgc', 0, '', "Toggle avatar anonymity" );
    
    $.DefineEvent( 'Scoreboard_Casualties_OnMouseOver', 0, '', '' );
	$.DefineEvent( 'Scoreboard_Casualties_OnMouseOut', 0, '', '' );
	$.DefineEvent( 'Scoreboard_RoundLossBonusMoney_OnMouseOver_CT', 0, '', '' );
	$.DefineEvent( 'Scoreboard_RoundLossBonusMoney_OnMouseOut_CT', 0, '', '' );
	$.DefineEvent( 'Scoreboard_RoundLossBonusMoney_OnMouseOver_TERRORIST', 0, '', '' );
	$.DefineEvent( 'Scoreboard_RoundLossBonusMoney_OnMouseOut_TERRORIST', 0, '', '' );
    $.DefineEvent( 'ShowAcceptPopup', 1, 'popup', 'Fired when accept match popup is shown.' );
    $.DefineEvent( 'CloseAcceptPopup', 0, '', 'Fired when accept match popup Closes.' );

    $.DefineEvent( 'ShowTournamentStore', 0, '', 'Show tournament store popup' );
	$.DefineEvent( 'ShowTournamentStorePassPopup', 0, '', 'Popup the passes in the tournament store' );
	$.DefineEvent( 'FilterStoreCouponsDisplay', 1, 'action', 'Filter displayed coupons {apply|clear}' );
    $.DefineEvent( 'AddItemToCart', 1, 'itemID', 'Add an itemid to tournament store shopping cart' );
    $.DefineEvent( 'RemoveItemFromCart', 1, 'itemID', 'Remove an item of this id from the tournament store shopping cart' );

    $.DefineEvent( 'CloseSubMenuContent', 0, 'no args', 'Closes up the submenu panel' );
    $.DefineEvent( 'NavigateToTab', 4, 'tab name, xml name, If its a tab, if you should add to stack', 'Closes up the submenu panel' );
                                                                                                                
    $.DefineEvent( 'InitializeTournamentsPage', 1, 'tournament ID', 'Loads the layout for a given tournament for active tournament tab' );
    $.DefineEvent( 'ShowActiveTournamentPage', 1, 'tab to show id', 'Opens active tournament page in the watch panel' );
	$.DefineEvent( 'RefreshPickemPage', 1, 'tournament ID', 'refreshed pickem data' );
	
	$.DefineEvent( 'Tournaments_RequestMatch', 1, 'matchId', 'Request match jso as string by match id' );
	$.DefineEvent( 'Tournaments_RequestMatch_Response', 1, 'matchString', 'Return match jso as string' );

                                                                                                                            
                                                                                                                      
    $.DefineEvent( 'PlayMenu_GoTeamMatchmaking_CodeGenerated', 0, 'no args', 'Updates the generated direct challenge code in UI' );
    $.DefineEvent( 'FriendInvitedFromContextMenu', 1, 'xuid', 'invite friend from the playercard. Make the invite anim snow immediately instead of waiting for the callback that can take a long time.' );
    $.DefineEvent( 'CapabilityPopupIsOpen', 1, 'bActive', 'User is using the name tag or opening a case, or stickering.  Using one of the capabilites' );
    $.DefineEvent( 'PromptShowSelectItemForCapabilityPopup', 5, 'titletxt,msgtxt,capability, itemid, itemid2', 'Show popup in Inventory before dispatching ShowSelectItemForCapabilityPopup' );
    $.DefineEvent( 'ShowSelectItemForCapabilityPopup', 3, 'capability, itemid, itemid2', 'Show popup in Inventory that allow you to select a second item for a capability that requires 2 items' );
    $.DefineEvent( 'UpdateSelectItemForCapabilityPopup', 3, 'capability, itemid, bSelected', 'Update this popup in inventory' );
    $.DefineEvent( 'HideSelectItemForCapabilityPopup', 0, '', 'Hide this popup in inventory' );
    $.DefineEvent( 'ShowLoadoutForItem', 1, 'itemId', 'Open loadout panel for an item' );
    $.DefineEvent( 'ShowAcknowledgePopup', 2, 'updatetype, itemid', 'show acknowledge popup, also takes params for when an item is updated but does not need to be acknowledged like after using a nametag' );
    $.DefineEvent( 'RefreshActiveInventoryList', 0, '', 'Make the active list get the items in it' );
    $.DefineEvent( 'ShowDeleteItemConfirmationPopup', 1, 'itemid', 'When a user is trying to delete an item from inventory' );
    $.DefineEvent( 'ShowUseItemOnceConfirmationPopup', 1, 'itemid', 'When a user is trying to use an item from inventory that can be used once' );
    $.DefineEvent( 'ShowResetMusicVolumePopup', 1, 'itemid', 'When a user is trying to equip a musickit but has thier music volume off from inventory' );
    $.DefineEvent( 'ShowTradeUpPanel', 0, '', 'Show trade up panel' );
    $.DefineEvent( 'UpdateTradeUpPanel', 0, '', 'Update trade up panel' );
    $.DefineEvent( 'MainMenuTabShown', 1, 'tabid', 'Alert main menu tabs when they are shown, in case there is a data update needed' );
    $.DefineEvent( 'CloseOperationHub', 0, '', 'Closes Operation Hub' );
    $.DefineEvent( 'BlurOperationPanel', 0, '', 'Fires we want to blur the operation panel' );
    $.DefineEvent( 'UnblurOperationPanel', 0, '', 'Fires when other popup panels close to unblur the operation panel' );

    $.DefineEvent( 'MainMenu_OnGoToCharacterLoadoutPressed', 0, '', '' );
    $.DefineEvent( 'MainMenu_OnLockVanityModelToggle', 0, '', '' );
	$.DefineEvent( 'SettingsMenu_NavigateToSetting', 2, 'category, settingPanelID', 'Takes cateogry eg "GAME" or "KBMOUSE" and contained setting ID, opens that category and scrolls to the settting matching the id.' );
	$.DefineEvent( 'SettingsMenu_NavigateToSettingPanel', 3, 'category, subcategory, settingPanel', 'Navigates to a setting by panel handle' );

	$.DefinePanelEvent( "MainMenu_PromotedSettingsViewed", 0, "", "Fired when user views new settings." )

	$.DefinePanelEvent( "Scoreboard_ApplyPlayerCrosshairCode", 1, "xuid", "Fired to handle confirmation popup when copying player crosshair codes" )

    $.DefineEvent( 'PlayerStats_PopupSingleMatch', 1, 'matchid', '' );
    $.DefineEvent( 'PlayerStats_DismissSingleMatch', 1, 'matchid', '' );
    $.DefineEvent( 'PlayerStats_MatchListerGoToMostRecent', 0, "", "" );

    $.DefineEvent( 'DirectChallenge_GenRandomKey', 0, "", "" );
    $.DefineEvent( 'DirectChallenge_EditKey', 0, "", "" );
    $.DefineEvent( 'DirectChallenge_CopyKey', 0, "", "" );
    $.DefineEvent( 'DirectChallenge_ChooseClanKey', 0, "", "" );
    $.DefineEvent( 'DirectChallenge_ClanChallengeKeySelected', 1, "challengekey", "" );    



} )();