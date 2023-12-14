'use strict';

var OperationStore = ( function() 
{
	var _m_cp = $.GetContextPanel();
	var _m_nSeasonAccess = null;
	var _oTileId = "id-op-store-tile-";
	var _m_tilesLoaded = false;
	var _m_placeBarSegments = false;
	
	var _Init = function()
	{
		_CheckUsersOperationStatus();

		                                                                                                                 
		_m_cp.FindChildInLayoutFile( 'id-op-store-get-more-points-btn' ).GetChild( 0 ).AddClass( 'op-store-progress__pass-upsell__text-btn-dark');
		_m_cp.FindChildInLayoutFile( 'id-store-pass-upsell-text-btn' ).GetChild( 0 ).AddClass( 'op-store-progress__pass-upsell__text-btn-dark');

		_m_cp.RemoveClass( 'op-store-tiles-hide' );
	};

	var _CheckUsersOperationStatus = function()
	{
		_m_nSeasonAccess = $.GetContextPanel().GetAttributeInt( "season_access", 0 );
		OperationUtil.ValidateOperationInfo( _m_nSeasonAccess );

		var oStatus = OperationUtil.GetOperationInfo();

		if( !OperationUtil.ValidateCoinAndSeasonIndex( _m_nSeasonAccess, oStatus.nCoinRank ) )
		{
			return;
		}

		_FillOutStoreTiles();

		var totalStarsAvailiable = OperationUtil.GettotalPointsFromAvailableFromMissions();
		_UpdateDialogVarYourStars();
		_UpdateProgressBar( totalStarsAvailiable );
		_SetPurchaseBtns( totalStarsAvailiable );
	};

	var _UpdateDialogVarYourStars = function()
	{
		                                                                                                                         
		_m_cp.SetDialogVariableInt( "your_stars", OperationUtil.GetOperationInfo().nRedeemableBalance );
	};

	var _UpdateProgressBar = function ( totalStarsAvailiable )
	{
		var elParent = _m_cp.FindChildInLayoutFile( 'id-op-store-progress-bar' );

		var aCoins = OperationUtil.GetCoinDefIdxArray();
		var numStarsEarned = OperationUtil.GetOperationInfo().nTierUnlocked;
		var nThreshold = 0;

		aCoins.forEach( function( coinId, index ){
			var id = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( coinId, 0 );

			var elCoin = elParent.FindChildInLayoutFile( "op-progress-coin" + index );

			if(! elCoin )
			{
				var elCoin = $.CreatePanel( "Panel", elParent , "op-progress-coin" + index );
				elCoin.BLoadLayoutSnippet( 'progressbar-icon' );
				elCoin.FindChildInLayoutFile('id-store-progress-bar-icon').itemid = id;
				elCoin.Data().upgradeThreshold = nThreshold;
			}

			                                           
			if( nThreshold > 0 )
			{
				elCoin.FindChildInLayoutFile('id-store-progress-bar-progress').SetDialogVariableInt( 'threshold', elCoin.Data().upgradeThreshold );
				var progress = numStarsEarned <= nThreshold ? numStarsEarned : nThreshold;
				elCoin.FindChildInLayoutFile('id-store-progress-bar-progress').SetDialogVariableInt( 'progress', progress );
			}
			else
			{
				elCoin.FindChildInLayoutFile('id-store-progress-bar-progress').text = '';
			}

			elCoin.SetHasClass( 'filled', nThreshold <= numStarsEarned );

			nThreshold = InventoryAPI.GetItemAttributeValue( id, 'upgrade threshold' );
	
		});

		                                                                                

		$.Schedule( .1, function() {
			var aCoinPanels = elParent.Children();
			var coinWidth = aCoinPanels[0].actuallayoutwidth/aCoinPanels[0].actualuiscale_x;
			var barWidth = elParent.actuallayoutwidth/elParent.actualuiscale_x;
			var segmentWidth = (barWidth - ( coinWidth * aCoins.length ))/totalStarsAvailiable - 1;
			var coinLevel = 0;

			                                     
			aCoinPanels[0].AddClass( 'filled' );
			for ( var i = 1; i < aCoinPanels.length; ++ i )
			{
				if( aCoinPanels[i].Data().upgradeThreshold <= numStarsEarned)
				{
					aCoinPanels[i].AddClass( 'filled' );
				}
			}

			                 
			for( var i = 0; i < totalStarsAvailiable; i++ )
			{
				var elBarSection =  elParent.FindChildInLayoutFile( "op-progress-pip" + i );
				
				if( !elBarSection )
				{
					var elBarSection = $.CreatePanel( 'Panel', elParent,  "op-progress-pip" + i );
					elBarSection.BLoadLayoutSnippet( 'progressbar-section' );
					elBarSection.style.width = segmentWidth +'px;';
				}
	
				elBarSection.SetHasClass( 'filled', i < numStarsEarned );

				if( i >= aCoinPanels[coinLevel].Data().upgradeThreshold )
				{
					++ coinLevel;
				}

				if ( !_m_placeBarSegments )
				
				{
					if( aCoinPanels[coinLevel] )
					{
						elParent.MoveChildBefore( elBarSection, aCoinPanels[coinLevel] );
					}
				}
			}

			if ( !_m_placeBarSegments )
			{
				$.Schedule( 0.1, function() { elParent.style.width = 'fit-children;' });
				_m_placeBarSegments = true;
			}
		});
	};

	var _FillOutStoreTiles = function ()
	{
		var aRewards = OperationUtil.GetRewardsData();
		var aRowTypes = [ 'isCharacterLootlist', 'set_train_2021', [ 'isWeaponLootlist', 'isWeaponsCase', 'isStickerLootlist', 'isGraffitiBox' ] ];
		var bHasTitle = false;
		
		aRowTypes.forEach((type, index) => {
			var aRow = [];
			                                               
			aRewards.forEach( ( reward, index ) =>
			{
				var strSetName = InventoryAPI.GetTag( reward.lootlist[ 0 ], 'ItemSet' );
		
				if ( strSetName === type )
				{
					aRow.push( reward );
					bHasTitle = true;
				}
				else if( strSetName !== 'set_train_2021' && Array.isArray( type ) && type.indexOf( reward.containerType) !== -1  )
				{
					aRow.push( reward );
					bHasTitle = false;
				}
				else if( reward.containerType === type )
				{
					aRow.push( reward );
					bHasTitle = true;
				}
			});

			var elRow = _AddRewardRow( index, bHasTitle );
			_UpdateRowDescPanel( elRow, aRow,  bHasTitle );
			var aRewardPanels = _AddRewards( elRow, aRow );
			if( bHasTitle )
			{
				aRewardPanels.forEach( reward =>
				{
					elRow.FindChildInLayoutFile( 'id-op-store-reward-row-bg' ).AddBlurPanel( reward );
				} );
			}
		});

		                                                                           
		   	                                                               
		   	                      
		   		                                        

		   	                                                            
		   	                                                                                      
		   		                                                                      

		   	                                                                       
		       

		                                                                  

		                                      
		   	                                         
		   	                                      
		   	                            
			
		   	                                                                                                                                                                  
		   	                                                  
		   	                                                               
		   	                                                                     
		   	                                                             
		   	                                                                    
		   	                                                                     

		   	                                                                            
		   	                                                    

		   	                                           
		   	                                                                              
		   	                                                     

		   	                                                                              
		   	                                                                             
		      
	};

	var _AddRewardRow = function( index, bHasTitle )
	{
		var elContainer = $.GetContextPanel().FindChildInLayoutFile( 'id-op-store-reward-rows' );

		var row = null;

		if ( !elContainer.FindChildInLayoutFile( 'id-op-store-reward-row' + index ) )
		{
			row = $.CreatePanel( 'Panel', elContainer, 'id-op-store-reward-row' + index );
			row.BLoadLayoutSnippet( 'reward-row' );
		}
		else
		{
			row = elContainer.FindChildInLayoutFile( 'id-op-store-reward-row' + index );
		}

		row.SetHasClass( "show-row-title", bHasTitle );
		return row;
	}

	var _UpdateRowDescPanel = function( elRow, aRow, bHasTitle )
	{
		if( !bHasTitle )
		{
			return;
		}

		var setName =  InventoryAPI.GetTag( aRow[0].lootlist[ 0 ], 'ItemSet' );
		if( setName )
		{
			elRow.FindChildInLayoutFile('id-op-store-reward-row-bg-icon' ).SetImage( 'file://{images}/econ/set_icons/' + setName + '.png' );
			elRow.FindChildInLayoutFile('id-op-store-reward-row-bg' ).style.backgroundImage = 'url("file://{images}/operations/op11/' + setName + '_row_bg.png");'
			elRow.FindChildInLayoutFile('id-op-store-reward-row-bg' ).style.backgroundPosition = '0% 20%;';
			elRow.FindChildInLayoutFile('id-op-store-reward-row-bg' ).style.backgroundSize = 'cover;';
			elRow.FindChildInLayoutFile('id-op-store-reward-row-bg' ).style.backgroundImgOpacity = '.6;';
		}

		elRow.SetDialogVariable( 'title', $.Localize( '#CSGO_' + setName ) );
	}

	var _AddRewards = function( elRow, aRow )
	{
		var elContainer = elRow.FindChildInLayoutFile( 'id-rewards-container' );
		aRow = aRow.sort(function(a, b) {
			return a.uiOrder - b.uiOrder;
		} );
		
		var aRewardPanels = [];

		aRow.forEach( ( oRewardData, index ) =>
		{
			var elReward = null;

			if ( !elContainer.FindChildInLayoutFile( 'id-op-store-reward-' + index ) )
			{
				elReward = $.CreatePanel( 'Panel', elContainer, 'id-op-store-reward-' + index );
				elReward.BLoadLayoutSnippet( 'reward-tile' );
			}
			else
			{
				elReward = elContainer.FindChildInLayoutFile( 'id-op-store-reward-' + index );
			}

			_UpdateRewardTile( elRow, elReward, oRewardData );

			aRewardPanels.push( elReward );
		} );

		return aRewardPanels;
	}

	                        
	var _UpdateRewardTile = function( elRow, elReward, oRewardData )
	{
		var elImagesContainer = elReward.FindChildInLayoutFile( 'id-op-store-item-tile-images');

		if( oRewardData.containerType === 'isCharacterLootlist' )
		{
			for ( var i = oRewardData.lootlist.length - 1; i >= 0; i-- )
			{
				var bCreateSeperator = ( i > 0 );
				_LoadCharactorImages( elImagesContainer, oRewardData.lootlist[ i ], i, bCreateSeperator );
	
				                                                                 
			}

			elImagesContainer.SetHasClass( "three-tile", oRewardData.lootlist.length === 3 );
			
			                  
			                                                                                  
			
			var color = ItemInfo.GetRarityColor( oRewardData.lootlist[ 0 ] );
			_SetRarityColor( elReward, color );
		}
		else if( oRewardData.containerType === 'isWeaponLootlist' )
		{
			_LoadWeaponImages( elImagesContainer, oRewardData );
			var strSetName = InventoryAPI.GetTag( oRewardData.lootlist[ 0 ], 'ItemSet' );
		
			if ( strSetName ==="set_train_2021" )
			{
				var color = ItemInfo.GetRarityColor( oRewardData.lootlist[ 0 ] );
				_SetRarityColor( elReward, color );
				                                                                                          
			}
			else
			{
				_SetTileBackgroundImage( elImagesContainer, "store_bg_base", true );
			}
		}
		else if( oRewardData.containerType === 'isStickerLootlist' || oRewardData.containerType === 'isGraffitiBox' )
		{
			var aImagePanel = _SetMultiItemImages( elImagesContainer, oRewardData );

			if( oRewardData.containerType === 'isGraffitiBox' )
			{
				_TintGraffitiImages( aImagePanel );
			}
			_SetTileBackgroundImage( elImagesContainer, "store_bg_sand", true );
		}
		else
		{
			LoadItemImage( elImagesContainer, oRewardData.itempremium.ids[ 0 ], '', 'op-store-item-tile__image center' );
			_SetTileBackgroundImage( elImagesContainer, "store_bg_sand", true );
		}
		
		_SetRewardName( elReward, oRewardData.itempremium.ids[ 0 ] );
		elReward.FindChildInLayoutFile( 'id-op-store-item-cost').text = oRewardData.points;
		elReward.SetPanelEvent( 'onactivate', _OpenInspect.bind( undefined, oRewardData ) );
	};

	var _LoadCharactorImages = function( elImagesContainer, rewardId, index, bCreateSeperator )
	{
		var elImage = elImagesContainer.FindChildInLayoutFile( 'id-op-shop-tile-item-image-' + rewardId );

		if( !elImage && rewardId )
		{
			var styleName = 'op-store-reward-tile__image-char-' + index;
			elImage = LoadItemImage( elImagesContainer, rewardId,
				'id-store-item-tile__item--char' + rewardId,
				styleName
			);
			
			if ( bCreateSeperator )
			{
				$.CreatePanel( "Panel", elImagesContainer, '', { class: 'op-store-reward-tile__image-seperator' });
			}
		}
	};

	var _SetRewardName = function( elReward, rewardId )
	{
		var itemName = elReward.FindChildInLayoutFile( 'id-op-store-item-tile-name' );
		itemName.text = InventoryAPI.GetItemName( rewardId );
	};

	var _LoadWeaponImages = function( elParent, oReward )
	{
		var elCollectionIcon = $.CreatePanel( "ItemImage", elParent, "id-op-store-item-tile__icon", {
			scaling: 'stretch-to-fit-preserve-aspect',
			class: 'op-store-item-tile__icon'
		});

		elCollectionIcon.itemid = oReward.itempremium.ids[ 0 ];
		
		var min = 0;
		var max = oReward.lootlist.length;
		var indexToDisplay = _GetRandomMinMax( min, max )
		var elImage = elParent.FindChildInLayoutFile( 'id-op-shop-tile-item' );

		if( !elImage )
		{
			elImage = LoadItemImage( elParent, 
				oReward.lootlist[ indexToDisplay ], 
				'id-op-shop-tile-item', 
				'op-store-item-tile__item'
			);
			elParent.SetPanelEvent( 'onmouseover', function(){ InventoryAPI.PrecacheCustomMaterials( oReward.lootlist[0] );} );
		}
	};

	var _SetMultiItemImages = function( elParent, oReward )
	{
		var elMultiItemTile = $.CreatePanel( "Panel", elParent , "" );
		elMultiItemTile.BLoadLayoutSnippet( 'reward-sticker-images' );
		elMultiItemTile.style.zIndex = "2";
		var numItems = oReward.lootlistGroups ? oReward.lootlistGroups.length - 1 :  oReward.lootlist.length - 1;

		elMultiItemTile.Children().forEach( function( elImage, index )
		{
			var lootlistIndex = index % 2 === 0 ? ( numItems - index) : ( 0 + index );
			elImage.itemid = oReward.lootlist[ oReward.lootlistGroups ? oReward.lootlistGroups[ lootlistIndex ].idxBegin : lootlistIndex ];
			elImage.Data().rewardId = elImage.itemid;
		});

		return elMultiItemTile.Children();
	};

	var _TintGraffitiImages = function( aPanels )
	{
		if( aPanels.length > 0 )
		{
			aPanels.forEach( element => {
				                                                                                     
				                                                                             
				TintSprayIcon.CheckIsSprayAndTint( element.Data().rewardId, element );
				element.AddClass( 'noshadow' );
			});
			
		}
	};

	var LoadItemImage = function ( elParent, itemId, idName, styleName )
	{
		var elImage = $.CreatePanel( "ItemImage", elParent , idName, {
			scaling: 'stretch-to-fit-y-preserve-aspect',
			class: styleName
		});
		
		elImage.itemid = itemId;

		return elImage;
	};

	var _SetRarityColor = function( itemTile, color )
	{
		if ( !color )
			return;
		
		itemTile.FindChildInLayoutFile( 'id-op-store-item-tile-rarity' ).style.backgroundColor = color;
	};

	var _SetTileBackgroundImage = function( elParent, imageName, bFade = false )
	{
		var elPanelBg = $.CreatePanel( "Image", elParent , "id-op-shop-tile-bg", { class: 'op-store-item-tile__bg'});
		elPanelBg.style.backgroundImage = "url( 'file://{images}/operations/op11/" + imageName+".png' );";
		elPanelBg.style.backgroundSize ='auto 100% ';
		elPanelBg.style.backgroundRepeat = 'no-repeat';
		elPanelBg.style.zIndex ='1';

		elPanelBg.SetHasClass( 'faded', bFade )
	};

	                                                                                   
	    
	   	                                                                                   
	   	                    
	   	 
	   		                                                                                                                                        
	   		                                                           

	   		                                                                               
	   			      
	   			     
	   		  

	   		                                        
	   		                                                                                  
	   		                               

	   		                                                     
	   		                                          

	   	 

	   	                                           
	   	                                        
	     

	                                                           
	    
	   	                                                                                          
	   	                                         
	     

	var _SetPurchaseBtns = function( totalStarsAvailiable )
	{
		var elUpSell = $.GetContextPanel().FindChildInLayoutFile( 'id-store-pass-upsell-text-btn' );
		var elGetStars = $.GetContextPanel().FindChildInLayoutFile( 'id-op-store-get-more-points-btn' );

		var oi = OperationUtil.GetOperationInfo();
		var bPremiumUser = oi.bPremiumUser;
		var sUserOwnedOperationPassItemID = InventoryAPI.GetActiveSeasonPassItemId();

		elUpSell.visible = !bPremiumUser;
		elGetStars.visible = oi.bShopIsFreeForAll ? true : bPremiumUser;
		elGetStars.SetPanelEvent( 'onactivate', OperationUtil.OpenUpSell.bind( undefined, 0, true ) );

		                          
		var elMissionsProgress = _m_cp.FindChildInLayoutFile( 'id-op-store-pass-missions-progress' );
		elMissionsProgress.visible= bPremiumUser;
		elMissionsProgress.SetDialogVariableInt( "mission_stars", bPremiumUser ? oi.nTierUnlocked : 0 );
		elMissionsProgress.SetDialogVariableInt( "max_stars", totalStarsAvailiable );

		if( bPremiumUser )
		{
			_m_cp.FindChildInLayoutFile( 'id-op-store-progress-pass-upsell' ).visible= false;
			elGetStars.SetPanelEvent( 'onactivate', OperationUtil.OpenUpSell.bind( undefined ) );
		}
		else
		{
			elUpSell.text = $.Localize( bPremiumUser ?
				'#op_get_more_stars' : sUserOwnedOperationPassItemID ? 
				'#SFUI_ConfirmBtn_ActivatePassNow' : '#op_get_premium'
				).toUpperCase();
	
			elUpSell.SetPanelEvent( 'onactivate', OperationUtil.OpenUpSell.bind( undefined ) );

			var descString = $.GetContextPanel().FindChildInLayoutFile( 'id-store-pass-upsell-desc' );
			descString.text = $.Localize( '#op_stars_max_upsell', elMissionsProgress );
		}

	
		                               
		  
		                                                                                                                 
		                                                                                                  
		                                                                                
		                      
		    
		   	                   
		   	                             
		   	                                                           
		   	                                      
		   	 
		   		                                                                 
		   			                                                                        
		   			  
		   		                                                             
		   		 
		   			                                                           
		   			                    
		   			 
		   				                       
		   			 
		   			    
		   			 
		   				                                  
		   				                                  
		   			 
		   			                                      

		   			                                                                           
		   			                                                                           
		   		 
		   	    
			
		   	                    
		   	 
		   		                                                                           
		   		                                                                                        
		   	 
		    
		                                                  
		   	                                        
		       
		   	                                   
	};

	var _OpenInspect = function( oReward )
	{
		                                                       

		UiToolkitAPI.ShowCustomLayoutPopupParameters(
				'',
				'file://{resources}/layout/operation/operation_store_inspect.xml',
				'rewardid=' +oReward.itempremium.ids[ 0 ] +
				'&' + 'seasonaccess=' + _m_nSeasonAccess
			);
	};

	var _GetRandomMinMax = function( min, max)
	{
		return Math.floor(Math.random() * (max - min) + min);
	};

	var _OnInventoryUpdate = function()
	{
		OperationUtil.ValidateOperationInfo( _m_nSeasonAccess );

		var totalStarsAvailiable = OperationUtil.GettotalPointsFromAvailableFromMissions();
		_SetPurchaseBtns( totalStarsAvailiable );
		_UpdateDialogVarYourStars();
		_UpdateProgressBar( totalStarsAvailiable );
	};

	return {
		Init: _Init,
		CheckUsersOperationStatus: _CheckUsersOperationStatus,
		OnInventoryUpdate: _OnInventoryUpdate
	};
})();

(function () {
	var _m_cp = $.GetContextPanel();
	$.RegisterForUnhandledEvent( 'PanoramaComponent_MyPersona_InventoryUpdated', OperationStore.OnInventoryUpdate );
	$.RegisterForUnhandledEvent( 'UnblurOperationPanel', function(){ OperationUtil.UnblurMenu( _m_cp); } );
	$.RegisterForUnhandledEvent( 'BlurOperationPanel', function(){ OperationUtil.BlurMenu( _m_cp); } );
})();



                                    
    
   	                                
   	                     
   	                                  
   	                                      
   	                              
   	                            

   	                      
   	 
   		                               
   		                           
   		                             

   		                                     
   		                                                    
   		 
   			                                           
   		 
   		                                                  
   	  

   	                                           
   	 
   		                                                                             

   		                                                        
   		                                               

   		                               
   			                    
   			                           
   			                                  
   			                            
   		 
   			       
   		 

   		                          
   		                        

   		                                                                
   		                                                                                   
   		                                            

   		                                         
   		                                                     

   		                        
   		                     

   		                                                                
   			                                        
   			                                       
   		  

   		                                                         
   		                                                                         
		
   		                                                                    
   		                                                                

   		                                                                 
   		                                                                
		
   		                                                                                               
   		                        

   		                                                 
   			                                                                                          
   			                                                     
   		       
		
   		                                       
   		                                
   		                          

   		                                                                                                                    
   		                                       
   		                  
   	  

   	                                      
   	 
   		                           
   		 
   			                                                                                 
   		 

   		                                                                                                
   		                                                                                                         
   	  

   	                                 
   	 
   		                                                                             

   		                                                                 
   		                                                                             
   		                                                    

   		                                                                                          
   			                                                       
   			                                                      
   			                

   		                            
   			                                             
   			                                      
		
   		                                                                             
   		                                                                                   

   		  
   		                               
   		  
   		                                                                                                              
   		                                                                                               
   		                                                                             
   		                   
   		 
   			                   
   			                             
   			                                                           
   			                                      
   			 
   				                                                                 
   					                                                                        
   					  
   				                                                             
   				 
   					                                                           
   					                    
   					 
   						                       
   					 
   					    
   					 
   						                                  
   						                                  
   					 
   					                                      

   					                                                                           
   					                                                                           
   				 
   			    
			
   			                    
   			 
   				                                                                           
   				                                                                                        
   			 
   		 
   		                                               
   			                                        
   		    
   			                                   
   	  

   	                                                                       
   	 
   		                     
   			                                     
   			                
   			             
   		  

   		                                    
   		                                                
   		                                                         
   		                                                                                                                                                     
   		                                                    
   		                                                 
   		                                                                         
   		                                                                                                   
   		                                                                                                                   

   		                                                                
		
   		                                                                  
   		                                        
   	  

   	                        
   	                        
   	                        
   	                                     
   	 
   		                                   

   		                        
   		 
   			       
   		 

   		                                                                                 
   		 
   			                                                                    
   			               
   			 
   				                                                                    

   				                    
   				 
   					                                            
   				 
   			 
			
   			               
   		 
   		                                                                   
   		                                                                      
   		                   
   		                  
   		                   

   		                                    
   		 
   			                                                            
   			                                                                                         
   			                               
   			 
   				                        
   				                                                                                   
   				                                                                
   				                                              

   				                                                                            
   				                                        
   			 

   			                                                                                            

   			                       
   			 
   				                                     
   				                    
   				 
   					                       
   				 
   				       
   			 

   			                                      
   			                                             
   			 
   				                                                                                                                                     
   			 
   			    
   			 
   				                                                                                   
   			 

   			                                                
   			                                                                                                            
   			                                                                                                 

   			                                                                                                                                
   			                                                     
   			                                                                                     
   			                                                                                                                                                              
   			                                                                                

   			                                                       
   		 
   	  

   	                                    
   	 
   		                                              
   		                

   		                                                                      
   			                                                          
   			     
   		 
   			                                     
   			 
   				                                                  

   				                                                                     

   				                          
   				 
   					                                                                                
   				     
   				 
   					              
   						                   
   						                                       
   							                                                                          
   							                                                                        
   							                                          
   					    
   				 
   			 
   		 
   		                                                                                                                            
   		              
   	  

   	                        
   	                        
   	                       
   	                                             
   	 
   		                                                              
   			                                                                     
   			                                                                     
   			                                                                 
   			                                                                 
   			                                                                 
   			                                        
   			               
   			                   
   		    
		
   		                                                

   		                                                                         
   		                                                                         
   	  

   	                                        
   	 
   			                                                                        
   			 

   				                                                             
   				 
   					                                
   					                                        
   					                               
   						                                                                                                    
   					 
   						                     
   						                                

   						                                                                                                                      
   						                                                               

   						                                                                         
   						                                                                            
   						                                       
   						                          
   						                                     
			
   						                                                                                                                    
   						                      
   					 
   				 

   				                                                           
   				 
   					                                       
   					                                                       
   					 
   						                                   
   					 
   				 
   				             
   			  

   			                                                                                             
   	  

   	                   
   	                   
   	                   
   	                                                                 
   	 
   		                            
   		 
   			                                                                            
   			                                                                                           

   			                                                                                                  

   			                   
   			                          
   			                                               
   		 
		
   		             
   		 
   			                    
   			                    
   			                                                                              
   		 
   		    
   		 
   			                    
   			                    
   			                                                                              
   		 
   		                                        
   	  

   	                                                       
   	 
   		                                                     
   		                                                                                

   		                                                                         
   		                                                                        
   		                                                                        
   	  

   	                                                               
   	 
   		                                                                  
   		                                        
		
   		                                                                                
   		                                

   		                                                                                          
   		 
   			                                                                    
   			                                                      
   			                                                                                                     
   		 
   	  

   	                                                                              
   	 
   		                                              

   		                                                           
   		 
   			       
   		 

   		                                                                                    
   	  

   	                                                 
   	 
   		                                                                             

   		                
   		 
   			                                    
   		 
   	  

   	                                                              
   	 
   		                                                                                         
   		                                              
   		                            

   		                                  
   		 
   			                                          
   		 

   		                                                                                        
   		 
   			                                                        
   			 
   				                                                            
   				                     
   			 
   		 

   		                 
   	  

   	                                   
   	 
   		                                                 
   		                                                                        
   			                                                                          
   			                                                                      
   		  
		
   		                          
   	  

   	                                                                                                       
   	 
   		                                                                                  
   		                                           

   		                                                    
   		 
   			                                                                                  
   			                                                                         

   			                
   			 
   				                                                                                                                   
   				                                                    
   				                 
   				                                        
   				                                 
   			 

   			                                                                                                          
   			                                                       
   			                                                                                          
   			                                                
   			 
   				                                 

   				                                       
   				 
   					                                    
   				 
   			 

   			                                
   			 
   				                                                                                                                                      
   			 
   			    
   			 
   				                                                                                                        
   			 
	
   			                                                                
   			                                                                                  
   				             
   				                     
   					          
   					         
   					     
   				    
			
   			                 
   				                
   				           
   				                
   				                    
   			  

   			                                                               
			
   			                                                                                           
   			                                                                                                                             
   			                                                                                                    
			
   			                        
   			 
   				                                                                       
   				 
   					                                  
   						                                    
   					  
   				 
   				    
   				 
   					                                  
   						                                                                      
   					  
   				 
   			 

   			                                                                                                         

   			                
   			 
   				                                                                              
   			 
   		    
   	  

   	                                                        
   	 
   		                                                                                                
   		                                                                                   
   		                                              

   		                                                                                                                            
   			                                
		
   		                                                                                               

   		                          
   		 
   			                                                                           
   		 
   	  

   	                          
   	                          
   	                          
   	                                                                                   
   	 
   		                                        
   		 
   			       
   		 
		
   		                               

   		                        
   			                                                     
   				                                        
   				                                       
   			  

   		                                          

   		                                                 
   		 
   			                          
   		 

   		                                
		
   		                                                               
   		                                      

   		                                               
   		                  
   		 
   			                                                         
   			 
   				                                                                                                                 
   			 
   			    
   			 
   				                                                                                                            
   			 
   		 
   	  

   	                                             
   	 
   		                         
   		 
   			                                   
   		 
		
   		                          
   		                                
   		                                                                                     
   	  

   	                                        
   	 
   		                                                                                                                      
   		                              
   			                             
   				                                                               
   					                                                    
   			 
   		   
   	  

   	                                              
   	 
   		                                                                                    

   		                                 
   			                                                                                              
   			                                                                                            
		
   		                                              
		
   		            
   		 
   			                                                                                                                 
   			                                                                  
   			                                       
   			                                          
   				                              
   					          
   					           
   			    
   		 
   	  

   	                  
   	                  
   	                  
   	                                    
   	 
   		                          
   		 
   			       
   		 

   		                                                                                

   		                                                                      
   		                                                                                                                                     

   		                   
   		                                                                                       
   		                                             
   		                                                  
   		                                                                                                 

   		                                                    
   		                                            
   		                                   

   		                                                                                      
   		             
   		 
   			             
   			 
   				                                                      
   				 
   					                                             
   						   
   						                                                                  
   						                             
   						                          
   						                                  
   						                                  
   						                               
   					  
   				   
   				                                                       
   				 	                                                                                                        
   				   
   			 
   		 
   		    
   		 
   			                                                  
			
   			             
   			 
   				                           
   			 
   			    
   			 
   				                                 
   				 
   					                                                                  
   				 
   			 

   			                                                                              
   			 
   				                                                    
   					                    
   					                                                                                  
   					                      
   					 
   						                                                        
   					 
   					                  
   				  

   				                                                      
   				 
   					                                                     
   					                                             
   						   
   						                                                               
   						                        
   						                          
   						                         
   						                         
   						                                 
   						                           
   						      
   					  
   				   
   				                                                       
   				 
   					                                                     
   					                                                                                             
   					                                                                         
   				   
   			 
   		 

   		                                                                                                               

   		                        
   			              
   			                 
   				        
   			   

   		                                                                               

   		                                 
   		                                                    
   	  

   	                                                            
   	 
   		                                                                            
   		                                                                                            
   		                                                

   		                   
   		 
   			       
   		 

   		                     
   		              
   		 
   			                                                  
   			                                                                                      

   			                                                                                  
   			                                                                              
   			 
   				                                        
   				       
   			 

   			                                                                                                
   			                                                                      

   			                                                                                                                     
   			                                                         
   			                                                                       
   		 
   		    
   		 
   			                                                          
   		 

   		                             
   	  

   	                                               
   	 
   		                                                                        
   		                                 

   		                                                                         
   		                                          
   		 
   			       
   		 

   		                                            
   		 
   			                          
   				              
   				       
   				                          
   					                                        
   					                 
   				 
   			  

   			              
   				            
   				      
   				     
   					               
   					                                          
   				 
   			  

   			              
   				        
   				      
   				                  
   					                                              
   				 
   			  

   			                             

   			                                
   			 
   				                      
   			 

   			                                                                                                                 

   			                                                 
   				           
   				                                  
		
   			                                  
   			 
   				                                                                             
   			 

   			                  
   			 
   				                                                                             
   			 
   			                            
   		    
   	  

   	                                  
   	 
   		                                                             
   			                                                      
   			      
   			      
   	  

   	                                                        
   	 
   		                                                       
   		 
   			       
   		 
		
   		                                                   
   		                                         
   		                                                                                     
   	  

   	                                                               
   	 	
   		                                           
   			              
   			                  
   		  

   		                                            
   		                                                                                   
   		                                         
   	  

   	                                         
   	 	 	
   		                                                                  
   			                                                                         
   			                                                                         
   			                                                                       
   			                                                                       
   			                                                                       
   			                                 
   			               
   			                   
   		    
		
   		                                                    
   	  

   	                                                          
   	 
   		                                                                        
   		                                      

   		                            
   		 
   			                                                                                                      
   			                       

   			                                                    
   			 
   				                                      
   			 
   			    
   			 
   				                                                                                        
   				                                     
   				                                                                                    
	
   				                                                                                  
   				                      
   				 
   					                                          
   				 
   			 

   			                                                                               
   		 
		
   		             
   		 
   			                    
   			                    
   			                                                                                  
   			                                                         
   				                                                                   
   		 
   		    
   		 
   			                    
   			                    
   			                                                                                  
   			                                                         
   				                                                                   
   		 

   		                                                                                     

   		                                                                   
   		                                                                   
   		                                                     
   		                                                                                

   		                                                       
   		 
   			                                                                                                        
   		 

   		                                                       
   		 
   			                                                                                                        
   		 
   	  
	
   	                                                             
   	 
   		                                                                        
   		                                                                        

   		                         
   		                        
	
   		                        
   		                       
   		                                                                                        
   		 
   			                                                         
   		 
   		    
   		 
   			                                                                             
   		 
		
   		                                                                
   		                                                     
   		 
   			                       
   			                                                                         
   				      
   				     
   			  

   			                                                    
   			                                                

   			                  
   			 
   				                                                                                       
   				                         

   				                                            
   				                                       
   				                                               
   				                               
   				                                            
   		  		                                 
   				                                       
   				                                                             
   				                                                   
   				                                                
   				                                               
   				                                              
				
   				          
   				                                      
   				                                                     
   				                                                                        
   			 
   			    
   			 
   				                                        
   			 
   		 
   		    
   		 
   			                       
   			                                                                                                    
   		 
   	 
	
   	                                 
   	 
   		                                           
   	  

   	                                                                         
   	 
   		              
   		                     
   		 
   			                                        
   		 

   		                                  
   		 
   			                                                                                  
   			                                       
   			 
   				                                                                                    
   			 
   		 
   	  

   	                            
   	 
   		                                   
   	  

   	                          
   	 
   		                                  
   	  

   	        
   		            
   		                                                      
   		                        
   		                   
   	  
         

                 
   	                                                                                                                       
   	                                                                                
   	                                                                            
        

