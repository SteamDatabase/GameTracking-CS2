"use strict";
/// <reference path="../csgo.d.ts" />
/// <reference path="../friendlobby.ts" />
var ContextMenuLobbies;
(function (ContextMenuLobbies) {
    let m_elNewestLobby = null;
    let m_btnGoToNew = $.GetContextPanel().FindChildInLayoutFile('id-context-menu-lobbies-new-btn');
    let m_bSeenNewestLobby = false;
    function Init(elTile) {
        let numInvites = PartyBrowserAPI.GetInvitesCount();
        $.GetContextPanel().SetDialogVariableInt('lobby_count', numInvites);
        let elInviteContainer = $.GetContextPanel().FindChildInLayoutFile('id-context-menu-lobbies');
        if (numInvites < 1) {
            $.DispatchEvent('ContextMenuEvent', '');
            return;
        }
        let xuidsFromUpdate = [];
        for (let i = 0; i < numInvites; i++) {
            let xuid = PartyBrowserAPI.GetInviteXuidByIndex(i);
            xuidsFromUpdate.push(xuid);
        }
        _DeleteTilesNotInUpdate(elInviteContainer, xuidsFromUpdate);
        xuidsFromUpdate.reverse();
        for (let i = 0; i < xuidsFromUpdate.length; i++) {
            let xuid = xuidsFromUpdate[i];
            let elTile = elInviteContainer.FindChildTraverse(xuid);
            if (!elTile)
                _AddTile(elInviteContainer, xuid, i);
            else
                _UpdateTilePosition(elInviteContainer, elTile, xuid, i);
        }
        let elLastItem = elInviteContainer.Children()[elInviteContainer.Children().length - 1];
        if (elLastItem && elLastItem.IsValid()) {
            if (m_elNewestLobby === null) {
                m_elNewestLobby = elLastItem;
            }
            else if (m_elNewestLobby && m_elNewestLobby.IsValid() && m_elNewestLobby.id !== elLastItem.id) {
                m_elNewestLobby = elLastItem;
                m_bSeenNewestLobby = false;
            }
        }
        ShowHideNewLobbiesBtn(elInviteContainer);
        // @ts-ignore 
        elInviteContainer.SetSendScrollPositionChangedEvents(true);
    }
    ContextMenuLobbies.Init = Init;
    ;
    function _DeleteTilesNotInUpdate(elList, xuidsFromUpdate) {
        let children = elList.Children();
        let sectionChildrenCount = children.length;
        for (let i = 0; i < sectionChildrenCount; i++) {
            let panelId = children[i].id;
            if (xuidsFromUpdate.indexOf(panelId) < 0)
                children[i].DeleteAsync(0);
        }
    }
    ;
    function _UpdateTilePosition(elList, elTile, xuid, index) {
        let children = elList.Children();
        if (children[index])
            elList.MoveChildBefore(elTile, children[index]);
        friendLobby.Init(elTile);
    }
    ;
    function ShowHideNewLobbiesBtn(elInviteContainer) {
        $.Schedule(1, () => {
            if (!m_elNewestLobby || !m_elNewestLobby.IsValid()) {
                m_btnGoToNew.SetHasClass('hide', true);
                return;
            }
            if (m_elNewestLobby.BCanSeeInParentScroll() && !m_bSeenNewestLobby) {
                m_btnGoToNew.SetHasClass('hide', true);
                m_bSeenNewestLobby = true;
            }
            else if (!m_elNewestLobby.BCanSeeInParentScroll() && !m_bSeenNewestLobby) {
                m_btnGoToNew.SetHasClass('hide', false);
            }
        });
    }
    ContextMenuLobbies.ShowHideNewLobbiesBtn = ShowHideNewLobbiesBtn;
    function _AddTile(elList, xuid, index) {
        let elTile = $.CreatePanel("Panel", elList, xuid);
        elTile.SetAttributeString('xuid', xuid);
        elTile.BLoadLayout('file://{resources}/layout/friendlobby.xml', false, false);
        _AddTransitionEndEventHandler(elTile);
        elTile.SetAttributeString('showinpopup', 'true');
        friendLobby.Init(elTile);
        elTile.RemoveClass('hidden');
        // @ts-ignore 
        elTile.ListenForScrollIntoView = true;
        $.RegisterEventHandler('ScrolledIntoView', elTile, () => {
        });
        $.Schedule(1, () => {
        });
        return elTile;
    }
    ;
    function _AddTransitionEndEventHandler(elTile) {
        const fnOnPropertyTransitionEndEvent = function (panelName, propertyName) {
            if (elTile.id === panelName && propertyName === 'opacity') {
                if (elTile.visible === true && elTile.BIsTransparent()) {
                    elTile.DeleteAsync(.0);
                    return true;
                }
            }
            return false;
        };
        $.RegisterEventHandler('PropertyTransitionEnd', elTile, fnOnPropertyTransitionEndEvent);
    }
    ;
    function OnPressGotoNew() {
        let elPanel = $.GetContextPanel().FindChildInLayoutFile('id-context-menu-lobbies');
        elPanel.ScrollToBottom();
    }
    ContextMenuLobbies.OnPressGotoNew = OnPressGotoNew;
})(ContextMenuLobbies || (ContextMenuLobbies = {}));
(function () {
    $.RegisterForUnhandledEvent('PanoramaComponent_PartyBrowser_InviteConsumed', ContextMenuLobbies.Init);
    $.RegisterForUnhandledEvent('PanoramaComponent_PartyBrowser_InviteReceived', ContextMenuLobbies.Init);
    let elLister = $.GetContextPanel().FindChildInLayoutFile('id-context-menu-lobbies');
    //@ts-ignore
    elLister.SetSendScrollPositionChangedEvents(true);
    $.RegisterEventHandler('ScrollPositionChanged', elLister, ContextMenuLobbies.ShowHideNewLobbiesBtn);
})();
