'use strict';

var InventorySearch = ( function (){

	var m_elList = $.GetContextPanel().FindChildInLayoutFile( 'ContextMenuSearchResultsList' );
	var m_elTextEntry = $.GetContextPanel().FindChildInLayoutFile( 'InventorySearchInput' );
	var m_elNoResults = $.GetContextPanel().FindChildInLayoutFile( 'SearchNoResults' );
	var m_elSuggestedSearches = $.GetContextPanel().FindChildInLayoutFile( 'SuggestedSearchEntries' );
	
	var _Init = function ()
	{
		m_elTextEntry.SetFocus();
		_PopulateSuggested();
	}

	var _UpdateItemList = function () {

		                            
		
		$.DispatchEvent('SetInventoryFilter',
			m_elList,
			'any',
			'any',
			'any',
			'',
			'',
			m_elTextEntry.text
		);

		_ShowHidePopular( m_elTextEntry.text === '' );
		$.Schedule(.15, _NoSearchResults.bind( undefined, m_elTextEntry.text === '' ));
	}

	var _ShowHidePopular = function ( show )
	{
		m_elList.visible = !show;
		m_elSuggestedSearches.visible  = show;
	}

	var _NoSearchResults = function ( hide )
	{
		if( hide )
		{
			m_elNoResults.SetHasClass( 'hidden', true );
			return;
		}
		
		var count = m_elList.Children().length;
		if( count > 0 )
		{
			m_elNoResults.SetHasClass( 'hidden', true );
			return;
		}

		m_elNoResults.SetHasClass( 'hidden', false );
		
		var elLabel = $.GetContextPanel().FindChildInLayoutFile( 'SearchNoResultsLabel' );
		elLabel.SetDialogVariable( 'search_text', m_elTextEntry.text );
		elLabel.text = $.Localize( '#inv_search_no_results', elLabel );
	}

	var _OnSuggestedPressed = function ( selectedEntryText )
	{
		m_elTextEntry.text = selectedEntryText;
	}

	var _PopulateSuggested = function ()
	{
		var settings = {
			0: ['inv_sort_rarity', 'melee'],
			1: ['inv_sort_age', 'not_equipment'],
			2: ['inv_sort_rarity', 'rifle'],
			3: ['inv_sort_age', 'flair0'],
			4: ['inv_sort_rarity', 'smg'],
			5: ['inv_sort_age', 'spray'],
			6: ['inv_sort_rarity', 'secondary']
		};

		for (var entry of Object.values(settings)) {  
			var id = _GetSuggested( entry[0], entry[1] );

			if( id !== '' )
				_AddSuggestedEntry( id );
		}
	}

	var _GetSuggested = function ( sortType, searchText )
	{
		InventoryAPI.SetInventorySortAndFilters ( sortType, false, searchText, '', '' );
		var count = InventoryAPI.GetInventoryCount();
		var itemsList = [];
		var itemsValid = 0;
		var itemsNeedToCollect = 5;
		for( var i = 0 ; i < count ; i++ )
		{
			var itemId = InventoryAPI.GetInventoryItemIDByIndex(i);
			if (itemId !== ItemInfo.IsEquippedForCT &&
				itemId !== ItemInfo.IsEquippedForT &&
				itemId !== ItemInfo.IsEquippedForNoTeam) {
					itemsValid++;
					itemsList.push(itemId);
			}

			if ( itemsValid > itemsNeedToCollect )
				break;
		}

		var countValidItems = itemsList.length
		if( countValidItems > 0 )
		{
			var index = countValidItems > itemsNeedToCollect ?
				Math.floor(Math.random() * itemsNeedToCollect) :
				Math.floor(Math.random() * countValidItems);

			return itemsList[ index ];
		}

		return '';
	}

	var _AddSuggestedEntry = function ( id )
	{
		var elEntry = $.CreatePanel( 'Panel', m_elSuggestedSearches, id );
		elEntry.BLoadLayoutSnippet( 'SuggestedEntry' );

		var itemName = ItemInfo.GetName(id);
		elEntry.SetPanelEvent( 'onactivate', function(){
			InventorySearch.OnSuggestedPressed( itemName );
		});
		
		var elLabel = elEntry.FindChildInLayoutFile( 'SuggestedLabel');
		elLabel.text = ItemInfo.GetName(id);
		elLabel.style.washColor = ItemInfo.GetRarityColor(id);
	}

	return {

		Init   : _Init,
		OnEntryChanged : _UpdateItemList,
		OnSuggestedPressed : _OnSuggestedPressed,
		NoSearchResults : _NoSearchResults
	}
}());

                                                                                                    
                                           
                                                                                                    
(function()
{
})();