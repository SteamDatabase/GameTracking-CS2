'use strict';

var OperationActiveMissionCard = ( function()
{
    var _Init = function()
    {
        var strMissionId = $.GetContextPanel().GetAttributeString( "missionid", "not-found" );

        if( strMissionId === "not-found" )
        {
            return;
        }

                                                  
        var oMissionDetails = OperationUtil.GetMissionDetails( strMissionId );
        var elMission = OperationMission.CreateMission( 
            $.GetContextPanel().FindChildInLayoutFile( "id-active-mission"), 
            oMissionDetails,
            false );

        var isunlocked = true;
        OperationMission.UpdateMissionDisplay( elMission, oMissionDetails, isunlocked, null );

        var tooltip = $.GetContextPanel().FindChildInLayoutFile( "id-activemission-tooltip");
        if( oMissionDetails.missonType !== "sequential" && oMissionDetails.missonType !== "checklist" )
        {
            tooltip.visible = false;
            return;
        }
        
        var submissionids = [];

        oMissionDetails.aSubQuests.forEach(element => {
            submissionids.push( element.missionId );
        });

        tooltip.SetAttributeString( 'gamemode', oMissionDetails.missionGameMode);
        tooltip.SetAttributeString('mission-id', oMissionDetails.missionId);
        tooltip.SetAttributeString('type', oMissionDetails.missonType);
        tooltip.SetAttributeString('sub-mission-ids', submissionids.join(','));

        tooltip.BLoadLayout('file://{resources}/layout/tooltips/tooltip_mission.xml', false, false );
        tooltip.visible = true;
    }

    return {
		Init: _Init
	};

})();
