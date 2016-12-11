"Resource/UI/InGameChapterSelect.res"
{
	"InGameChapterSelect"
	{
		"ControlName"				"Frame"
		"fieldName"					"InGameChapterSelect"
		"xpos"						"0"
		"ypos"						"0"
		"wide"						"f0"
		"tall"						"260"		[$WIN32]
		"tall"						"260"		[$X360]
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
	}
	
	"ImgBackground"
	{
		"ControlName"			"L4DMenuBackground"
		"fieldName"				"ImgBackground"
		"xpos"					"0"
		"ypos"					"110"
		"zpos"					"-1"
		"wide"					"f0"
		"tall"					"260"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"				[$WIN32]
		"visible"				"0"				[$X360]
		"enabled"				"1"
		"tabPosition"			"0"
		"fillColor"				"0 0 0 0"
	} 
	
	"ImgLevelImage"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelImage"
		"xpos"					"c51"
		"ypos"					"125"
		"wide"					"200"
		"tall"					"100"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"maps/any"
		"scaleImage"			"1"
	}
	"ImgLevelImageFrame"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelImageFrame"
		"xpos"					"c45" 
		"ypos"					"113" 
		"wide"					"246" 
		"tall"					"123" 
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"campaignFrame"
		"scaleImage"			"1"
	}	
		
	// Campaign dropdown
	"DrpMission"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpMission"
		"xpos"					"c-250"
		"ypos"					"120"
		"zpos"					"1"
		"wide"					"280"
		"tall"					"15"			[$WIN32]
		"tall"					"20"			[$X360]
		"visible"				"1"
		"enabled"				"1"
		"navUp"					"BtnCancel"
		"navDown"				"DrpChapter"
		
		//button and label
		"BtnDropButton"
		{
			"ControlName"					"L4D360HybridButton"
			"fieldName"						"BtnDropButton"
			"xpos"							"0"
			"ypos"							"0"
			"zpos"							"2"
			"wide"							"280"
			"wideatopen"					"160"
			"tall"							"15"	[$WIN32]
			"tall"							"20"	[$X360]
			"autoResize"					"1"
			"pinCorner"						"0"
			"visible"						"1"
			"enabled"						"1"
			"tabPosition"					"0"
			"labelText"						"#L4D360UI_GameSettings_Mission"
			"tooltiptext"					"#L4D360UI_GameSettings_Tooltip_Mission"
			"disabled_tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Mission_Disabled"
			"style"							"DropDownButton"
			"command"						"FlmMission"
			"ActivationType"				"1"		[$X360]
			"EnableCondition"				"Never" [$DEMO]
		}
	}
	
	// Campaign flyout	
	"FlmMissionCoop"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionCoop"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnCampaign1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMission.res"
	}

	// Realism flyout	
	"FlmMissionRealism"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionRealism"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnCampaign1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMission.res"
	}

	// Versus flyout	
	"FlmMissionVersus"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionVersus"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnCampaign1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionVersus.res"
	}
	
	// Team Versus flyout	
	"FlmMissionTeamVersus"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionTeamVersus"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnCampaign1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionVersus.res"
	}
	
	// Survival flyout	
	"FlmMissionSurvival"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionSurvival"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnCampaign1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionSurvival.res"
	}

	// Scavenge flyout	
	"FlmMissionScavenge"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionScavenge"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnCampaign1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionScavenge.res"
	}
	
	// Team Scavenge flyout
	"FlmMissionTeamScavenge"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionTeamScavenge"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnCampaign1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionScavenge.res"
	}
	
	// Chapter Dropdown
	"DrpChapter"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpChapter"
		"xpos"					"c-250"
		"ypos"					"140"			[$WIN32]
		"ypos"					"145"			[$X360]
		"zpos"					"1"
		"wide"					"280"
		"tall"					"15"			[$WIN32]
		"tall"					"20"			[$X360]
		"visible"				"1"
		"enabled"				"1"
		"navUp"					"DrpMission"
		"navDown"				"BtnSelect"
		
		//button and label
		"BtnDropButton"
		{
			"ControlName"					"L4D360HybridButton"
			"fieldName"						"BtnDropButton"
			"xpos"							"0"
			"ypos"							"0"
			"zpos"							"2"
			"wide"							"280"
			"wideatopen"					"160"
			"tall"							"15"	[$WIN32]
			"tall"							"20"	[$X360]
			"autoResize"					"1"
			"pinCorner"						"0"
			"visible"						"1"
			"enabled"						"1"
			"tabPosition"					"0"
			"labelText"						"#L4D360UI_GameSettings_Chapter"
			"tooltiptext"					"#L4D360UI_GameSettings_Tooltip_Chapter"
			"disabled_tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Chapter_Disabled"
			"style"							"DropDownButton"
			"command"						""
			"ActivationType"				"1" [$X360]
		}
	}
	
	//flyouts		
	"FlmChapterXXautogenerated"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmChapterFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnChapter1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownChapter.res"
	}

	"IconForwardArrow"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconForwardArrow"
		"xpos"					"c-265"		[$WIN32]	
		"xpos"					"c-275"		[$X360]
		"ypos"					"160"		[$WIN32]
		"ypos"					"170"		[$X360]
		"wide"					"15"        [$WIN32]
		"tall"					"15"        [$WIN32]
		"wide"					"20"        [$X360]
		"tall"					"20"        [$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_right"
		"scaleImage"			"1"
	}
	"BtnSelect"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnSelect"
		"xpos"					"c-250"
		"ypos"					"160"			[$WIN32]
		"ypos"					"170"			[$X360]
		"wide"					"220"
		"tall"					"15"			[$WIN32]
		"tall"					"20"			[$X360]
		"zpos"					"0"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"1"
		"wrap"					"1"
		"navUp"					"DrpChapter"
		"navDown"				"BtnCancel"
		"labelText"				"#L4D_btn_select"
		"tooltiptext"			"#L4D360UI_ChangeScenario_Tip"
		"style"					"DefaultButton"
		"command"				"Select"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
	
	"IconBackArrow"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconBackArrow"
		"xpos"					"c-265"		[$WIN32]
		"xpos"					"c-275"		[$X360]
		"ypos"					"180"		[$WIN32]
		"ypos"					"191"		[$X360]
		"wide"					"15"		[$WIN32]
		"tall"					"15"		[$WIN32]
		"wide"					"20"		[$X360]
		"tall"					"20"		[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"0"			[$X360]
		"visible"				"1"			[$WIN32]
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_left"
		"scaleImage"			"1"
	}

	"BtnCancel"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCancel"
		"xpos"					"c-250"
		"ypos"					"180"		[$WIN32]
		"ypos"					"195"		[$X360]
		"wide"					"220"
		"tall"					"15"		[$WIN32]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnSelect"
		"navDown"				"DrpMission"
		"labelText"				"#L4D360UI_Back_Caps"
		"tooltiptext"			"#L4D360UI_Tooltip_Back"
		"style"					"DefaultButton"
		"command"				"Cancel"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
}
