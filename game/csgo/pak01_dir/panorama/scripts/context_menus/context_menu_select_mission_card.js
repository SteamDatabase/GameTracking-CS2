"use-strict";

var SelectMissionCardContextMenu = ( function (){

	var _SetupContextMenu = function()
	{
		var nSeasonIndex = GameTypesAPI.GetActiveSeasionIndexValue();

		if( !nSeasonIndex )
		{
			$.DispatchEvent( 'ContextMenuEvent', '' );
			return;
		}

		OperationUtil.ValidateOperationInfo( nSeasonIndex );
		var activeCardIndex = OperationUtil.GetOperationInfo().nActiveCardIndex;
		var nMissionCards = MissionsAPI.GetSeasonalOperationMissionCardsCount( nSeasonIndex );
		var elParent = $.GetContextPanel().FindChildInLayoutFile( 'ContextMenuMissionsBody' );
		var nBacklog =  InventoryAPI.GetMissionBacklog();

		for( var i = 0; i < nMissionCards; i++ )
		{
			var jsoCardDetails = MissionsAPI.GetSeasonalOperationMissionCardDetails( nSeasonIndex, i );
			var isUnlocked = i < nBacklog
			var nWeek = i + 1;

			var newEntry = $.CreatePanel( 'Panel', elParent, 'mission-card-entry-'+i );
			newEntry.BLoadLayoutSnippet('mission-card-entry');
			newEntry.SetDialogVariableInt( 'week', nWeek );
			newEntry.SetDialogVariable( 'name', $.Localize( jsoCardDetails.name ));

			var oPoints = OperationUtil.GetMissionCardEarnedPoints( jsoCardDetails )
			var nEarned =  oPoints.totalCardPointsDisplay;

			newEntry.SetDialogVariableInt( 'earned', nEarned);
			newEntry.SetDialogVariableInt( 'total', jsoCardDetails.operational_points );
			newEntry.SetHasClass('show-locked', !isUnlocked );
			                                                           
			newEntry.SetHasClass('show-check', oPoints.totalCardPoints === oPoints.totalPossilbePoints && isUnlocked );
			newEntry.SetPanelEvent( 'onactivate',_OnActivate.bind( undefined, i ));

			var elTimer = newEntry.FindChildInLayoutFile( 'id-mission-context-entry-timer' );
			var seconds = InventoryAPI.GetSecondsUntilNextMission();

			if( seconds && seconds > 0 && i === nBacklog )
			{
				newEntry.SetDialogVariable( 'time', FormatText.SecondsToSignificantTimeString( seconds ));
				elTimer.visible = true;
			}
			else
			{
				elTimer.visible = false;
			}
		}
	};

	var _OnActivate = function( index )
	{
		var callbackHandle = $.GetContextPanel().GetAttributeInt( "callback", -1 );
		if ( callbackHandle != -1 )
		{
			UiToolkitAPI.InvokeJSCallback( callbackHandle, index );
		}

		$.DispatchEvent( 'ContextMenuEvent', '' );
	}

	return {
		SetupContextMenu: _SetupContextMenu
	};
})();
