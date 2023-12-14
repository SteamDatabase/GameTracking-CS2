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
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY29udGV4dF9tZW51X2xvYmJpZXMuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb250ZXh0X21lbnVzL2NvbnRleHRfbWVudV9sb2JiaWVzLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFDckMsMENBQTBDO0FBRTFDLElBQVUsa0JBQWtCLENBOEozQjtBQTlKRCxXQUFVLGtCQUFrQjtJQUV4QixJQUFJLGVBQWUsR0FBRyxJQUFnQixDQUFDO0lBQ3ZDLElBQUksWUFBWSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSxpQ0FBaUMsQ0FBa0IsQ0FBQztJQUNsSCxJQUFJLGtCQUFrQixHQUFZLEtBQUssQ0FBQztJQUV4QyxTQUFnQixJQUFJLENBQUUsTUFBYztRQUVoQyxJQUFJLFVBQVUsR0FBRyxlQUFlLENBQUMsZUFBZSxFQUFFLENBQUM7UUFDbkQsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLG9CQUFvQixDQUFFLGFBQWEsRUFBRSxVQUFVLENBQUUsQ0FBQztRQUN0RSxJQUFJLGlCQUFpQixHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSx5QkFBeUIsQ0FBRSxDQUFDO1FBRS9GLElBQUssVUFBVSxHQUFJLENBQUMsRUFDMUI7WUFFVSxDQUFDLENBQUMsYUFBYSxDQUFFLGtCQUFrQixFQUFFLEVBQUUsQ0FBRSxDQUFDO1lBQ25ELE9BQU87U0FDUDtRQUVLLElBQUksZUFBZSxHQUFZLEVBQUUsQ0FBQztRQUVsQyxLQUFLLElBQUksQ0FBQyxHQUFHLENBQUMsRUFBRSxDQUFDLEdBQUcsVUFBVSxFQUFFLENBQUMsRUFBRSxFQUN6QztZQUNVLElBQUksSUFBSSxHQUFHLGVBQWUsQ0FBQyxvQkFBb0IsQ0FBRSxDQUFDLENBQUUsQ0FBQztZQUM5RCxlQUFlLENBQUMsSUFBSSxDQUFFLElBQUks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