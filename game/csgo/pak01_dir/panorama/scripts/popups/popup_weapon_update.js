'use strict';

var PopupWeaponUpdate = ( function()
{
	var _Init = function()
	{
		var defIndex = $.GetContextPanel().GetAttributeString( "defindex", -1 );
		
		if ( defIndex === -1 )
		{
			return;
		}
		
		var itemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( Number( defIndex ), 0 );
		_SetModel( itemId );
		                                      
		_UpdateCurrentlyEquippedItemName( itemId );
		_ActionOpenLoadout( itemId );
		_AnimatePanelsForReveal();

		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.popup_newweapon', 'MOUSE' );
	};

	var _SetModel = function( itemId )
	{
		                                                  

		var elPanel = $.GetContextPanel().FindChildInLayoutFile( 'id-weapon-update-model' );
		var modelPath = ItemInfo.GetModelPathFromJSONOrAPI( itemId );

		elPanel.SetScene( "resource/ui/econ/ItemModelPanelCharWeaponInspect.res",
			modelPath,
			false
		);

		elPanel.SetCameraPreset( 1, false );
		 $.Schedule( 1.5, _PlayCameraAnimOnModel.bind( undefined, elPanel ) );
	};

	var _AnimatePanelsForReveal = function()
	{
		var idsForPanelToAnimate = [
			'id-popup-weapon__info',
			'id-popup-weapon-footer',
			'id-popup-weapon__model-bg',
			'id-weapon-update-model'
		];

		idsForPanelToAnimate.forEach( element => {
			$.GetContextPanel().FindChildInLayoutFile( element ).RemoveClass( 'offscreen' );
		});
	};

	var _PlayCameraAnimOnModel = function( elPanel )
	{
		                                      
		elPanel.SetSceneIntroRotation( -5.0, 60, 1 );

		$.GetContextPanel().FindChildInLayoutFile( 'id-popup-weapon__model-bg' ).AddClass( 'fillheight' );
		$.GetContextPanel().FindChildInLayoutFile( 'id-popup-weapon__info__top' ).AddClass( 'popup-weapon-label-dark' );
	};

	var _UpdateCurrentlyEquippedItemName = function( itemId )
	{
		var slot = ItemInfo.GetDefaultSlot( itemId );
		var defaultItem = LoadoutAPI.GetDefaultItem( 'ct', slot );
		                                                                          

		var elLabel = $.GetContextPanel().FindChildInLayoutFile( 'id-equip-hint' );
		elLabel.SetDialogVariable( 'weapon', ItemInfo.GetName ( defaultItem ));
		elLabel.SetDialogVariable( 'weaponnew', ItemInfo.GetName ( itemId ));
	};

	var _Close = function()
	{
		var setVersionTo = $.GetContextPanel().GetAttributeString( "uisettingversion", '0' );

		GameInterfaceAPI.SetSettingString( 'ui_popup_weaponupdate_version', setVersionTo );
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
	};

	var _ActionOpenLoadout = function( itemId )
	{
		var elBtn= $.GetContextPanel().FindChildInLayoutFile( 'id-popup-weapon-equip' );
		
		elBtn.SetPanelEvent( 'onactivate', OnActivate );
		
		function OnActivate ()
		{
			var subSlot = ItemInfo.GetDefaultSlot( itemId );

			$.DispatchEvent( 'OpenInventory' );
			$.DispatchEvent( "ShowLoadoutForItem", itemId );

			LoadoutAPI.EquipItemInSlot( 'ct', itemId, subSlot );
			LoadoutAPI.EquipItemInSlot( 't', itemId, subSlot );

			_Close();
		}
	};

	return {
		Init: _Init,
		Close: _Close
	};

})();

(function()
{
})();
