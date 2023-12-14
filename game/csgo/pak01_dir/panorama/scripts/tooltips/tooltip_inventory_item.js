function setupTooltip()
{
    var ctx = $.GetContextPanel();
	var id = ctx.GetAttributeString("itemid", "0");
	
	                          
	var bThisIsFauxItemID = InventoryAPI.IsFauxItemID( id );

           
    ctx.SetDialogVariable('name', InventoryAPI.GetItemName(id));

                  
    var strDesc = InventoryAPI.GetItemDescription( id, '' );
    if (strDesc.endsWith('<br>'))
    {
                               
        strDesc = strDesc.slice(0, -4);
    }
    ctx.SetDialogVariable('description', strDesc);

                          
    var strSetName = InventoryAPI.GetTag(id, 'ItemSet');
    var strSetLoc = undefined;
    if (strSetName && strSetName != '0')
        strSetLoc = InventoryAPI.GetTagString(strSetName);

	if (strSetName && strSetName != '0')
	{
	    ctx.AddClass('tooltip-inventory-item__has-set');
	    $('#CollectionLogo').SetImage('file://{images}/econ/set_icons/' + strSetName + '_small.png');
	    ctx.SetDialogVariable('collection', strSetLoc);
	}
	else
	{
	    ctx.RemoveClass('tooltip-inventory-item__has-set');
	    $('#CollectionLogo').SetImage('');
	    ctx.SetDialogVariable('collection', '');
	}

                             
	var rarity = InventoryAPI.GetItemRarity(id);
	var rarityName = InventoryAPI.GetItemType(id);

	if (rarityName)
	{
	    ctx.AddClass('tooltip-inventory-item__has-rarity');
	    ctx.SwitchClass('tooltip-rarity', 'tooltip-inventory-item__rarity-' + rarity);
	    ctx.SetDialogVariable('rarity', rarityName);
	}
	else
	{
	    ctx.RemoveClass('tooltip-inventory-item__has-rarity');
	    ctx.SetDialogVariable('rarity', '');
	}

                              
	var numWear = bThisIsFauxItemID ? undefined : InventoryAPI.GetWear(id);
	if (numWear != undefined && numWear >= 0)
	{
	    ctx.AddClass('tooltip-inventory-item__has-grade');
	    ctx.SetDialogVariable('grade', $.Localize('#SFUI_InvTooltip_Wear_Amount_' + numWear));
	}
	else
	{
	    ctx.RemoveClass('tooltip-inventory-item__has-grade');
	    ctx.SetDialogVariable('grade', '');
	}

                
	var strTeam = InventoryAPI.GetItemTeam(id);

                               
	var strCategory = InventoryAPI.GetLoadoutCategory(id);
	if (!strCategory || strCategory === 'flair0' || strCategory === 'musickit' || strCategory === 'spray0')
	{
	    strTeam = undefined;
	}

	if (strTeam)
	{
	    ctx.AddClass('tooltip-inventory-item__has-team');
	    ctx.SetDialogVariable('team', $.Localize(strTeam));

	    var bAny = (strTeam == '#CSGO_Inventory_Team_Any');
	    var bCT = bAny || (strTeam == '#CSGO_Inventory_Team_CT');
	    var bT = bAny || (strTeam == '#CSGO_Inventory_Team_T');

	    ctx.SetHasClass('tooltip-inventory-item__team-ct', bCT);
	    ctx.SetHasClass('tooltip-inventory-item__team-t', bT);
    }
	else
	{
	    ctx.RemoveClass('tooltip-inventory-item__has-team');
	    ctx.RemoveClass('tooltip-inventory-item__team-ct');
	    ctx.RemoveClass('tooltip-inventory-item__team-t');
    }

	                                             
	if ( GameInterfaceAPI.GetSettingString( "cl_inventory_debug_tooltip") == "1" )
	{
		var debugOutput = "<br />";
		var Print = function( string )
		{
			debugOutput += string + "<br />";
		}

		          
		Print( "--------------------------------------" );
		Print( "itemID: " + id );
		Print("--------------------------------------");

		       
		var oTags = InventoryAPI.BuildItemTagsObject( id );

		Object.keys( oTags ).forEach( function( key, index )
		{
			var tag = oTags[ key ];

			var cat = Object.keys( tag )[0];
			var val = tag[ Object.keys( tag )[0]];

			Print( cat + ": " + val );
		});

	                                                           
		ctx.SetDialogVariable('description', debugOutput);
	}

}