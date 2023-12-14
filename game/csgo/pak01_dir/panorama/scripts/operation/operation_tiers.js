
'use strict';
var OperationTiers = ( function()
{
    var m_tiersPanel = $.GetContextPanel().FindChildInLayoutFile( 'id-op-tiers-panel' );
    var m_tiersIsScrolling = false;
    var m_scheduleHandler = null;
    var m_tiersList = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-list' );
    var m_tiersTitlesSticky = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-list-header-sticky' );
    var m_elTierNav = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-nav' );
    var m_stickyTitleBarThreshold = 0;
    var m_scrollEventHandler = null;
    var m_allRowsData = [];
    var m_rowNameTag = 'id-tiers-row-';

    var _Init = function( m_nSeasonAccess )
    {
        var otierData = _GetTiersData( m_nSeasonAccess );

        if( otierData )
        {
            $.Schedule( 0.1, function() { m_tiersPanel.AddClass( 'show' ); });
            _GetTierRewardItems( otierData );
            _UpdateTierTitle( otierData );
            _NavListEvents();
            _SetScrollToDefaultTier();
        }
    };
    
    var _SetScrollStickyTitleBarThreshold = function()
    {
        m_stickyTitleBarThreshold =  m_tiersPanel.FindChildInLayoutFile( 'id-tiers-list-header' ).contentheight * -1;
    };

    var _UpdateTiersScrolling = function()
    {
        m_scheduleHandler = null;
        if ( m_tiersIsScrolling )
        {
            m_tiersTitlesSticky.SetHasClass( 'hidden', m_tiersList.scrolloffset_y > m_stickyTitleBarThreshold );
            m_tiersIsScrolling = false;
        }

        m_scheduleHandler = $.Schedule( .15, _UpdateTiersScrolling );
    };

    var _CancelUpdateTiersSchedule = function()
	{
		if ( m_scheduleHandler )
		{
			$.CancelScheduled( m_scheduleHandler );
			m_scheduleHandler = null;
		}
	};

    var _OnScrollTiers = function( panelId )
    {
        m_tiersIsScrolling = true;
                               
    };
    
    var _OnReadyForDisplay = function()
    {
        m_scrollEventHandler = $.RegisterEventHandler( 'Scroll', m_tiersList, _OnScrollTiers );
        $.Schedule( 0.1, function() { m_tiersPanel.AddClass( 'show' ); });

        $.Schedule( 0.1, _SetScrollStickyTitleBarThreshold );
        _UpdateTiersScrolling();
    };

    var _OnUnreadyForDisplay = function()
    {
        $.UnregisterEventHandler( 'Scroll', m_tiersList, m_scrollEventHandler );
        m_tiersPanel.RemoveClass( 'show' );
        _CancelUpdateTiersSchedule();
    };

    function _UpdateTierTitle ( oTiersData )
    {
        oTiersData.starsEarned;
        var numStarsNeeded = 0;
        
        for ( var i = oTiersData.starsEarned; i < oTiersData.totalStars; i++ )
        {
            var rewardId = MissionsAPI.GetSeasonalOperationTrackRewardSchema( oTiersData.seasonAccess, i, "item_name" );
            numStarsNeeded++;
            
            if ( rewardId )
            {
                $.GetContextPanel().SetDialogVariableInt( 'stars_needed', numStarsNeeded );
                break;
            }
        }

        $.GetContextPanel().SetDialogVariableInt( 'total_stars', oTiersData.starsEarned );

    }

    function _SetScrollToDefaultTier ()
    {
        var unlockedRow = m_allRowsData.filter( row => row.isUnlocked === true );

        if ( unlockedRow.length > 0 )
        {
            _ScrollToFitRow( unlockedRow[0].idx );
        }
        else
        {
            _ScrollToFitRow( 0 );
        }
    }

    function _GetTiersData ( m_nSeasonAccess )
    {   
        var oTiersData = {
            starsEarned: 0,
            seasonAccess: 0,
            totalStars: 0
        };
        
        oTiersData.seasonAccess = m_nSeasonAccess;

        if ( oTiersData.seasonAccess < 0 &&  oTiersData.seasonAccess)
            return false;
        
                                                  
        oTiersData.totalStars = MissionsAPI.GetSeasonalOperationTrackRewardsCount( oTiersData.seasonAccess );
        var numLoopingExtra = MissionsAPI.GetSeasonalOperationLoopingRewardsCount( oTiersData.seasonAccess );

                                               
        var idxOperation = InventoryAPI.GetCacheTypeElementIndexByKey( 'SeasonalOperations', oTiersData.seasonAccess );
        if ( idxOperation != undefined && idxOperation != null
            && InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'season_value' ) == oTiersData.seasonAccess )
        {	                                                                        
            oTiersData.starsEarned = InventoryAPI.GetCacheTypeElementFieldByIndex( 'SeasonalOperations', idxOperation, 'tier_unlocked' );
        }

                                                                     

                                            
        if ( numLoopingExtra > 0 )
        {	                                                
            oTiersData.totalStars += numLoopingExtra;
                                                                                    
            while ( oTiersData.starsEarned > oTiersData.totalStars - numLoopingExtra )
            {
                oTiersData.totalStars += numLoopingExtra;
            }
        }

        return oTiersData;
    }

    var _GetTierRewardItems = function( oTiersData )
    {
        m_allRowsData= [];
        for ( var i = 0; i < oTiersData.totalStars; i++ )
        {
                                                                                                                                              
                                                                                                                             
			                                                                             
			                                                                                                           
			                                              
            var sRewardFree = MissionsAPI.GetSeasonalOperationTrackRewardSchema( oTiersData.seasonAccess, i, "item_name_free" );
            var sRewardName = MissionsAPI.GetSeasonalOperationTrackRewardSchema( oTiersData.seasonAccess, i, "item_name" );
            var sHighlight = MissionsAPI.GetSeasonalOperationTrackRewardSchema( oTiersData.seasonAccess, i, "highlight" );
            var sCallout = MissionsAPI.GetSeasonalOperationTrackRewardSchema( oTiersData.seasonAccess, i, "callout" );

            var rowData = {};
            rowData.idx = i;
            rowData.itemLists = [];

                                                                                                                  

            var sIntentionalGap = MissionsAPI.GetSeasonalOperationTrackRewardSchema( oTiersData.seasonAccess, i, "none" );
    
            AddItemIds( sRewardName, rowData.itemLists, 'premium' );
            AddItemIds( sRewardFree, rowData.itemLists, 'free' );
   
            rowData.isUnlocked = i < oTiersData.starsEarned;
            rowData.totalStars = oTiersData.totalStars;
            rowData.isGap = sIntentionalGap;
            rowData.isSpecialLandmark = sHighlight === '1';
            rowData.callout = sHighlight === '1' ? $.Localize( sCallout ):'';
            
            m_allRowsData.push( rowData );
        }

        m_allRowsData.forEach( row => {
            _CreateUpdateRewardRow( row );
        });

        _MakeNavLandmarkPanels();
    };

    var AddItemIds = function( sRewardName, itemLists, type )
    {
        var items = {};
        items.type = type;
        items.itemIds = [];
        
        var nameList = sRewardName.split( ',' );
        nameList.forEach( rewardname =>
        {
            if ( rewardname )
            {
				var itemidForReward;
				if ( rewardname.startsWith( 'lootlist:' ) ) {                                               
					itemidForReward = InventoryAPI.GetLootListItemIdByIndex( rewardname, 0 );
				} else {	                                                  
					var nDefinitionIndex = InventoryAPI.GetItemDefinitionIndexFromDefinitionName( rewardname );
					itemidForReward = InventoryAPI.GetFauxItemIDFromDefAndPaintIndex( nDefinitionIndex, 0 );
				}
				items.itemIds.push( itemidForReward );
            }
        } );

        itemLists.push( items );
    };

    var _CreateUpdateRewardRow = function( rewardRowData )
    {
        var elList = m_tiersList.FindChildInLayoutFile( 'id-tiers-list-rows' );
        var elRow = null;

        if ( !elList.FindChildInLayoutFile( m_rowNameTag + rewardRowData.idx ) )
        {
            elRow = $.CreatePanel( "Panel", elList, m_rowNameTag + rewardRowData.idx );
            elRow.BLoadLayoutSnippet( "snippet-tier-row" );
        }
        else
        {
            elRow = elList.FindChildInLayoutFile( m_rowNameTag + rewardRowData.idx );
        }

        rewardRowData.itemLists.forEach( list =>
        {
            _CreateUpdateItemTilesForRow( elRow, list, rewardRowData );
        } );

        if ( rewardRowData.isGap )
        {
            elRow.AddClass( 'shrunk' );
            elRow.enabled = false;
        }

        _SetRowNumberText( elRow, rewardRowData );
    };

    var _CreateUpdateItemTilesForRow = function( elRow, list, rewardRowData )
    {
        var elContainer = elRow.FindChildInLayoutFile( 'id-tier-rewards-' + list.type );
        elContainer.SetHasClass( 'free', list.type === 'free' );
        elContainer.SetHasClass( 'empty', list.itemIds.length === 0 );
        elContainer.enabled = list.itemIds.length > 0;

                       
        if ( list.type === 'premium' )
        {
            elContainer.SetHasClass( 'unlocked', ( OperationMain.IsPremium() && rewardRowData.isUnlocked ) );
        }
        else
        {
            elContainer.SetHasClass( 'unlocked', rewardRowData.isUnlocked );
        }

        if ( list.itemIds.length === 1 )
        {
            var imageIdx = 0;
            _CreateItemImage( list.itemIds[ 0 ], imageIdx, 'Panel', elContainer );
            elContainer.SetPanelEvent( 'onactivate', OnActivateRadioButton.bind( undefined, list.itemIds[ 0 ], list.type, rewardRowData, null ) );
            
            var lootlistItemId = ( InventoryAPI.GetLootListItemsCount( list.itemIds[ 0 ] ) > 0 ) ? ItemInfo.GetLootListItemByIndex( list.itemIds[ 0 ], 0 ) : null;
            if ( lootlistItemId )
            {
                _CacheItemOnMouseOver( elContainer, lootlistItemId );
            }
            else
            {
                _CacheItemOnMouseOver( elContainer, list.itemIds[ 0 ] );
            }
        }
        else if ( list.itemIds.length > 1)
        {
            var elCarousel = _CreateCarousel();
            var elCarouselPage = null;
            list.itemIds.forEach( function( itemid, index )
            {
                                                                
                if ( index % 2 === 0 )
                {
                    elCarouselPage = $.CreatePanel( "Panel",
                    elCarousel,
                        '',
                        {class: 'op-tier__reward-carousel__page'}
                    );
                }
                
                var elItem = _CreateItemImage( itemid, index, 'RadioButton', elCarouselPage );
                elItem.FindChildInLayoutFile('id-tier-row-item-selected').SetImage( 'file://{images}/operations/brackets_half.svg' );
                                             
                 
                elItem.SetPanelEvent( 'onactivate', OnActivateRadioButton.bind( undefined, itemid, list.type, rewardRowData, elContainer ) );

				                                                                                        
				var lootlistItemId = ( InventoryAPI.GetLootListItemsCount( itemid ) > 0 ) ? ItemInfo.GetLootListItemByIndex( itemid, 0 ) : null;
				if ( lootlistItemId )
				{
					_CacheItemOnMouseOver( elItem, lootlistItemId );
				}
				else
				{
					_CacheItemOnMouseOver( elItem, itemid );
				}
            } );
        }

        var elItem = null;
        function _CreateItemImage ( itemId, imageIdx, panelType, elParent )
        {
            if ( !elParent.FindChildInLayoutFile( 'id-tier-reward-' + imageIdx ) )
            {
                elItem = $.CreatePanel( panelType,
                    elParent,
                    'id-tier-reward-' + imageIdx );
                
                elItem.BLoadLayoutSnippet( "snippet-tiers-item" );
            }
            else
            {
                elItem = elRow.FindChildInLayoutFile( 'id-tier-reward-' + imageIdx  );
            }

            elItem.FindChildInLayoutFile( 'id-tier-row-item-image' ).itemid = itemId;

            return elItem;
        }

   
        function _CreateCarousel()
        {
             var elCarousel = null;
            if ( !elContainer.FindChildInLayoutFile( 'op-tier-reward-carousel' ) )
            {
                elCarousel = $.CreatePanel( "Carousel",
                    elContainer,
                    'id-tier-reward-carousel'
                );
                elCarousel.BLoadLayoutSnippet( "snippet-tiers-carousel" );

                $.CreatePanel( "CarouselNav",
                    elContainer,
                    'id-tier-reward-carousel-nav',
                    { carouselid: "id-tier-reward-carousel" }
                );
            }
            else
            {
                elCarousel = elRow.FindChildInLayoutFile( 'op-tier-reward-carousel' );
            }

            elCarousel.Data().type = list.type;
            return elCarousel;
        }

        function _CacheItemOnMouseOver ( elPanel, itemId )
        {
            if ( ItemInfo.IsWeapon( itemId ) )
            {
                elPanel.SetPanelEvent( 'onmouseover', _CacheWeapon.bind( undefined, itemId ) );
            }
        }
    };

    function OnActivateRadioButton( itemId, type, rewardRowData, elContainer )
    {
        OperationInspect.Update( itemId, type, rewardRowData );
        
                                                                 
                                                  
        if ( elContainer )
        {
            elContainer.checked = true;
        }
    }

    var _SetRowNumberText = function( elRow, rewardRowData )
    {
        var elTier = elRow.FindChildInLayoutFile( 'id-tier-row-tier' );
        elTier.SetHasClass( 'unlocked', rewardRowData.isUnlocked );
        elTier.FindChildInLayoutFile( 'id-tier-row-tier-label' ).text = rewardRowData.idx + 1;
    };

    var _GetIndexesForInbetweenLandmarks = function( specialLandmarksList )
    {
        var allLandmarksUpdated = [];
        for ( var i = 0; i < specialLandmarksList.length; i++ )
        {
            allLandmarksUpdated.push( specialLandmarksList[ i ] );
 
            if ( i + 1 < specialLandmarksList.length )
            {
                var landmarkB = specialLandmarksList[ i + 1 ].idx;
                var landmarkA = specialLandmarksList[ i ].idx;
                var tiersInBetween = landmarkB - landmarkA;
                var maxLandmarks = 40;
                var percentOfTotalTiers = tiersInBetween/specialLandmarksList[specialLandmarksList.length -1 ].idx;
                var numTiersInBetween  =   maxLandmarks * percentOfTotalTiers;
                var inBetweenTiersModulo = Math.ceil( numTiersInBetween <= 1 ? tiersInBetween/2 : tiersInBetween/numTiersInBetween) ;
                
                for ( var j = 1; j < tiersInBetween; j++ )
                {
                    if ( j % inBetweenTiersModulo === 0 )
                    {
                        var hasReward = false;
                        var idx = landmarkA + j;
                        var rowData = null;
                        while ( !hasReward )
                        {
                            rowData = m_allRowsData.filter( row => row.idx === idx );
                            if( rowData[0].isGap !== "none" )
                            {
                                hasReward = true;
                            }
                            else
                            {
                                idx++;
                            }

                            if( rowData.length < 1 || hasReward )
                            {
                                break;
                            }
                        }

                        allLandmarksUpdated.push( rowData[0] );
                    }
                }
            }
        }

        return allLandmarksUpdated;
    };

    var _MakeNavLandmarkPanels = function()
    {
        var specialLandmarksList = m_allRowsData.filter( row => row.isSpecialLandmark );
                                                        
        var allLandmarksUpdated = _GetIndexesForInbetweenLandmarks( specialLandmarksList.filter( row => row.idx < 100 ) );

        allLandmarksUpdated.forEach( element =>
        {
            var elEntry = null;

            if ( !m_elTierNav.FindChildInLayoutFile( 'tier-nav-' + element.idx ) )
            {
                elEntry = $.CreatePanel( "RadioButton", 
                    m_elTierNav, 'tier-nav-' + element.idx, 
                    { group:'tier-nav' }
                );
                elEntry.BLoadLayoutSnippet( "snippet-nav-entry" );
            }
            else
            {
                elEntry = m_elTierNav.FindChildInLayoutFile( 'tier-nav-' + element.idx );
            }

            if ( element.isSpecialLandmark  )
            {
                elEntry.AddClass( 'landmark' );
                
                elEntry.FindChild( 'id-tiers-nav-label' ).text = element.callout;
            }
            
            function OnMouseOver ( elEntry )
            {
                var elHighlight = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-nav-highlight' );
                elHighlight.visible = true;
                
                                                                               
                                                                                                
                elHighlight.style.y = (( elEntry.actualyoffset / elEntry.GetParent().actuallayoutheight ) * 100) + '%;';
                elHighlight.FindChild( 'id-tiers-nav-highlight-label' ).text = InventoryAPI.GetItemName( _GetPremiumItemIdFromItemList( element ) );
            }
            
            elEntry.SetPanelEvent( 'onactivate', _ScrollToFitRow.bind( undefined, element.idx ) );
            elEntry.SetPanelEvent( 'onmouseover', OnMouseOver.bind( undefined, elEntry ) );
        } );

        _MoreRewardsBtn( specialLandmarksList );
    };

    var _MoreRewardsBtn = function( specialLandmarksList )
    {
        var elEntry = null;
        if ( !m_elTierNav.FindChildInLayoutFile( 'tier-nav-more' ) )
        {
            elEntry = $.CreatePanel( "Button",
                m_elTierNav, 'tier-nav-more',
                { group: 'tier-nav' }
            );
            elEntry.BLoadLayoutSnippet( "snippet-nav-entry" );
        }
        else
        {
            elEntry = m_elTierNav.FindChildInLayoutFile( 'tier-nav-more' );
        }

        elEntry.AddClass( 'more-rewards' );
        elEntry.FindChild( 'id-tiers-nav-label' ).text = "...More Rewards";
        elEntry.SetPanelEvent( 'onactivate', function()
        {
            var elContextMenu = UiToolkitAPI.ShowCustomLayoutContextMenuParameters(
                '',
                '',
                'file://{resources}/layout/context_menus/context_menu_rewards.xml', 'callback=' + jsContextMenuCallbackHandle );

            elContextMenu.FindChildInLayoutFile( 'Contents' ).Data().aRewardsList = specialLandmarksList.filter( row => row.idx > 100 );
            elContextMenu.AddClass( "ContextMenu_NoArrow" );
        } );

        var jsContextMenuCallbackHandle = UiToolkitAPI.RegisterJSCallback( _ScrollToFitRow );

        elEntry.SetPanelEvent( 'onmouseover', function()
        {
            var elHighlight = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-nav-highlight' );
            elHighlight.visible = false;
        } );
    };

    var _GetPremiumItemIdFromItemList = function (rowData)
    {
        return rowData.itemLists[0].itemIds[0];
    };

    var _ScrollToFitRow = function( idx )
    {
        var elRow = m_tiersList.FindChildInLayoutFile( m_rowNameTag + idx );
        var tileHeight = elRow.contentheight;
        var yPos = ( elRow.actualyoffset + ( tileHeight * 1.5 ) );

        m_tiersList.ScrollToFitRegion( 0, 0, yPos, yPos, 3, true, false );
        $.Schedule( 0.2, function() { 
            elRow.FindChildInLayoutFile( 'id-tier-rewards-premium' ).checked = true;
            if( m_allRowsData[idx].itemLists[0].itemIds[0].length > 1 )
            {
                var elItem = elRow.FindChildInLayoutFile( 'id-tier-rewards-premium' ).FindChildInLayoutFile( 'id-tier-reward-0' );
                if( m_allRowsData[ idx ].itemLists[ 0 ].itemIds.length > 1 )
                {
                    elItem.checked = true;
                }
                var elContainer = elRow.FindChildInLayoutFile( 'id-tier-rewards-' + m_allRowsData[idx].itemLists[0].type );
                OnActivateRadioButton(
                    m_allRowsData[ idx ].itemLists[ 0 ].itemIds[ 0 ],
                    m_allRowsData[ idx ].itemLists[ 0 ].type,
                    m_allRowsData[ idx ],
                    elContainer );
            }
        } );
    };

    var _NavListEvents = function()
    {
        var elList = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-nav' );
        var elHighlight = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-nav-highlight' );

        elList.SetPanelEvent( 'onmouseover', function() { elHighlight.visible = true; } );
        elList.SetPanelEvent( 'onmouseout', function() { $.Schedule( 0.25, _HideHighlighMouseOutsideNav );} );
    };

    var _HideHighlighMouseOutsideNav = function ()
    {
        var elList = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-nav' );
        var elHighlight = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-nav-highlight' );
        
        var isHover = elList.BHasHoverStyle();
        if( !isHover ) {
            elHighlight.visible = false;
        }
    };

    var _CacheWeapon = function( id )
    {
        InventoryAPI.PrecacheCustomMaterials( id );
    };

    return {
        Init: _Init,
        OnReadyForDisplay: _OnReadyForDisplay,
        OnUnreadyForDisplay: _OnUnreadyForDisplay,
        CacheWeapon: _CacheWeapon
    };

} )();

var OperationInspect = ( function()
{
    var m_tiersPanel = $.GetContextPanel().FindChildInLayoutFile( 'id-op-tiers-panel' );
    var m_inspectPanel = m_tiersPanel.FindChildInLayoutFile( 'id-tiers-inspect' );

    var _Update = function( rewardId, type, rowData )
    {
                                                                                          
        m_inspectPanel.SetHasClass( 'free', type === 'free' );
        m_inspectPanel.SetHasClass( 'unlocked', rowData.isUnlocked === true );

        var aLetters = ItemInfo.GetName( rewardId ).split( '' );
        _FillLabelAsTypeWriter( aLetters, m_inspectPanel.FindChildInLayoutFile( 'id-tiers-inspect-name' ), 0.02, true );

                                                            

        var count = ItemInfo.GetLootListCount( rewardId );
        var itemsList = [];
        if ( !count )
        {
            itemsList.push( rewardId );
        }
        else
        {
            for ( var i = 0; i < count; i++ )
            {
                itemsList.push( ItemInfo.GetLootListItemByIndex( rewardId, i ) );
            }
        }

        _MakePips( itemsList, rewardId );
    };

    var _MakePips = function( itemsList, rewardId )
    {
        var elPips = m_inspectPanel.FindChildInLayoutFile( 'id-item-inspect-pips' );
        elPips.RemoveAndDeleteChildren();

        itemsList.forEach( function( itemId, index )
        {
            var elPip = $.CreatePanel(
                "RadioButton",
                elPips,
                'id-tier-pip-' + itemId, {
                    class: 'op-tier__inspect__pips__btn',
                    group:'rewardPip'
                }
            );

            elPip.Data().itemid = itemId;

            if ( ( itemsList.length <= 1 ) )
            {
                elPip.visible = false;
            }

            elPip.BLoadLayoutSnippet( "snippet-inspect-pip" );

            var bIscase = ItemInfo.ItemHasCapability( rewardId, 'decodable' );
            elPip.SetPanelEvent( 'onactivate', onActivate.bind( undefined, itemId, rewardId, index, itemsList.length ) );

            var rarityColor = ( itemId === '0' && bIscase ) ?
                '#ffd700' :
                ItemInfo.GetRarityColor( itemId );
        
            if ( ItemInfo.IsWeapon( itemId ) )
            {
                elPip.SetPanelEvent( 'onmouseover', OperationTiers.CacheWeapon.bind( undefined, itemId ) );
            }

            if ( rarityColor )
            {
                elPip.FindChildInLayoutFile( 'id-tier-inspect-pip-dot' ).style.backgroundColor = rarityColor + ';';
            }
        } );
        
                           
        _InitInspectControls();
    };

    var _InitInspectControls = function()
    {
        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-next' ).SetPanelEvent( 'onactivate', _OnNextPreview.bind( undefined, 1 ) );
        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-prev' ).SetPanelEvent( 'onactivate', _OnNextPreview.bind( undefined, -1 ) );

        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-next' ).SetPanelEvent( 'onmouseover', _NextWeaponPreviewCache.bind( undefined, 1) );
        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-prev' ).SetPanelEvent( 'onmouseover', _NextWeaponPreviewCache.bind( undefined, -1 ) );


                           
        _OnNextPreview( 0 );
    };

    function _OnNextPreview( incrementIndex )
    {
        var elPips = m_inspectPanel.FindChildInLayoutFile( 'id-item-inspect-pips' );
        var aPips = elPips.Children();
        var newIndex = GetSelectedIndex( aPips ) + incrementIndex;

        _UpdateNextPrevBtnState( newIndex, aPips.length );

        aPips[ newIndex ].checked = true;
        $.DispatchEvent( "Activated", aPips[ newIndex ], "mouse" );
        _NextWeaponPreviewCache( incrementIndex );
    }

    function _UpdateNextPrevBtnState ( newIndex, maxPips )
    {
        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-prev' ).enabled = newIndex > 0;
        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-next' ).enabled = newIndex < maxPips - 1;

        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-prev' ).visible = maxPips > 1;
        m_inspectPanel.FindChildInLayoutFile( 'op-tier__inspect__pips-next' ).visible = maxPips > 1;
    }

    function GetSelectedIndex( aPips )
    {
        for ( var i = 0; i < aPips.length; i++ )
        {
            if ( aPips[ i ].checked )
            {
                return i;
            }
        }

        return 0;
    }

    function _NextWeaponPreviewCache ( incrementIndex )
    {
        var elPips = m_inspectPanel.FindChildInLayoutFile( 'id-item-inspect-pips' );
        var aPips = elPips.Children();
        var newIndex = GetSelectedIndex( aPips ) + incrementIndex;

        if ( !aPips[ newIndex ] )
        {
            return;
        }
        
        
        
        OperationTiers.CacheWeapon( aPips[ newIndex ].Data().itemid );
    }

    function onActivate ( itemId, rewardId, index, maxPips )
    {
        var elModel = m_inspectPanel.FindChildInLayoutFile( 'id-tiers-inspect-model' );
        var elImage = m_inspectPanel.FindChildInLayoutFile( 'id-tiers-inspect-image' );
        var elParent = elImage.GetParent();
        elImage.SetHasClass( 'popup-decodable-wash-color-unusual-bg', false );
        elParent.SetDialogVariable( 'item_name', ItemInfo.GetName( itemId ) );

        elModel.visible = false; 
        elImage.visible = false;
        var bIscase = ItemInfo.ItemHasCapability( rewardId, 'decodable' );
        var isCharacter = false;
        
        if ( bIscase && itemId === '0' )
        {
            elImage.visible = true;
            var unusualItemImagePath = InventoryAPI.GetLootListUnusualItemImage( rewardId ) + ".png";
            elImage.SetImage( "file://{images}/" + unusualItemImagePath );
            elImage.SetHasClass( 'popup-decodable-wash-color-unusual-bg', true );
        }
        else
        {
            var model = ItemInfo.GetModelPathFromJSONOrAPI( itemId );
            if ( model )
            {
                elModel.visible = true;
                elModel.SetScene( "resource/ui/econ/ItemModelPanelCharWeaponInspect.res",
                    model,
                    false
                );

                isCharacter = ItemInfo.IsCharacter( itemId );
                elParent.SetHasClass( 'tall', isCharacter );

                if ( isCharacter )
                {
					var settings = ItemInfo.GetOrUpdateVanityCharacterSettings( itemId, 'unowned' );
					settings.panel = elModel;

                    CharacterAnims.PlayAnimsOnPanel( settings );
                    elModel.SetSceneIntroFOV( 1.6, 50000 );
                    elModel.SetFlashlightColor( 4.16, 4.06, 5.20 );
                    elModel.SetFlashlightFOV( 60 );
                                                                
                    elModel.SetFlashlightAmount( 5 );
                    elModel.SetDirectionalLightModify( 1 );
                    elModel.SetDirectionalLightDirection( 0.81, -0.57, -0.17 );
                    elModel.SetDirectionalLightColor(0.29, 0.09, 0.63);
                    elModel.SetAmbientLightColor( 0.17, 0.18, 0.36);
                    elModel.SetCameraPosition(101.19, 2.41, 57.84);
                    elModel.SetCameraAngles( 4.81, 178.85, 0.00 );
                    
                              
                                                          
                                                                         
                                                                                            
                }
                else
                {
                    elModel.SetSceneIntroFOV( 0.7, 50000  );
                }
            }
            else
            {
                elImage.itemid = itemId;
                elImage.visible = true;
            }
        } 
    
        if ( elParent.FindChildInLayoutFile( 'id-tier-inspect-set' ) )
        {
            elParent.FindChildInLayoutFile( 'id-tier-inspect-set' ).DeleteAsync( 0.0 );
        }
        var setName = ItemInfo.GetSet( itemId );
        _UpdateNextPrevBtnState( index, maxPips );

        if ( setName || isCharacter )
        {
            var elSetImage = $.CreatePanel(
                "Image",
                elParent,
                'id-tier-inspect-set',
                {
                    class: 'op-tier__inspect__image-model__set',
                    texturewidth: '256',
                    textureheight: '-1'
                }
            );

            setName = isCharacter ? 'set_community_2' : setName;

            elSetImage.SetImage( 'file://{images}/econ/set_icons/' + setName + '.png' );
            elParent.MoveChildBefore( elSetImage, elModel );
        }

                                   
    }

    var m_handlerSchedule = null;
    function _FillLabelAsTypeWriter ( aLetters, elLabel, delayforNextLetter, bClearLine = false )
	{
        var index = 0;
        
        if ( m_handlerSchedule )
        {
            $.CancelScheduled( m_handlerSchedule );
        }
        m_handlerSchedule = null;

		if ( bClearLine )
		{
			elLabel.text = '';
		}

		_AddLetterToLabel( index );

		function _AddLetterToLabel ( index )
		{
            if ( index < aLetters.length )
			{
				elLabel.text = elLabel.text + aLetters[index];
			}

			index++;
			m_handlerSchedule = $.Schedule( delayforNextLetter, _AddLetterToLabel.bind( undefined, index) );
		}
	}

    var _PlayTransitionEffect = function()
    {
        var moviePlayer = m_inspectPanel.FindChildInLayoutFile( 'id-tier-inspect-transition' );
        moviePlayer.SetMovie("file://{resources}/videos/digital_glitch.webm");
        moviePlayer.Play();

        var elParent = m_inspectPanel.FindChildInLayoutFile( 'id-tier-inspect-image-model' );
        elParent.AddClass( 'transition' );
        

        var min = 0;
        var max = 5;
        var random = Math.floor( Math.random() * ( max - min )) + min;

        if( random <= 2 )
        {
            moviePlayer.style.transform = "rotateZ( 90deg ) scaleX( 1.25 ) scaleY( 1.25 );";
        }
        else{
            moviePlayer.style.transform = "rotateZ( 0deg ) scaleX( 1 ) scaleY( 1 );";
        }
       
        $.Schedule( 0.2,
            function () {
                moviePlayer.Stop();
                moviePlayer.SetMovie("");
                elParent.RemoveClass('transition');
            });
    };


    return {
        Update: _Update,
    };
    
}) ();

( function()
{
    var elTiers = $.GetContextPanel().FindChildInLayoutFile( 'id-op-tiers-panel' );
    $.RegisterEventHandler( "ReadyForDisplay", elTiers, OperationTiers.OnReadyForDisplay );
    $.RegisterEventHandler( "UnreadyForDisplay", elTiers, OperationTiers.OnUnreadyForDisplay );
}) ();

                                              
        
                                                   
                                                                                    

                                                      
            
                                                             
            

                              
                                                                                  
                                                               
              
                            

                                                    
                                                                                                       
                                                                               
               
                                                                                       
               
         

                                                                              
        
                                                     
            
                                                                                
                                       
                
                               
                
            

                        
         