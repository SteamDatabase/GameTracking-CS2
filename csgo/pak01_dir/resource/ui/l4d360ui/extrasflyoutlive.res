"Resource/UI/ExtrasFlyoutLive.res"
{
	"PnlBackground"
	{
		"ControlName"		"Panel"
		"fieldName"			"PnlBackground"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"-1"
		"wide"				"156" [$ENGLISH]
		"wide"				"236" [!$ENGLISH]
		"tall"				"65" [$X360]
		"tall"				"65" [$WIN32]
		"visible"			"1"
		"enabled"			"1"
		"paintbackground"	"1"
		"paintborder"		"1"
	}

	"BtnCommunity"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCommunity"
		"xpos"					"0"
		"ypos"					"0"		[$WIN32]
		"ypos"					"0"		[$X360]
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"		[$WIN32]
		"visible"				"1"		[$X360]
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnAddons"
		"navDown"				"BtnCommentary"
		"tooltiptext"			"#L4D360UI_InviteUI_community_Tip"
		"labelText"				"#L4D360UI_InviteUI_community"
		"style"					"FlyoutMenuButton"
		"command"				"InviteUI_community"
		"EnableCondition" 		"LiveRequired"
	}

	"BtnCommentary"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCommentary"
		"xpos"					"0"
		"ypos"					"0"		[$WIN32]
		"ypos"					"20"	[$X360]
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnCommunity"
		"navDown"				"BtnCredits"
		"tooltiptext"			"#L4D360UI_Extras_Commentary_Tip"
		"labelText"				"#L4D360UI_Extras_Commentary"
		"style"					"FlyoutMenuButton"
		"command"				"DeveloperCommentary"
	}

	"BtnCredits"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCredits"
		"xpos"					"0"
		"ypos"					"20"	[$WIN32]
		"ypos"					"40"	[$X360]
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnCommentary"
		"navDown"				"BtnAddons"
		"tooltiptext"			"#L4D360UI_Extras_Credits_Tip"
		"labelText"				"#L4D360UI_Extras_Credits"
		"style"					"FlyoutMenuButton"
		"command"				"Credits"
	}

	"BtnAddons"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnAddons"
		"xpos"					"0"
		"ypos"					"40"	[$WIN32]
		"ypos"					"60"	[$X360]
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"		[$WIN32]
		"visible"				"0"		[$X360]
		"enabled"				"1"
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navUp"					"BtnCredits"
		"navDown"				"BtnCommunity"
		"tooltiptext"			"#L4D360UI_Extras_Addons_Tip"
		"labelText"				"#L4D360UI_Extras_Addons"
		"style"					"FlyoutMenuButton"
		"command"				"Addons"
	}
}