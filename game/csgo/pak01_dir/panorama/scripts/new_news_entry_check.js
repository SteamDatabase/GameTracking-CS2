"use strict";
/// <reference path="csgo.d.ts" />
var NewNewsEntryCheck;
(function (NewNewsEntryCheck) {
    let _m_RSSFeedReceivedEventHandler = null;
    function GetRssFeed() {
        BlogAPI.RequestRSSFeed();
    }
    NewNewsEntryCheck.GetRssFeed = GetRssFeed;
    function _OnRssFeedReceived(feed) {
        let foundFirstNewsItem = false;
        let lastReadItem = GameInterfaceAPI.GetSettingString('ui_news_last_read_link');
        feed['items'].forEach(function (item, i) {
            if (!foundFirstNewsItem && !item.categories.includes('Minor')) {
                foundFirstNewsItem = true;
                if (item.link != lastReadItem) {
                    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_news.xml', 'date=' + item.date + "&" +
                        'title=' + item.title + "&" +
                        'link=' + item.link);
                    GameInterfaceAPI.SetSettingString('ui_news_last_read_link', item.link);
                }
            }
        });
    }
    function RegisterForRssReceivedEvent() {
        if (!_m_RSSFeedReceivedEventHandler)
            _m_RSSFeedReceivedEventHandler = $.RegisterForUnhandledEvent("PanoramaComponent_Blog_RSSFeedReceived", _OnRssFeedReceived);
    }
    NewNewsEntryCheck.RegisterForRssReceivedEvent = RegisterForRssReceivedEvent;
    function UnRegisterForRssReceivedEvent() {
        if (_m_RSSFeedReceivedEventHandler) {
            $.UnregisterForUnhandledEvent("PanoramaComponent_Blog_RSSFeedReceived", _m_RSSFeedReceivedEventHandler);
            _m_RSSFeedReceivedEventHandler = null;
        }
    }
    NewNewsEntryCheck.UnRegisterForRssReceivedEvent = UnRegisterForRssReceivedEvent;
    {
        GetRssFeed();
    }
})(NewNewsEntryCheck || (NewNewsEntryCheck = {}));
