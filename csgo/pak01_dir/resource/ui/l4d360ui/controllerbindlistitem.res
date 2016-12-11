"Resource/UI/ControllerBindListItem.res"
{
	"ControllerBindListItem"
	{
		"ControlName"					"Frame"
		"fieldName"						"ControllerListItem"
		"wide"							"f8"
		"tall"							"30"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"proportionalToParent"			"1"
		"paintBorder"					"0"
		"focusBgColor"					"128 0 0 255"
		"unfocusBgColor"				"64 64 64 255"		
	}

	"LblCommand"
	{
		"ControlName"					"Label"
		"fieldName"						"LblCommand"
		"xpos"							"5"
		"ypos"							"5"
		"wide"							"200"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"proportionalToParent"			"1"
		"labelText"						""
		"Font"                          "DefaultLarge"
	}
	
	
	"LblPressAKey"
	{
		"ControlName"					"Label"
		"fieldName"						"LblPressAKey"
		"xpos"							"310"
		"ypos"							"3"
		"wide"							"200"
		"tall"							"24"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"0"
		"enabled"						"1"
		"tabPosition"					"0"
		"proportionalToParent"			"1"
		"Font"							"DefaultLarge"
		"labelText"						"#L4D360UI_Controller_PressAButton"	[$X360]
		"labelText"						"#L4D360UI_Controller_PressAKey"	[$WIN32]
	}
	
	"LblCurrentBind"
	{
		"ControlName"					"Label"
		"fieldName"						"LblCurrentBind"
		"xpos"							"300"
		"ypos"							"3"
		"wide"							"200"
		"tall"							"24"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"proportionalToParent"			"1"
		"Font"							"GameUIButtons"
		"labelText"						"#GameUI_Icons_UP_DPAD"
	}
}