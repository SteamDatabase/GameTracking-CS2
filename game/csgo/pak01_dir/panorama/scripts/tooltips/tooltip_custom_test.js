function setupTooltip()
{
	var strTest = $.GetContextPanel().GetAttributeString( "test", "not-found" );
	$( '#DynamicLabel' ).text = "Parameter 'test' had value '" + strTest + "'";
}