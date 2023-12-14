'use strict';

var EquipNotification = ( function()
{
	var _ShowNotification = function( elPanel, slot, itemId )
	{
		if ( !elPanel || !InventoryAPI.IsItemInfoValid( itemId ) )
			return;
		
		if ( elPanel.BHasClass( 'show' ) )
		{
			elPanel.RemoveClass( 'show' );
		}

		if ( itemId === '0' )
		{
			_DisplayNotification( elPanel, itemId, '' );
			return;
		}	
		
		var team = '';
		var teamsList = [ 'ct', 't', 'noteam' ];

		for ( var i = 0; i < teamsList.length; i++ )
		{
			itemId = ( itemId === '0' ) ? LoadoutAPI.GetDefaultItem( teamsList[i], slot ) : itemId;
			var teamsEquippedList = _WhatTeamIsDefaultItemEquippedFor( itemId, teamsList );

			if ( teamsEquippedList.length > 0 )
			{
				team = ( teamsEquippedList.length > 1 ) ? 'bothteams' : teamsEquippedList[ 0 ];
				break;
			}
		}

		_DisplayNotification( elPanel, itemId, team );
	};

	var _DisplayNotification = function( elPanel, itemId, team )
	{
		var descText = '';
		
		if ( itemId === '0' )
		{
			descText = $.Localize( '#inv_unequipp_item' );
		}
		else
		{
			descText = MakeDescString( elPanel, itemId, team );
		}
		
		elPanel.FindChildInLayoutFile( 'InvNotificationLabel' ).text = descText;
		elPanel.AddClass( 'show' );
	}	

	var _WhatTeamIsDefaultItemEquippedFor = function( itemId, teamsList )
	{
		return teamsList.filter( team =>
		{
			return InventoryAPI.IsEquipped( itemId, team );
		} );
	};

	var MakeDescString = function( elPanel, id, team )
	{
		var descString = '';
		var rarityColor = ItemInfo.GetRarityColor( id );
		var itemName = '<font color="' + rarityColor + '">' + ItemInfo.GetName( id ) + '</font>';

		elPanel.SetDialogVariable( 'name', itemName );
		
		if ( team === 'noteam' )
		{
			return $.Localize( '#inv_equipped_item_noteam', elPanel);
		}
		else
		{
			var hintString = '';
			if ( team === 'bothteams' )
			{
				hintString = '#inv_team_both';
			}
			else
			{
				hintString = '#SFUI_InvUse_Equipped_' + team;
			}	
				
			elPanel.SetDialogVariable( 'team', $.Localize( hintString ) );
			return $.Localize( '#inv_equipped_item', elPanel );
		}
	};

	return {
		ShowEquipNotification: _ShowNotification
	};
} )();