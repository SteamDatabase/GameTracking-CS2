"Resource/UI/MiniMOTD.res"		//the screen that comes up when you press TAB
{
	"info"
	{
		"ControlName"		"CTextWindow"
		"fieldName"		"TextWindow"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"480"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"PaintBackgroundType"	"0"
		"settitlebarvisible" "0"
		"bgcolor_override"	"0 0 0 0"
		"infocus_bgcolor_override" "0 0 0 0"
		"outoffocus_bgcolor_override" "0 0 0 0"
	}

	"MessageTitle"
	{
		"ControlName"		"Label"
		"fieldName"			"MessageTitle"
		"xpos"				"c-240"
		"ypos"				"110"
		"wide"				"480"
		"tall"				"30"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"0"
		"labelText"			"Message Title"
		"textAlignment"		"west"
		"dulltext"			"0"
		"brighttext"		"0"
		"font"				"MainBold"
		"fgcolor_override"	"255 255 255 255"
	}
		
	"HTMLMessage"
	{
		"ControlName"	"HTML"
		"fieldName"		"HTMLMessage"
		"xpos"			"c-240"
		"ypos"			"140"
		"wide"			"20"
		"tall"			"240"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"0"
	}
	
	// This just hides the old text message, because we're replacing it with our fancier TerrorTextMessage below.
	"TextMessage"
	{
		"ControlName"	"TextEntry"
		"fieldName"		"TextMessage"
		"visible"		"0"
		"enabled"		"0"
	}
	
	"TerrorTextMessage"
	{
		"ControlName"	"CTerrorRichText"
		"fieldName"		"TerrorTextMessage"
		"xpos"			"c-240"
		"ypos"			"140"
		"wide"			"480"
		"tall"			"240"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"0"
		"textAlignment"	"northwest"
		"textHidden"	"0"
		"editable"		"0"
		"maxchars"		"-1"
	}

	"ThirdPartyServerPanel"
	{
		"ControlName"	"CThirdPartyServerPanel"
		"fieldName"		"ThirdPartyServerPanel"
		"xpos"			"r300"
		"ypos"			"15"
		"wide"			"300"
		"tall"			"130"
		"visible"		"1"		[$WIN32]
		"visible"		"0"	    [$X360]
		"enabled"		"1"
	}
}
