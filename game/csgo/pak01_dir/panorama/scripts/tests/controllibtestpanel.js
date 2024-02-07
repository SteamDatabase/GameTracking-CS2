var Setup = function()
{
	var str = $.GetContextPanel().GetAttributeString( "MyCustomProp", "(not found)" );
	$.GetContextPanel().SetDialogVariable( "mycustompropvalue", str );

	if ( $.GetContextPanel().GetAttributeInt( "CreatedFromJS", 0.0 ) )
	{
		$( "#MyLabel" ).AddClass( "Warning" );
	}
};