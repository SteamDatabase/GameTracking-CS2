'use strict';

var InspectHeader = ( function()
{
	var m_isXrayMode = false;
	
	var _Init = function( elPanel, itemId, funcGetSettingCallback )
	{
		m_isXrayMode = ( funcGetSettingCallback( "isxraymode", "no" ) === 'yes' ) ? true : false; 
		
		if ( funcGetSettingCallback( 'inspectonly', 'false' ) === 'false' && !m_isXrayMode )
			return;
		
		elPanel.RemoveClass( 'hidden' );
		
		_SetName( elPanel, itemId, funcGetSettingCallback );
		_SetRarity( elPanel, itemId );
		_SetCollectionInfo( elPanel, itemId );
	};
	
	var _SetName = function( elPanel, ItemId, funcGetSettingCallback )
	{
		                                                                      
		                                                                             
		var strViewFunc = funcGetSettingCallback ? funcGetSettingCallback( 'viewfunc', '' ) : '';

		if ( ItemInfo.ItemDefinitionNameSubstrMatch( ItemId, 'tournament_journal_' ) )
			ItemId = ( strViewFunc === 'primary' ) ? ItemId : ItemInfo.GetFauxReplacementItemID( ItemId, 'graffiti' );

		elPanel.FindChildInLayoutFile( 'InspectName' ).text = ItemInfo.GetName( ItemId );
	};
	
	var _SetRarity = function( elPanel, itemId )
	{
		var rarityColor = ItemInfo.GetRarityColor( itemId );

		if ( rarityColor )
		{
			elPanel.FindChildInLayoutFile( 'InspectBar' ).style.washColor = rarityColor;
		}
	};
	
	var _SetCollectionInfo = function( elPanel, itemId )
	{
		var setName = ItemInfo.GetSet( itemId );
		var elImage = elPanel.FindChildInLayoutFile( 'InspectSetImage' );
		var elLabel = elPanel.FindChildInLayoutFile( 'InspectCollection' );
		
		if ( setName === '' )
		{
			elImage.visible = false;
			elLabel.visible = false;
			return;
		}

		elLabel.text = $.Localize( '#CSGO_' + setName );
		elLabel.visible = true;

		elImage.SetImage( 'file://{images}/econ/set_icons/' + setName + '_small.png' );
		elImage.visible = true;
	};

	return {
		Init : _Init
	}
} )();

