'use-strict';

var AcknowledgeXpGrant = ( function()
{
	var _m_xuid = MyPersonaAPI.GetXuid();
	var _m_currentLvl = FriendsListAPI.GetFriendLevel( _m_xuid );

	var _OnLoad = function ()
	{
		_Init();
	}

	var _Init = function()
	{
		var elRankIcon = $.GetContextPanel().FindChildInLayoutFile( 'JsPlayerXpIcon' ),
			elRankText = $.GetContextPanel().FindChildInLayoutFile( 'JsPlayerRankName' );

		                    
		elRankText.SetDialogVariable( 'name', $.Localize( '#SFUI_XP_RankName_' + _m_currentLvl ) );
		elRankText.SetDialogVariableInt( 'level', _m_currentLvl );

		                              
		elRankIcon.SetImage( 'file://{images}/icons/xp/level' + _m_currentLvl + '.png' );

		  
		        
		  

		var fauxItemID = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( 4607, 0 );           
		var rarityColor = ItemInfo.GetRarityColor( fauxItemID );
		rarityColor = "#8847ff";                           

		var elMovie = $.GetContextPanel().FindChildInLayoutFile( 'AcknowledgeMovie' );
		elMovie.style.washColor = rarityColor;

		var elBar = $.GetContextPanel().FindChildInLayoutFile( 'AcknowledgeBar' );
		elBar.style.washColor = rarityColor;
	};

	var _OnActivate = function()
	{
		$.DispatchEvent( 'UIPopupButtonClicked', '' );
		$.DispatchEvent( 'CSGOPlaySoundEffect', 'UIPanorama.inventory_new_item_accept', 'MOUSE' );			
	};

	return {
		Init				: _Init,
		OnLoad 				: _OnLoad,
		OnActivate			: _OnActivate
	};
} )();

( function()
{
} )();

