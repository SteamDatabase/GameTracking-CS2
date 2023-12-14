'use strict';

var deathPanel = ( function() {
	
	var _OnSetFlairEvent = function( xuid, skillgroup )
	{
		var elAvatarFlair = $( '#AvatarFlair' );
		var elMedalText = $( '#MedalText' );
		var elAvatarFlairSS = $( '#AvatarFlairSS' );
		var elMedalTextSS = $( '#MedalTextSS' );
		var elPlayerAvatarSkillGroup = $( '#PlayerAvatarSkillGroup' );
		_SetAnimBackground( xuid );

		var flairItemImage = _GetFlairItemImage( xuid );
		if ( flairItemImage !== '' )
		{
			elAvatarFlair.RemoveClass( 'DeathPanel__AvatarFlair--Hidden' );
			elAvatarFlair.SetImage( 'file://{images}' + flairItemImage + '_small.png' );
			elAvatarFlairSS.RemoveClass( 'DeathPanel__AvatarFlair--Hidden' );
			elAvatarFlairSS.SetImage( 'file://{images}' + flairItemImage + '_small.png' );

			var flairItemName = InventoryAPI.GetFlairItemName( xuid );
			if ( flairItemName === '' || flairItemName === undefined )
			{
				elMedalText.AddClass( 'DeathPanel__MedalText--Hidden' );
				elMedalTextSS.AddClass( 'DeathPanel__MedalText--Hidden' );
			}
			else
			{
				elMedalText.RemoveClass( 'DeathPanel__MedalText--Hidden' );
				elMedalText.text = flairItemName;
				elMedalTextSS.RemoveClass( 'DeathPanel__MedalText--Hidden' );
				elMedalTextSS.text = flairItemName;
			}
		}
		else
		{
			elAvatarFlair.AddClass( 'DeathPanel__AvatarFlair--Hidden' );
			elMedalText.AddClass( 'DeathPanel__MedalText--Hidden' );
			elAvatarFlairSS.AddClass( 'DeathPanel__AvatarFlair--Hidden' );
			elMedalTextSS.AddClass( 'DeathPanel__MedalText--Hidden' );
		}

		if ( skillgroup )
		{
			elPlayerAvatarSkillGroup.SetImage( 'file://{images}/icons/skillgroups/dangerzone'+skillgroup+'.svg' );
			elPlayerAvatarSkillGroup.RemoveClass( 'DeathPanel__AvatarSkillGroup--Hidden' );
		}
		else
		{
			elPlayerAvatarSkillGroup.AddClass( 'DeathPanel__AvatarSkillGroup--Hidden' );
		}
	}

	var _SetAnimBackground = function( xuid )
	{
		HudSpecatorBg.PickBg( xuid );
	}

	                                            
	                                          
	var _GetFlairItemImage = function( xuid )
	{
		if( xuid === '' || xuid === '0'|| xuid === 0 )
		{
			return '';
		}

		var flairItemId = InventoryAPI.GetFlairItemId( xuid );

		                                                                                   
		if ( flairItemId === "0" || !flairItemId )
		{
			var flairDefIdx = FriendsListAPI.GetFriendDisplayItemDefFeatured( xuid );
			flairItemId = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( flairDefIdx, 0 );

			if ( flairItemId === "0" || !flairItemId )
			return '';
		}

		var imagePath = InventoryAPI.GetItemInventoryImage( flairItemId );
		
		return imagePath;
	}

	return {
		OnSetFlairEvent : _OnSetFlairEvent
	};
} )();

(function()
{
	$.RegisterEventHandler( 'CSGOHudDeathPanelSetFlair', $.GetContextPanel(), deathPanel.OnSetFlairEvent );
})();
