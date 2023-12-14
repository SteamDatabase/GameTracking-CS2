'use strict';

function setupTooltip()
{
	var ctx = $.GetContextPanel();

	var elBody = $("#BodyLabel");
	elBody.text = "";

	var nTimestamp = ctx.GetAttributeInt( 'timestamp', 0 );
	var strStatValue = ctx.GetAttributeString( 'stat_value', 0 );
	var strStatIdx = ctx.GetAttributeInt( 'stat_index', 0 );
	var strSeriestName = ctx.GetAttributeString( 'series_name', "" );
}