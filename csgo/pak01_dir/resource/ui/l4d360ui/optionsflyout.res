"Resource/UI/OptionsFlyout.res"
{
	"PnlBackground"
	{
		"ControlName"		"Panel"
		"fieldName"			"PnlBackground"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"-1"
		"wide"				"156"
		"tall"				"65" [$X360]
		"tall"				"125" [$WIN32]
		"visible"			"1"
		"enabled"			"1"
		"paintbackground"	"1"
		"paintborder"		"1"
	}

	"BtnAudioVideo"	[$X360]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnAudioVideo"
		"xpos"					"0"
		"ypos"					"0"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnStorage"
		"navDown"				"BtnController"
		"tooltiptext"			"#L4D360UI_Options_AudioVideo"
		"disabled_tooltiptext"	"#L4D360UI_Options_AudioVideo_Disabled"
		"labelText"				"#L4D360UI_AudioVideo"
		"style"					"FlyoutMenuButton"
		"command"				"AudioVideo"
	}
	
	"BtnController"	[$X360]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnController"
		"xpos"					"0"
		"ypos"					"20"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navUp"					"BtnAudioVideo"
		"navDown"				"BtnStorage"
		"tooltiptext"			"#L4D360UI_Options_Controller"
		"disabled_tooltiptext"	"#L4D360UI_Options_Controller_Disabled"
		"labelText"				"#L4D360UI_Controller"
		"style"					"FlyoutMenuButton"
		"command"				"Controller"
	}

	"BtnStorage"	[$X360]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnStorage"
		"xpos"					"0"
		"ypos"					"40"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"EnableCondition"		"Never" [$DEMO]
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navUp"					"BtnController"
		"navDown"				"BtnAudioVideo"
		"tooltiptext"			"#L4D360UI_Options_Storage"
		"disabled_tooltiptext"	"#L4D360UI_Options_Storage_Disabled"
		"labelText"				"#L4D360UI_Storage"
		"style"					"FlyoutMenuButton"
		"command"				"Storage"
	}
	
	"BtnVideo"	[$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnVideo"
		"xpos"					"0"
		"ypos"					"0"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnCloud"
		"navDown"				"BtnBrightness"
		"tooltiptext"			"#L4D_video_tip"
		"labelText"				"#GameUI_Video"
		"style"					"FlyoutMenuButton"
		"command"				"Video"
	}
	
	"BtnBrightness"	[$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnBrightness"
		"xpos"					"0"
		"ypos"					"20"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnVideo"
		"navDown"				"BtnAudio"
		"tooltiptext"			"#GameUI_AdjustGamma"
		"disabled_tooltiptext"	"#L4D360UI_AdjustGamma_Disabled"
		"labelText"				"#GameUI_Brightness"
		"style"					"FlyoutMenuButton"
		"command"				"Brightness"
	}
	
	"BtnAudio"	[$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnAudio"
		"xpos"					"0"
		"ypos"					"40"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnBrightness"
		"navDown"				"BtnController"
		"tooltiptext"			"#L4D_audio_tip"
		"labelText"				"#GameUI_Audio"
		"style"					"FlyoutMenuButton"
		"command"				"Audio"
	}
	
	"BtnController"	[$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnController"
		"xpos"					"0"
		"ypos"					"60"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navUp"					"BtnAudio"
		"navDown"				"BtnMultiplayer"
		"tooltiptext"			"#L4D_keyboard_tip"
		"labelText"				"#L4D360UI_KeyboardMouse"
		"style"					"FlyoutMenuButton"
		"command"				"KeyboardMouse"
	}
	
	"BtnMultiplayer"	[$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnMultiplayer"
		"xpos"					"0"
		"ypos"					"80"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navUp"					"BtnController"
		"navDown"				"BtnCloud"
		"tooltiptext"			"#L4D_multiplayer_tip"
		"labelText"				"#GameUI_Multiplayer"
		"style"					"FlyoutMenuButton"
		"command"				"MultiplayerSettings"
	}
	
	"BtnCloud"	[$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCloud"
		"xpos"					"0"
		"ypos"					"100"
		"wide"					"150"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"proportionalToParent"	"1"
		"navUp"					"BtnMultiplayer"
		"navDown"				"BtnVideo"
		"tooltiptext"			"#L4D_steamcloud_tip"
		//"disabled_tooltiptext"	"#L4D_steamcloud_disabled_tip"
		"labelText"				"#L4D360UI_Cloud_Title"
		"style"					"FlyoutMenuButton"
		"command"				"CloudSettings"
	}
}