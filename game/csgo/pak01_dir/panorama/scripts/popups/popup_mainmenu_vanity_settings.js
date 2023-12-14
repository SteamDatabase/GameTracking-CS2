'use strict';

var PopupVanitySettings = ( function(){
	
	var _Init = function ()
	{
		var subCategories = _StripEmptyStringsFromArray( InventoryAPI.GetSubCategories('Type:Equipment').split(','));
		_SetSubCategories( subCategories );
		_LoadSettingsSetDefaults( subCategories[1] );

		$('#VanityDropdownModels').SetPanelEvent( 'oninputsubmit', PopupVanitySettings.OnFactionChanged );
		$('#VanityDropdownSubCatagories').SetPanelEvent( 'oninputsubmit', PopupVanitySettings.OnSubCategoryChanged );
	}

	var _LoadSettingsSetDefaults = function ( subCategory )
	{
		CharacterAnims.InitVanityModel();
		var settings = CharacterAnims.GetVanityModel();
		
		$('#VanityDropdownModels').SetSelected( settings.model );
		$('#VanityDropdownSubCatagories').SetSelected( settings.loadoutSlot );

		_SetGroups( _GetSelectedSubCatagory() );

		$('#VanityDropdownGroups').SetSelected( settings.selectedWeapon );
	}

	var _SetSubCategories = function ( subCategories )
	{
		for( var i = 0; i < subCategories.length; i++ )
		{
			var displayString = subCategories[i].substring ( subCategories[i].indexOf( ':' ) + 1 );
			
			var optionLabel = $.CreatePanel('Label', $('#VanityDropdownSubCatagories'), displayString, { text: displayString });
			optionLabel.SetAttributeString( 'data-subcategory', subCategories[i] );
			$('#VanityDropdownSubCatagories').AddOption(optionLabel);
		}
	}

	var _SetGroups = function ( subCategory )
	{	
		var groups = _StripEmptyStringsFromArray( InventoryAPI.GetGroups( 'Type:Equipment', subCategory ).split(','));
		
		if( $('#VanityDropdownGroups') )
			$('#VanityDropdownGroups').DeleteAsync ( 0 );
	
		var elDropDown = $.CreatePanel('DropDown', $('#VanityDropdownWeapons'), 'VanityDropdownGroups', { class:'PopupButton'} );

		if( subCategory === 'LoadoutSlot:melee' )
		{
			var itemId = LoadoutAPI.GetItemID( 'ct', 'melee' );
			AddOptionToGroups( elDropDown, itemId, 'Weapon:knife' );
			elDropDown.SetSelected( 'Weapon:knife' );
		}
		else
		{
			for( var i = 0; i < groups.length; i++ )
			{
				var itemIds = [];
				itemIds = InventoryAPI.GetGroupItems( 'Type:Equipment', subCategory, groups[i] ).split(',');

				var itemId = itemIds[0];
				var teamRestriction = InventoryAPI.GetItemTeam( itemId ).toLowerCase();
				if( teamRestriction.indexOf( 'csgo_inventory_team_any' ) !== -1 || teamRestriction.indexOf( 'csgo_inventory_team_'+_GetSelectedTeam() ) !== -1 )
				{	
					AddOptionToGroups( elDropDown, itemId, groups[i] );
				}
			}
			
			elDropDown.SetSelected( groups[0] );
		}

		elDropDown.SetPanelEvent( 'oninputsubmit', PopupVanitySettings.UpdatePlayerModel );
		
	}

	var AddOptionToGroups = function ( elDropDown, itemId, group )
	{
		var displayString = InventoryAPI.GetItemName( itemId );
		var optionLabel = $.CreatePanel('Label',elDropDown, group, { text: displayString });
		
		optionLabel.SetAttributeString( 'data-slot', InventoryAPI.GetDefaultSlot(itemId).toString() );
		optionLabel.SetAttributeString( 'data-item-id', itemId );

		elDropDown.AddOption(optionLabel);
	}

	var _StripEmptyStringsFromArray= function (dataRaw)
	{
		 return dataRaw.filter(function (v) {
			return v !== '' && v != 'any';
		});
	}

	var _OnFactionChanged = function ()
	{
		_SetGroups( _GetSelectedSubCatagory() );
		$.Schedule(.25, _UpdatePlayerModel );
	}

	var _OnSubCategoryChanged = function ()
	{
		_SetGroups( _GetSelectedSubCatagory() );
		$.Schedule(.25, _UpdatePlayerModel );
	}

	var _UpdatePlayerModel = function ()
	{
		var modelPath = $( '#VanityDropdownModels' ).GetSelected().id,
		selectedWeapon = $( '#VanityDropdownGroups' ).GetSelected().id,
		weaponSlot =  $( '#VanityDropdownGroups' ).GetSelected().GetAttributeString( 'data-slot', '(not found)'),
		loadoutSlot = $( '#VanityDropdownSubCatagories' ).GetSelected().id,
		itemId = $( '#VanityDropdownGroups' ).GetSelected().GetAttributeString( 'data-item-id', '(not found)'),
		team = _GetSelectedTeam();

		var playIntroAnim = $( '#VanityPlayIntroAnim' ).checked;

		                                                  
		CharacterAnims.UpdateVanityModel( team, modelPath, itemId, loadoutSlot, playIntroAnim, selectedWeapon );
	}

	var _GetSelectedSubCatagory = function ()
	{
		return $( '#VanityDropdownSubCatagories' ).GetSelected().GetAttributeString( 'data-subcategory', '(not found)');
	}

	var _GetSelectedTeam = function ()
	{
		return $( '#VanityDropdownModels' ).GetSelected().GetAttributeString( 'data-team', '(not found)');
	}

	return {
		Init							: _Init,
		UpdatePlayerModel				: _UpdatePlayerModel,
		OnSubCategoryChanged			: _OnSubCategoryChanged,
		OnFactionChanged				: _OnFactionChanged
	};

})();