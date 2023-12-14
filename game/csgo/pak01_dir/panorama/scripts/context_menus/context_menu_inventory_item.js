"use-strict";

var ItemContextMenu = ( function (){

	var _SetupContextMenu = function()
	{
		var id = $.GetContextPanel().GetAttributeString( "itemid", "(not found)" );
		var populateFilterText = $.GetContextPanel().GetAttributeString( "populatefiltertext", "(not found)" );

		                                        
		                                                    

		                                                                                                             
		InventoryAPI.PrecacheCustomMaterials( id );
		
		_PopulateContextMenu( id, populateFilterText );
	};

	var _PopulateContextMenu = function ( id, populateFilterText )
	{	
		var elParent = $.GetContextPanel();

		                                                                                                    
		                                                                        
		                                            
		                                                                                                    
		var validEntries = ItemContextEntires.FilterEntries( populateFilterText );

		var OnMouseOver = function( location, displayText )
		{
			UiToolkitAPI.ShowTextTooltip( location, displayText );
		};

		var hasEntries = false;
		                              
	
		for( var i = 0; i < validEntries.length; i++ )
		{
			var entry = validEntries[ i ];
		
			if ( entry.AvailableForItem( id ) ) 
			{
				var elButton = $.CreatePanel( 'Button', elParent, 'ContextMenuItem' + i );
				                              

				var elLabel = $.CreatePanel( 'Label', elButton, '', { html: 'true' } );
				var displayName = ''
				
				if ( entry.name instanceof Function )
				{
					displayName = entry.name( id );
				}
				else
				{
					displayName = entry.name;
				}

				elLabel.text = '#inv_context_' + displayName;

				hasEntries = true;

				if( entry.style )
				{
					var strStyleToAdd = entry.style(id);
					if ( strStyleToAdd !== '' ) 
					{
						if ( strStyleToAdd === 'BottomSeparator' && i !== ( validEntries.length - 1 ) ||
							strStyleToAdd === 'TopSeparator' && i !== 0 ) 
						{
							elButton.AddClass( strStyleToAdd );
						}
					}
				}

				var handler = entry.OnSelected.bind(this, id);

				elButton.SetPanelEvent( 'onactivate', function( event_handler ) 
				{
					$.DispatchEvent( 'CSGOPlaySoundEffect', 'inventory_item_popupSelect', 'MOUSE' );

					event_handler();

				}.bind(this, handler));

				if( entry.CustomName )
				{
					if( entry.CustomName(id) !== '' )
					{
						var customName = entry.CustomName( id );
						
						elButton.SetPanelEvent( 'onmouseover', OnMouseOver.bind( undefined ,elButton.id, customName ));
						elButton.SetPanelEvent( 'onmouseout',function(){
							UiToolkitAPI.HideTextTooltip();
						});

					

					}
				}
			}
		}

		                         
		    	                                                  
		   	                                                 
		    

		                                              
		if ( !hasEntries )
		{
			var elButton = $.CreatePanel( 'Button', elParent, 'ContextMenuItem' );
			var elLabel = $.CreatePanel( 'Label', elButton, '', {html: 'true'} );
			elLabel.text = '#inv_context_no_valid_actions';

			elButton.SetPanelEvent( 'onactivate', _ => $.DispatchEvent( 'ContextMenuEvent', '' ) );
		}
	};

	return {
		SetupContextMenu: _SetupContextMenu,
	};
})();
