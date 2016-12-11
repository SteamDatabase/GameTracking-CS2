"Resource/UI/FoundPublicGames.res"
{
	"FoundPublicGames"
	{
		"ControlName"					"Frame"
		"fieldName"						"FoundPublicGames"
		"xpos"							"0"
		"ypos"							"0"
		"wide"							"f0"
		"tall"							"447"	[$WIN32]
		"tall"							"335"	[$X360]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
	}
	
	"ImgBackground" [$WIN32]
	{
		"ControlName"			"L4DMenuBackground"
		"fieldName"				"ImgBackground"
		"xpos"					"0"
		"ypos"					"94"
		"zpos"					"-1"
		"wide"					"f0"
		"tall"					"312"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"fillColor"				"0 0 0 0"
	}
	
	"LblCampaign"
	{
		"ControlName"					"Label"
		"fieldName"						"LblCampaign"
		"xpos"							"c90"	[$WIN32]
		"ypos"							"235"	[$WIN32]
		"xpos"							"c107"	[$X360]
		"ypos"							"110"	[$X360]
		"zpos"							"2"
		"wide"							"200"
		"tall"							"12"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						""
		"textAlignment"					"north-west"
		"Font"							"DefaultMedium"
		"fgcolor_override"				"TextYellow"
	}
		
	"ImgLevelImage"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelImage"
		"xpos"					"c90"	[$WIN32]
		"ypos"					"142"	[$WIN32]
		"xpos"					"c107"	[$X360]
		"ypos"					"135"	[$X360]
		"wide"					"160"
		"tall"					"80"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"maps/any"
		"scaleImage"			"1"
	}

	"ImgFrame"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgFrame"
		"xpos"					"c85"	[$WIN32]
		"ypos"					"132"	[$WIN32]
		"xpos"					"c102"	[$X360]
		"ypos"					"125"	[$X360]
		"wide"					"196"
		"tall"					"98"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"campaignFrame"
		"scaleImage"			"1"
	}
		
	"LblAuthor" [$WIN32]
	{
		"ControlName"				"Label"
		"fieldName"					"LblAuthor"
		"xpos"						"c90"
		"zpos"						"2"
		"ypos"						"250"
		"wide"						"200"
		"tall"						"12"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"0"
		"enabled"					"1"
		"tabPosition"				"0"
		"labelText"					""
		"textAlignment"				"north-west"
		"Font"						"DefaultMedium"
		"fgcolor_override"			"TextYellow"
	}
	
	"LblGameDifficulty"
	{
		"ControlName"				"Label"
		"fieldName"					"LblGameDifficulty"
		"xpos"						"c90"	[$WIN32]
		"ypos"						"265"	[$WIN32]
		"xpos"						"c107"	[$X360]
		"ypos"						"230"	[$X360]
		"zpos"						"2"
		"wide"						"200"
		"tall"						"12"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"0"
		"enabled"					"1"
		"tabPosition"				"0"
		"labelText"					""
		"textAlignment"				"north-west"
		"Font"						"DefaultMedium"
		"fgcolor_override"			"TextYellow"
	}
	
	"LblGameStatus"
	{
		"ControlName"				"Label"
		"fieldName"					"LblGameStatus"
		"xpos"						"c90"	[$WIN32]
		"ypos"						"280"	[$WIN32]
		"xpos"						"c107"	[$X360]
		"ypos"						"250"	[$X360]
		"zpos"						"2"
		"wide"						"200"
		"tall"						"12"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"labelText"					""
		"textAlignment"				"north-west"
		"Font"						"DefaultMedium"
		"fgcolor_override"			"TextYellow"
	}
	
	"LblGameStatus2"	[$X360]
	{
		"ControlName"				"Label"
		"fieldName"					"LblGameStatus2"
		"xpos"						"c107"
		"ypos"						"270"
		"zpos"						"2"
		"wide"						"200"
		"tall"						"12"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"labelText"					""
		"textAlignment"				"north-west"
		"Font"						"DefaultMedium"
		"fgcolor_override"			"TextYellow"
	}
	
	"LblNewVersion" [$WIN32]
	{
		"ControlName"				"Label"
		"fieldName"					"LblNewVersion"
		"xpos"						"c90"
		"ypos"						"375"
		"zpos"						"2"
		"wide"						"200"
		"tall"						"12"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"labelText"					"#L4D360UI_FoundGames_DownloadNewVersion"
		"textAlignment"				"north-west"
		"Font"						"DefaultMedium"
		"fgcolor_override"			"TextYellow"
	}
	
	"BtnWebsite" [$WIN32]
	{
		"ControlName"				"L4D360HybridButton"
		"fieldName"					"BtnWebsite"
		"xpos"						"c90"
		"ypos"						"360"
		"zpos"						"2"
		"wide"						"200"
		"tall"						"15"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"0"
		"enabled"					"1"
		"tabPosition"				"0"
		"command"					"Website"
		"labelText"					""
		"textAlignment"				"north-west"
		"style"						"MainMenuSmallButton"
		"navLeft"					"GplGames"
		"navDown"					"BtnJoinSelected"
	}
	
	"IconForwardArrow" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconForwardArrow"
		"xpos"					"c75"
		"ypos"					"345"
		"wide"					"15"
		"tall"					"15"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_right"
		"scaleImage"			"1"
	}
	"BtnJoinSelected" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnJoinSelected"
		"xpos"					"c90"
		"ypos"					"345"
		"zpos"					"2"
		"wide"					"200"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"labelText"				"#L4D360UI_FoundGames_JoinGame"
		"tooltiptext"			"#L4D360UI_JoinGame"
		"style"					"MainMenuSmallButton"
		"command"				"JoinSelected"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
		"navLeft"				"GplGames"
		"navUp"					"BtnWebsite"
		"navDown"				"BtnDownloadSelected"
	}
		
	"BtnDownloadSelected" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnDownloadSelected"
		"xpos"					"c90"
		"ypos"					"345"
		"zpos"					"2"
		"wide"					"140"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"0"
		"tabPosition"			"0"
		"wrap"					"1"
		"labelText"				"#L4D360UI_FoundGames_DownloadAddon"
		"tooltiptext"			"#L4D360UI_FoundGames_Join_Download"
		"style"					"RedMainButton"
		"command"				"DownloadSelected"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
		"navLeft"				"GplGames"
		"navUp"					"BtnJoinSelected"
		"navDown"				"BtnWebsite"
	}
		
	"SearchingIcon"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"SearchingIcon"
		"xpos"					"r106"		[$WIN32]
		"xpos"					"r128"		[$X360]
		"ypos"					"27"
		"zpos"					"2"
		"wide"					"32"
		"tall"					"32"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"scaleImage"			"1"
		"image"					"common/l4d_spinner"
	}
	
	"LblPressX"		[$X360]
	{
		"ControlName"					"Label"
		"fieldName"						"LblPressX"
		"xpos"							"82"
		"ypos"							"295"
		"wide"							"200"
		"tall"							"15"
		"zpos"							"2"
		"autoResize"					"1"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"Font"							"GameUIButtonsTiny"
		"labelText"						"#GameUI_Icons_X_3DButton"
	}
		
	"LblNoGamesFound"
	{
		"ControlName"					"Label"
		"fieldName"						"LblNoGamesFound"
		"xpos"							"c-142"		[$WIN32]
		"ypos"							"90"		[$WIN32]
		"xpos"							"c-285" [$X360]
		"ypos"							"80"    [$X360]
		"wide"							"380"
		"tall"							"20"
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						""	//"No Campaign Games Found"
		"textAlignment"					"center" [$X360]
		"textAlignment"					"west" [$WIN32]
		"Font"							"DefaultBold"
	}

	"LblSearching"
	{
		"ControlName"					"Label"
		"fieldName"						"LblSearching"
		"xpos"							"c-320"		[$WIN32]
		"ypos"							"38"		[$WIN32]
		"xpos"							"80"	[$X360]
		"ypos"							"110"	[$X360]
		"zpos"							"0"
		"wide"							"380"		[$WIN32]
		"wide"							"370"		[$X360]
		"tall"							"195"
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"0" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						""
		"textAlignment"					"center"
		"Font"							"MainBold"		[$WIN32]
		"Font"							"FrameTitle"	[$X360]
	}
	
	// top line
	"Divider1" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"Divider1"
		"xpos"					"c-320"
		"ypos"					"110"
		"zpos"					"-1"
		"wide"					"400"
		"tall"					"2"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"divider_gradient"
		"scaleImage"			"1"
	}
	
	// bottom line
	"Divider2" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"Divider2"
		"xpos"					"c-320"
		"ypos"					"325"
		"zpos"					"-1"
		"wide"					"400"
		"tall"					"2"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"divider_gradient"
		"scaleImage"			"1"
	}
		
	"LblFilters" [$WIN32]
	{
		"ControlName"				"Label"
		"fieldName"					"LblFilters"
		"xpos"						"c-280"
		"ypos"						"330"
		"zpos"						"2"
		"wide"						"255"
		"tall"						"15"
		"autoResize"				"1"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
		"labelText"					"#L4D360UI_FoundPublicGames_Filter_Label"
		"textAlignment"				"north-west"
		"Font"						"DefaultMedium"
		"fgcolor_override"			"MediumGray"
		"AllCaps"					"1"
	}

	"DrpFilterCampaign" [$WIN32]
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpFilterCampaign"
		"xpos"					"c-265"
		"ypos"					"345"
		"zpos"					"1"
		"wide"					"320"
		"tall"					"15"
		"visible"				"1"
		"enabled"				"1"
		"navUp"					"BtnFilters"
		"navDown"				"DrpFilterGameStatus"
		
		// button and label
		"BtnDropButton"
		{
			"ControlName"		"L4D360HybridButton"
			"fieldName"			"BtnDropButton"
			"xpos"				"0"
			"ypos"				"0"
			"zpos"				"2"
			"wide"				"320"
			"wideatopen"		"200"
			"tall"				"15"
			"autoResize"		"1"
			"pinCorner"			"0"
			"visible"			"1"
			"enabled"			"1"
			"tabPosition"		"0"
			"labelText"			"#L4D360UI_FoundPublicGames_Filter_Campaign"
			"tooltiptext"		"#L4D360UI_FoundPublicGames_Filter_Campaign_Tip"
			"style"				"DropDownButton"
			"command"			"FlmFilterCampaign"
			"allcaps"			"1"
		}
	}

	"FlmFilterCampaign" [$WIN32]
	{
		"ControlName"		"FlyoutMenu"
		"fieldName"			"FlmFilterCampaign"
		"visible"			"0"
		"wide"				"0"
		"tall"				"0"
		"zpos"				"4"
		"InitialFocus"		"BtnAny"
		"ResourceFile"		"resource/UI/L4D360UI/DropDownFoundGamesFilterCampaign.res"
	}

	"DrpFilterGameStatus" [$WIN32]
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpFilterGameStatus"
		"xpos"				"c-265"
		"ypos"				"360"
		"zpos"				"1"
		"wide"				"320"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"navUp"				"DrpFilterCampaign"
		"navDown"			"DrpFilterDifficulty"
		
		// button and label
		"BtnDropButton"
		{
			"ControlName"	"L4D360HybridButton"
			"fieldName"		"BtnDropButton"
			"xpos"			"0"
			"ypos"			"0"
			"zpos"			"2"
			"wide"			"320"
			"wideatopen"	"200"
			"tall"			"15"
			"autoResize"	"1"
			"pinCorner"		"0"
			"visible"		"1"
			"enabled"		"1"
			"tabPosition"	"0"
			"labelText"		"#L4D360UI_FoundPublicGames_Filter_GameStatus"
			"tooltiptext"	"#L4D360UI_FoundPublicGames_Filter_GameStatus_Tip"
			"style"			"DropDownButton"
			"command"		"FlmFilterGameStatus"
			"allcaps"			"1"
		}
	}

	"FlmFilterGameStatus" [$WIN32]
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmFilterGameStatus"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnAny"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownFoundGamesFilterGameStatus.res"
	}

	"DrpFilterDifficulty" [$WIN32]
	{
		"ControlName"		"DropDownMenu"
		"fieldName"			"DrpFilterDifficulty"
		"xpos"				"c-265"
		"ypos"				"375"
		"zpos"				"1"
		"wide"				"320"
		"tall"				"15"
		"visible"			"1"
		"enabled"			"1"
		"navUp"				"DrpFilterGameStatus"
		"navDown"			"DrpCreateGame"
		
		// button and label
		"BtnDropButton"
		{
			"ControlName"	"L4D360HybridButton"
			"fieldName"		"BtnDropButton"
			"xpos"			"0"
			"ypos"			"0"
			"zpos"			"2"
			"wide"			"320"
			"wideatopen"	"200"
			"tall"			"15"
			"autoResize"	"1"
			"pinCorner"		"0"
			"visible"		"1"
			"enabled"		"1"
			"tabPosition"	"0"
			"labelText"		"#L4D360UI_FoundPublicGames_Filter_Difficulty"
			"tooltiptext"	"#L4D360UI_FoundPublicGames_Filter_Difficulty_Tip"
			"style"			"DropDownButton"
			"command"		"FlmFilterDifficulty"
			"allcaps"			"1"
		}
	}

	"FlmFilterDifficulty" [$WIN32]
	{
		"ControlName"		"FlyoutMenu"
		"fieldName"			"FlmFilterDifficulty"
		"visible"			"0"
		"wide"				"0"
		"tall"				"0"
		"zpos"				"4"
		"InitialFocus"		"BtnAny"
		"ResourceFile"		"resource/UI/L4D360UI/DropDownFoundGamesFilterDifficulty.res"
	}

	"DrpCreateGame"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"DrpCreateGame"
		"xpos"					"c-280" [$WIN32]
		"ypos"					"400"	[$WIN32]
		"wide"					"400"	[$WIN32]
		"tall"					"15"	[$WIN32]
		"xpos"					"102"	[$X360]
		"ypos"					"294"	[$X360]
		"wide"					"180"	[$X360]
		"tall"					"20"	[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"	       			"DrpFilterDifficulty" [$WIN32]
		"navDown"				"BtnCancel" [$WIN32]
		//button and label
		"labelText"				"#L4D360UI_GameSettings_Create_Lobby"
		"style"					"DropDownButton" [$X360]
		"style"					"MainMenuSmallButton" [$WIN32]
		"command"				"StartCustomMatchSearch"
		"ActivationType"		"1" [$X360]
		"allcaps"				"1" [$WIN32]
	}

    "IconBackArrow" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconBackArrow"
		"xpos"					"c-295"
		"ypos"					"415"
		"wide"					"15"
		"tall"					"15"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_left"
		"scaleImage"			"1"
	}

	"BtnCancel" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCancel"
		"xpos"					"c-280"
		"ypos"					"415"
		"zpos"					"1"
		"wide"					"180"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"labelText"				"#L4D360UI_Back_Caps"
		"tooltiptext"			"#L4D360UI_Tooltip_Back"
		"style"					"MainMenuSmallButton"
		"command"				"Back"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
		"navRight"				"BtnJoinSelected"
		"navUp"					"DrpCreateGame"
		"navDown"				"GplGames"
	}
	
	"GplGames"
	{
		"ControlName"			"GenericPanelList"
		"fieldName"				"GplGames"
		"xpos"					"c-320"		[$WIN32]
		"ypos"					"110"		[$WIN32]
		"zpos"					"0"
		"wide"					"400"		[$WIN32]
		"tall"					"217"		[$WIN32]
		"xpos"					"45"		[$X360 && $X360WIDE]
		"xpos"					"20"		[$X360 && !$X360WIDE]
		"ypos"					"124"		[$X360]
		"wide"					"440"		[$X360 && $X360WIDE]
		"wide"					"405"		[$X360 && !$X360WIDE]
		"tall"					"170"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"bgcolor_override" 		"32 32 32 255"
		"NoWrap"				"1"
		"panelBorder"			"2" [$WIN32]
		"navRight"				"BtnJoinSelected" [$WIN32]
		"navDown"				"BtnFilters" [$WIN32]
		"navUp"					"BtnCancel" [$WIN32]
	}
	
	"LblSupportRequiredDetails"
	{
		"ControlName"		"Label"
		"fieldName"			"LblSupportRequiredDetails"
		"xpos"				"c90"
		"ypos"				"300"
		"wide"				"220"
		"tall"				"50" 
		"zpos"				"1"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"font"				"DefaultMedium"
		"textAlignment"		"north-west"
		"labelText"			"#L4D360UI_FOUNDGAMES_ADDON_SUPPORT_REQUIRED"	//"Add-on support is required to play third party campaigns"
		"fgcolor_override"	"MediumGray"
		"wrap"				"1"
	}	
	
	"BtnInstallSupport"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnInstallSupport"
		"xpos"					"c90"
		"ypos"					"340"
		"zpos"					"2"
		"wide"					"250"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"labelText"				"#L4D360UI_ADDON_SUPPORT_INSTALL"			//"INSTALL ADD-ON SUPPORT"
		"style"					"RedButton"		// actually teal!
		"command"				"InstallSupport"
		"proportionalToParent"	"1"
		"usetitlesafe" 			"0"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
		"allcaps"				"1"
	}	
	
	"LblInstalling"
	{
		"ControlName"		"Label"
		"fieldName"			"LblInstalling"
		"xpos"				"c90"
		"ypos"				"300"
		"zpos"				"3"
		"wide"				"250"
		"tall"				"18" 
		"zpos"				"1"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"font"				"DefaultLarge"
		"textAlignment"		"west"
		"labelText"			"#L4D360UI_ADDON_SUPPORT_INSTALLING"	//"INSTALLING ADD-ON SUPPORT..."
	}
	
	"LblInstallingDetails"
	{
		"ControlName"		"Label"
		"fieldName"			"LblInstallingDetails"
		"xpos"				"c90"
		"ypos"				"300"
		"zpos"				"3"
		"wide"				"250"
		"tall"				"50" 
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"font"				"DefaultVerySmall"
		"textAlignment"		"west"
		"labelText"			"#L4D360UI_ADDON_SUPPORT_INSTALLING_DETAILS"	//"Check download progress in the Steam Tools tab."
		"fgcolor_override"			"MediumGray"
	}		
}