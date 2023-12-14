'use strict';


	function Init()
	{
		var elContainer = $.GetContextPanel();
		var elRoot = $.GetContextPanel();

		while ( elRoot.GetParent() )
			elRoot = elRoot.GetParent();
		
		var elEom = elRoot.FindChildTraverse( "EndOfMatch" );

		elEom.SetParent( $.GetContextPanel() );
	}