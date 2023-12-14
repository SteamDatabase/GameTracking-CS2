'use strict';

var PopupTournamentTeamsList = ( function()
{

    var _Init = function()
    {
        var journalId = $.GetContextPanel().GetAttributeString( "journalid", '' );
        var graffitiList = g_ActiveTournamentTeams
        graffitiList.push( g_ActiveTournamentInfo );

        graffitiList.forEach( function( team )
        {
            var itemid = ItemInfo.GetFauxItemIdForGraffiti( team.stickerid_graffiti );
            var elTeam = $.CreatePanel( "ItemImage",
                $.GetContextPanel().FindChildInLayoutFile( 'id-popup-tournament-teams' ),
                team.team,
                {
                    itemid: itemid,
                    class: 'popup-tournament-select-spray-team'
                }
                
            );

            function EquipSpray ( id )
            {
                InventoryAPI.SetItemAttributeValueAsync( journalId, "sticker slot 0 id", id );
                LoadoutAPI.EquipItemInSlot( 'noteam', journalId, 'spray0' );
                $.DispatchEvent( 'UIPopupButtonClicked', '' );
            }
            
            elTeam.SetPanelEvent( 'onactivate', EquipSpray.bind( undefined, team.stickerid_graffiti ) );
        } );

    };

 
	return {
        Init: _Init
	};

})();