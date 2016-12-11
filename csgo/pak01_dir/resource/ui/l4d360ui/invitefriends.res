"Resource/UI/InviteFriends.res"
{
	"InviteFriends"
	{
		"ControlName"		"Frame"
		"fieldName"		"InviteFriends"
		"xpos"			"c-250"
		"ypos"			"c-150"
		"wide"			"500"
		"tall"			"300" [$X360]
		"tall"			"325" [$WIN32]
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"usetitlesafe"	"1"
	}

	"GplFriendList"
	{
		"ControlName"		"GenericPanelList"
		"fieldName"		"GplFriendList"
		"xpos"			"15"
		"ypos"			"30"
		"wide"			"f30"
		"tall"			"268"
		"autoResize"		"1"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"proportionalToParent"	"1"
	}

	"BtnCancel"		[$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCancel"
		"ypos"					"300"
		"xpos"					"10"
		"wide"					"250"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"1"
		"wrap"					"1"
		"labelText"				"#L4D360UI_Back_Caps"
		"tooltiptext"				"#L4D360UI_Tooltip_Back"
		"style"					"DefaultButton"
		"command"				"Back"
		"proportionalToParent"	"1"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
}