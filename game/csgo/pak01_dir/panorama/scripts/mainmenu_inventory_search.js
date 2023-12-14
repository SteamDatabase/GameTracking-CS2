'use strict';

var InventorySearch = ( function (){

	var m_elList = null;
	var m_elSearchPanel = $.GetContextPanel();
	var m_elSuggestedPanel = null;
	var m_InventoryUpdatedHandler = null;

	var _Init = function()
	{
		_RegisterForInventoryUpdate();
		
		var elTextEntry = m_elSearchPanel.FindChildInLayoutFile( 'InvSearchTextEntry' );
		elTextEntry.SetPanelEvent( 'ontextentrychange', InventorySearch.OnEntryChanged );
 
		_PopulateSuggested( m_elSearchPanel.FindChildInLayoutFile( 'InvSearchSuggestionsList' ) );
		_TextEntrySettings.SetTextEntryPanel( elTextEntry );

		m_elSuggestedPanel = m_elSearchPanel.FindChildInLayoutFile( 'InvSearchSuggestions' );
		m_elList = m_elSearchPanel.FindChildInLayoutFile( 'InvSearchPanel-List' );

		_AddSortDropdownEntries();
		_UpdateItemList();
	};

	var _RegisterForInventoryUpdate = function()
	{
		m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', _UpdateItemList );
		m_elSearchPanel.RegisterForReadyEvents( true );

		$.RegisterEventHandler( 'ReadyForDisplay', m_elSearchPanel, function()
		{
			if ( !m_InventoryUpdatedHandler )
			{
				m_InventoryUpdatedHandler = $.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', _UpdateItemList );
			}
		} );

		$.RegisterEventHandler( 'UnreadyForDisplay', m_elSearchPanel, function()
		{
			if ( m_InventoryUpdatedHandler )
			{
				$.UnregisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', m_InventoryUpdatedHandler );
				m_InventoryUpdatedHandler = null;
			}
		} );
	};
	
	var _UpdateItemList = function() 
	{
		if ( !m_elList )
		{
			return;
		}

		var filterString = _TextEntrySettings.GetText();
		if ( filterString === '' )
		{
			_ShowHideSuggestedPanel( true );
		}
		else
		{
			var sortText = m_elSearchPanel.FindChildInLayoutFile( 'InvSortDropdown' ).GetSelected().id;

			$.DispatchEvent(
				'SetInventoryFilter',
				m_elList,
				'any',
				'any',
				'any',
				sortText,
				'',
				filterString
			);

			_ShowHideSuggestedPanel( m_elList.count < 1 );
		}
	};

	var _TextEntrySettings = ( function( selectedEntryText )
	{
		var elTextEntry = null;

		var _SetTextEntryPanel = function( elPanel )
		{
			elTextEntry = elPanel;
		};

		var _UpdateText = function( selectedEntryText )
		{
			elTextEntry.text = selectedEntryText;
		};

		var _GetText = function( )
		{
			if ( elTextEntry )
			{
				return elTextEntry.text;
			}
		};

		return {
			SetTextEntryPanel: _SetTextEntryPanel,
			UpdateText: _UpdateText,
			GetText : _GetText
		};
	} )();

	var _PopulateSuggested = function( elSearchResults )
	{
		var settings = {
			0: [ 'inv_sort_rarity', 'melee' ],
			1: [ 'inv_sort_age', 'not_equipment' ],
			2: [ 'inv_sort_rarity', 'rifle' ],
			3: [ 'inv_sort_age', 'flair0' ],
			4: [ 'inv_sort_rarity', 'smg' ],
			5: [ 'inv_sort_age', 'spray' ],
			6: [ 'inv_sort_rarity', 'secondary' ]
		};

		var delay = 0.25;
		var count = 0;
		for ( var entry of Object.values( settings ) )
		{
			count++;
			$.Schedule( count*delay, function( sortType, searchText ) 
			{
				var id = _GetSuggested( sortType, searchText );

				if ( id !== '' )
					_AddSuggestedEntry( id, elSearchResults );
			}.bind( undefined, entry[ 0 ], entry[ 1 ] ) );
		}
	};

	var _GetSuggested = function( sortType, searchText )
	{
		InventoryAPI.SetInventorySortAndFilters( sortType, false, searchText, '', '' );
		var count = InventoryAPI.GetInventoryCount();
		var itemsList = [];
		var itemsValid = 0;
		var itemsNeedToCollect = 5;
		for ( var i = 0; i < count; i++ )
		{
			var itemId = InventoryAPI.GetInventoryItemIDByIndex( i );
			if ( itemId !== ItemInfo.IsEquippedForCT &&
				itemId !== ItemInfo.IsEquippedForT &&
				itemId !== ItemInfo.IsEquippedForNoTeam )
			{
				itemsValid++;
				itemsList.push( itemId );
			}

			if ( itemsValid > itemsNeedToCollect )
				break;
		}

		var countValidItems = itemsList.length;
		if ( countValidItems > 0 )
		{
			var index = countValidItems > itemsNeedToCollect ?
				Math.floor( Math.random() * itemsNeedToCollect ) :
				Math.floor( Math.random() * countValidItems );

			return itemsList[ index ];
		}

		return '';
	};

	var _AddSuggestedEntry = function( id, elSearchResults )
	{
		var elEntry = $.CreatePanel( 'Panel', elSearchResults, id );
		elEntry.BLoadLayoutSnippet( 'SuggestedEntry' );

		var itemName = ItemInfo.GetName( id );
		elEntry.SetPanelEvent( 'onactivate', function()
		{
			_TextEntrySettings.UpdateText( itemName );
		} );
		
		elEntry.SetDialogVariable( 'suggestion_text', itemName );

		var elImage = elEntry.FindChildInLayoutFile( 'SuggestedImage' );
		elImage.itemid = id;

		var elPanel = elEntry.FindChildInLayoutFile( 'SuggestedRarity' );
		elPanel.style.washColor = ItemInfo.GetRarityColor( id );
	};

	var _ShowHideSuggestedPanel = function( bShow )
	{
		m_elSuggestedPanel.SetHasClass( 'collapse', !bShow );
		m_elList.SetHasClass( 'hide', bShow );
	};

	var _AddSortDropdownEntries = function()
{
		var elDropdown = m_elSearchPanel.FindChildInLayoutFile( 'InvSortDropdown' );
		elDropdown.SetPanelEvent('oninputsubmit', _UpdateItemList );

		var count = InventoryAPI.GetSortMethodsCount();

		for (var i = 0; i < count; i++) 
		{
			var sort = InventoryAPI.GetSortMethodByIndex(i);
			var newEntry = $.CreatePanel('Label', elDropdown, sort, {
				class: 'DropDownMenu'
			});

			newEntry.text = $.Localize('#'+sort);
			elDropdown.AddOption(newEntry);
		}

		                        
		elDropdown.SetSelected( InventoryAPI.GetSortMethodByIndex( 0 ) );
	};

	return {
		Init: _Init,
		OnEntryChanged: _UpdateItemList,
		UpdateItemList: _UpdateItemList,
		GetFilterString: _TextEntrySettings.GetText
	};
}());

                                                                                                    
                                           
                                                                                                    
(function()
{
	 InventorySearch.Init();
})();