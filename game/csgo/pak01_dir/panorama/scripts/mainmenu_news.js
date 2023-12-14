'use strict';

var NewsPanel = (function () {

	var _GetRssFeed = function()
	{
		BlogAPI.RequestRSSFeed();
	}

	var _OnRssFeedReceived = function( feed )
	{

		                                          

		if( $.GetContextPanel().BHasClass( 'news-panel--hide-news-panel' ) )
		{
			return;
		};
		
		var elLister = $.GetContextPanel().FindChildInLayoutFile( 'NewsPanelLister' );

		if ( elLister === undefined || elLister === null || !feed )
			return;

		elLister.RemoveAndDeleteChildren();

		                                     
		var foundFirstNewsItem = false;

		feed[ 'items' ].forEach( function( item, i )
		{
			var elEntry = $.CreatePanel( 'Panel', elLister, 'NewEntry' + i, {
				acceptsinput: true
			} );

			var lastReadItem = GameInterfaceAPI.GetSettingString( 'ui_news_last_read_link' );

			                                                           
			                                                                     
			var popupEnable = false;
			if ( !foundFirstNewsItem && !item.categories.includes( 'Minor' ) && popupEnable )
			{
				foundFirstNewsItem = true;

				                                             
				elEntry.AddClass( 'new' );

				if ( item.link != lastReadItem )
				{
					UiToolkitAPI.ShowCustomLayoutPopupParameters( '', 'file://{resources}/layout/popups/popup_news.xml',
						'date=' + item.date + "&" + 
						'title=' + item.title + "&" + 
						'link=' + item.link );
				}

				GameInterfaceAPI.SetSettingString( 'ui_news_last_read_link', item.link );
			}

			                          
			                                                                             
			                                                      

			elEntry.BLoadLayoutSnippet( 'featured-news-full-entry' );
			var elImage = elEntry.FindChildInLayoutFile( 'NewsHeaderImage' );
			if ( item.imageUrl )
			{
				elImage.SetImage( item.imageUrl );
			}
			else
			{
				elImage.SetImage( "file://{images}/store/default-news.png" );
			}

			var elEntryInfo = $.CreatePanel( 'Panel', elEntry, 'NewsInfo' + i );
			elEntryInfo.BLoadLayoutSnippet( 'featured-news-info' );

			elEntryInfo.SetDialogVariable( 'news_item_date', item.date );
			elEntryInfo.SetDialogVariable( 'news_item_title', item.title );
			elEntryInfo.SetDialogVariable( 'news_item_body', item.description );

			                       
			elEntry.BLoadLayoutSnippet( 'history-news-full-entry' );
			var elImage = elEntry.FindChildInLayoutFile( 'NewsHeaderImage' );
			if ( item.imageUrl )
			{
				elImage.SetImage( item.imageUrl );
			}
			else
			{
				elImage.SetImage( "file://{images}/store/default-news.png" );
			}

			var elEntryInfo = $.CreatePanel( 'Panel', elEntry, 'NewsInfo' + i );
			elEntryInfo.BLoadLayoutSnippet( 'history-news-info' );

			elEntryInfo.SetDialogVariable( 'news_item_date', item.date );
			elEntryInfo.SetDialogVariable( 'news_item_title', item.title );
			elEntryInfo.SetDialogVariable( 'news_item_body', item.description );
			

			         
			elEntry.FindChildInLayoutFile( 'NewsEntryBlurTarget' ).AddBlurPanel( elEntryInfo );

			elEntry.SetPanelEvent( "onactivate", function( link, elEntry, clearNew )
			{
				SteamOverlayAPI.OpenURL( link );

				if ( clearNew )
				{
					GameInterfaceAPI.SetSettingString( 'ui_news_last_read_link', link );
					elEntry.RemoveClass( 'new' );
				}

			}.bind( SteamOverlayAPI, item.link, elEntry, i == 0 ) );
		
		} );
	};

	return {
		GetRssFeed			: _GetRssFeed,
		OnRssFeedReceived: _OnRssFeedReceived,
	};
})();

( function()
{
	NewsPanel.GetRssFeed();
	$.RegisterForUnhandledEvent( "PanoramaComponent_Blog_RSSFeedReceived", NewsPanel.OnRssFeedReceived );
})();


