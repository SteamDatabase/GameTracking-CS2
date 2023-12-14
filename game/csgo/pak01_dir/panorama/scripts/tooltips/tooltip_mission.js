
'use-strict';

var TooltipMission = ( function()
{
	function _Init()
	{
		var strMissionIds = $.GetContextPanel().GetAttributeString( "sub-mission-ids", "not-found" );
		if( strMissionIds === "not-found" )
		{ 
			return;
		}

		$.GetContextPanel().SetHasClass( 'show', true )

		var aSubmissionStrings = strMissionIds.split( ',' );
		var elParent = $.GetContextPanel().FindChildInLayoutFile( 'id-tooltip-mission-list' );
		elParent.RemoveAndDeleteChildren();

		var strType = $.GetContextPanel().GetAttributeString( "type", "not-found" );
		var completedIndex = 0;

		aSubmissionStrings.forEach( (element, index) => {
			var elCheckbox = $.CreatePanel( 'Panel', elParent, 'id-' + element );
			elCheckbox.BLoadLayoutSnippet( strType +'-mission' );
			MissionsAPI.ApplyQuestDialogVarsToPanelJS( Number( element ), elCheckbox );
			elCheckbox.SetDialogVariable( 'missiontext', $.Localize( MissionsAPI.GetQuestDefinitionField( Number( element ), "loc_description" ), elCheckbox ) );

			var nRemaining = MissionsAPI.GetQuestPoints(  Number( element ), "remaining" );
			elCheckbox.SetHasClass( 'complete', nRemaining === 0 );

			var nUncommitted = MissionsAPI.GetQuestPoints( Number( element ), "uncommitted" );
			var nGoal = MissionsAPI.GetQuestPoints( Number( element ), "goal" );
			elCheckbox.SetHasClass( 'uncommitted', nUncommitted >= nGoal );

			completedIndex = nRemaining === 0 ? index : 0;
		});

		var aCheckboxes = elParent.Children();
		aCheckboxes[ aCheckboxes.length - 1 ].SetHasClass( "hide-connector", strType === 'sequential' );
		
		var gamemode = $.GetContextPanel().GetAttributeString( "gamemode", "not-found" );
		var elIcon = $.GetContextPanel().FindChildInLayoutFile( 'id-tooltip-mission-icon' );
		if( gamemode === "not-found")
		{
			elIcon.visible = false;
			return;
		}
		
		elIcon.visible = true;
		elIcon.SetImage( 'file://{images}/icons/ui/' + gamemode + '.svg' );

		var missionId = $.GetContextPanel().GetAttributeString( "mission-id", "not-found" );
		var MissionItemID = InventoryAPI.GetQuestItemIDFromQuestID( Number( missionId ) );

		MissionsAPI.ApplyQuestDialogVarsToPanelJS( Number( missionId ), $.GetContextPanel() );
		$.GetContextPanel().FindChildInLayoutFile( 'id-tooltip-mission-title' ).text = InventoryAPI.GetItemName( MissionItemID );
		$.GetContextPanel().FindChildInLayoutFile( 'id-tooltip-mission-desc' ).SetLocalizationString( MissionsAPI.GetQuestDefinitionField( Number( missionId ), "loc_description" ) );
		$.GetContextPanel().FindChildInLayoutFile( 'id-tooltip-mission-type_desc' ).text = $.Localize( "#op_misson_"+strType+"_tooltip" );
		
	};

	return {
		Init: _Init
	}
} )();

( function()
{
	                                                     
} )();