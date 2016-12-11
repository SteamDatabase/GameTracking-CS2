"Resource/UI/TeamLobby.res"
{
	"GameLobby"
	{
		"ControlName"			"Frame"
		"fieldName"				"GameLobby"
		"xpos"					"0"
		"ypos"					"0"
		"wide"					"f0"
		"tall"					"420"		[$WIN32]
		"tall"					"380"		[$X360]
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"title_xpos"			"241"		[$WIN32]
	}

	"ImgBackground"
	{
		"ControlName"		"L4DMenuBackground"
		"fieldName"			"ImgBackground"
		"xpos"				"0"
		"ypos"				"70"
		"zpos"				"-1"
		"wide"				"f0"
		"tall"				"300"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"		[$WIN32]
		"visible"			"0"		[$X360]
		"enabled"			"1"
		"tabPosition"		"0"
		"fillColor"			"0 0 0 0"
	}
	
	"WorkingAnim"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"WorkingAnim"
		"xpos"					"c214"		[$WIN32]
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

	"GplSurvivors"
	{
		"ControlName"			"GenericListPanel"
		"fieldName"				"GplSurvivors"
		"xpos"					"c32"
		"ypos"					"100"
		"zpos"					"2"
		"wide"					"f0"
		"tall"					"f0"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navLeft"				"BtnStartGame"	
		"bcolor_override"		"0 0 0 0"
		"NoDrawPanel"			"1"
		"arrowsVisible"			"0"
	}

	"FlmPlayerFlyout"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmPlayerFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnSendMessage"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownLobbySteamPlayer.res"
	}
			
	"FlmPlayerFlyoutLeader"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmPlayerFlyoutLeader"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnSendMessage"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownLobbySteamPlayerLeader.res"
	}
			
	"LblLeaderLine"
	{
		"ControlName"			"Label"
		"fieldName"				"LblLeaderLine"
		"xpos"					"c-240" [$WIN32 && $ENGLISH]
		"xpos"					"c-260" [$WIN32 && !$ENGLISH]
		"ypos"					"100"
		"zpos"					"2"
		"wide"					"275"	[$WIN32 && $ENGLISH]
		"wide"					"300"	[$WIN32 && !$ENGLISH]
		"xpos"					"c-260" [$X360]
		"wide"					"275"	[$X360]
		"tall"					"32"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				""
		"Font"					"DefaultMedium" [$ENGLISH]
		"Font"					"DefaultMedium" [$FRENCH]
		"Font"					"DefaultMedium" [$GERMAN]
		"Font"					"DefaultMedium" [$ITALIAN]
		"Font"					"DefaultMedium" [$SPANISH]
		// these need a smaller font because the gamer names in the lobbys were not TCR safe  
		// because these languages use a fallback font instead of Trade Gothic and the names were getting ... added to them
		"Font"					"DefaultBold" [$PORTUGUESE]
		"Font"					"DefaultBold" [$POLISH]
		"Font"					"DefaultBold" [$RUSSIAN]
		"Font"					"DefaultBold" [$SCHINESE]
		"Font"					"DefaultBold" [$TCHINESE]
		"Font"					"DefaultBold" [$KOREAN]
		"Font"					"DefaultBold" [$JAPANESE]		
		"fgcolor_override"		"255 255 255 255"
		"noshortcutsyntax"		"1"
	}					

	"ImgLevelImage"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelImage"
		"xpos"					"c-244" [$WIN32 && $ENGLISH]
		"xpos"					"c-264" [$WIN32 && !$ENGLISH]
		"ypos"					"132"
		"xpos"					"c-254" [$X360]
		"zpos"					"2"
		"wide"					"125"
		"tall"					"65"
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
		"xpos"					"c-250" [$WIN32 && $ENGLISH]
		"xpos"					"c-270" [$WIN32 && !$ENGLISH]
		"ypos"					"125"
		"xpos"					"c-260" [$X360]
		"zpos"					"3"
		"wide"					"158"
		"tall"					"79"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"campaignFrame"
		"scaleImage"			"1"
	}	
			
	"LblSummaryLine1"
	{
		"ControlName"			"Label"
		"fieldName"				"LblSummaryLine1"
		"xpos"					"c-105" [$WIN32 && $ENGLISH]
		"xpos"					"c-128" [$WIN32 && !$ENGLISH]
		"ypos"					"128"
		"xpos"					"c-115" [$X360]
		"zpos"					"2"
		"wide"					"240"
		"tall"					"32"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				""		
		"Font"					"DefaultMedium"
		"textAlignment"			"north-west"
		"wrap"					"1"	
		"fgcolor_override"		"TextYellow"
	}
			
	"LblSummaryLine2"
	{
		"ControlName"			"Label"
		"fieldName"				"LblSummaryLine2"
		"xpos"					"c-105" [$WIN32 && $ENGLISH]
		"xpos"					"c-128" [$WIN32 && !$ENGLISH]
		"ypos"					"143"
		"xpos"					"c-115" [$X360]
		"zpos"					"2"
		"wide"					"240"
		"tall"					"32"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				""
		"Font"					"DefaultMedium"
		"textAlignment"			"north-west"
		"fgcolor_override"		"TextYellow"
	}	
		
	"LblSummaryLine3"
	{
		"ControlName"			"Label"
		"fieldName"				"LblSummaryLine3"
		"xpos"					"c-105" [$WIN32 && $ENGLISH]
		"xpos"					"c-128" [$WIN32 && !$ENGLISH]
		"ypos"					"158"
		"xpos"					"c-115" [$X360]
		"zpos"					"2"
		"wide"					"240"
		"tall"					"32"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				""		
		"Font"					"DefaultMedium"
		"textAlignment"			"north-west"		
		"fgcolor_override"		"TextYellow"
	}

	"LblSummaryLine4"
	{
		"ControlName"			"Label"
		"fieldName"				"LblSummaryLine4"
		"xpos"					"c-105" [$WIN32 && $ENGLISH]
		"xpos"					"c-128" [$WIN32 && !$ENGLISH]
		"ypos"					"173"
		"xpos"					"c-115" [$X360]
		"zpos"					"2"
		"wide"					"240"
		"tall"					"32"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				""		
		"Font"					"DefaultMedium"
		"textAlignment"			"north-west"		
		"fgcolor_override"		"TextYellow"
	}

	"LblSummaryLine5"
	{
		"ControlName"			"Label"
		"fieldName"				"LblSummaryLine5"
		"xpos"					"c-105" [$WIN32 && $ENGLISH]
		"xpos"					"c-128" [$WIN32 && !$ENGLISH]
		"ypos"					"188"
		"xpos"					"c-115" [$X360]
		"zpos"					"2"
		"wide"					"240"
		"tall"					"32"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				""		
		"Font"					"DefaultMedium"
		"textAlignment"			"north-west"		
		"fgcolor_override"		"TextYellow"
	}
	
    "IconSettings"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconSettings"
		"xpos"					"c-255"		[$WIN32 && $ENGLISH]
		"xpos"					"c-275"		[$WIN32 && !$ENGLISH]
		"ypos"					"206"		[$WIN32]
		"wide"					"15"		[$WIN32]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-285"		[$X360]
		"ypos"					"210"		[$X360]
		"wide"					"20"		[$X360]
		"tall"					"20"		[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_settings"
		"scaleImage"			"1"
	}
	"BtnChangeGameSettings"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnChangeGameSettings"
		"command"				"ChangeGameSettings"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"206"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"210"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnVoiceButton"			[$WIN32]
		"navUp"					"BtnCancelDedicatedSearch"	[$X360]
		"navDown"				"DrpCharacter"
		"navRight"				"GplSurvivors"
		"tooltiptext"			"#L4D360UI_Lobby_Change_GameSettings_Tip"
		"disabled_tooltiptext"	"#L4D360UI_Lobby_Change_GameSettings_DisabledTip"
		"labelText"				"#L4D360UI_Lobby_Change_GameSettings"
		"style"					"DefaultButton"
	}
	
	"IconCharacter"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconCharacter"
		"xpos"					"c-255"		[$WIN32 && $ENGLISH]
		"xpos"					"c-275"		[$WIN32 && !$ENGLISH]
		"ypos"					"226"		[$WIN32]
		"wide"					"15"		[$WIN32]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-285"		[$X360]
		"ypos"					"235"		[$X360]
		"wide"					"20"		[$X360]
		"tall"					"20"		[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_character"
		"scaleImage"			"1"
	}
	"DrpCharacter"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpCharacter"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"226"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"235"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnChangeGameSettings"
		"navDown"				"DrpVersusCharacter"
		"navRight"				"GplSurvivors"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"			"L4D360HybridButton"
			"fieldName"				"BtnDropButton"
			"xpos"					"0"
			"ypos"					"0"
			"wide"					"180"	[$WIN32 && $ENGLISH]
			"wide"					"260"	[$WIN32 && !$ENGLISH]
			"tall"					"15"	[$WIN32]
			"wide"					"180"	[$X360]
			"tall"					"20"	[$X360]
			"autoResize"			"1"
			"pinCorner"				"0"
			"visible"				"1"
			"enabled"				"1"
			"tabPosition"			"0"
			"labelText"				"#L4D360UI_Lobby_Character"
			"tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Character"
			"disabled_tooltiptext"	"#L4D360UI_GameSettings_Tooltip_Character_Disabled"
			"style"					"DropDownButton"
			"command"				"FlmCharacterFlyout"
			"FocusButtonWidth"		"230"
			"OpenButtonWidth"		"230"
			"ActivationType"		"1" [$X360]
		}
	}			
	
	"FlmCharacterFlyout"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmCharacterFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnRandom"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownCoopCharacters.res"
	}
	
    "IconCharacterVersus"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconCharacterVersus"
		"xpos"					"c-255"		[$WIN32 && $ENGLISH]
		"xpos"					"c-275"		[$WIN32 && !$ENGLISH]
		"ypos"					"226"		[$WIN32]
		"wide"					"15"		[$WIN32]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-285"		[$X360]
		"ypos"					"235"		[$X360]
		"wide"					"20"		[$X360]
		"tall"					"20"		[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_character"
		"scaleImage"			"1"
	}
	"DrpVersusCharacter"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpVersusCharacter"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"226"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"235"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"DrpCharacter"
		"navDown"				"BtnInviteFriends"
		"navRight"				"GplSurvivors"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"			"L4D360HybridButton"
			"fieldName"				"BtnDropButton"
			"xpos"					"0"
			"ypos"					"0"
			"wide"					"180"	[$WIN32 && $ENGLISH]
			"wide"					"260"	[$WIN32 && !$ENGLISH]
			"tall"					"15"	[$WIN32]
			"wide"					"180"	[$X360]
			"tall"					"20"	[$X360]
			"autoResize"			"1"
			"pinCorner"				"0"
			"visible"				"1"
			"enabled"				"1"
			"tabPosition"			"0"
			"labelText"				"#L4D360UI_Lobby_Character"
			"tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Character"
			"disabled_tooltiptext"	"#L4D360UI_GameSettings_Tooltip_Character_Disabled"
			"style"					"DropDownButton"
			"command"				"FlmVersusCharacterFlyout"
			"FocusButtonWidth"		"230"
			"OpenButtonWidth"		"230"
			"ActivationType"		"1" [$X360]
		}
	}
	
	"FlmVersusCharacterFlyout"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmVersusCharacterFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnRandom"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownVersusCharacters.res"
	}
	
	"IconFriends"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconFriends"
		"xpos"					"c-255"		[$WIN32 && $ENGLISH]
		"xpos"					"c-275"		[$WIN32 && !$ENGLISH]
		"ypos"					"246"		[$WIN32]
		"wide"					"15"		[$WIN32]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-285"		[$X360]
		"ypos"					"260"		[$X360]
		"wide"					"20"		[$X360]
		"tall"					"20"		[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_friends"
		"scaleImage"			"1"
	}	
	"BtnInviteFriends"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnInviteFriends"
		"command"				"InviteUI_Steam"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"246"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"260"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"			[$WIN32]
		"visible"				"0"			[$X360]
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"DrpVersusCharacter"
		"navDown"				"DrpInviteFriends"
		"navRight"				"GplSurvivors"
		"tooltiptext"			"#L4D360UI_Lobby_InviteFriends_Tip"
		"disabled_tooltiptext"	"#L4D360UI_InGameMainMenu_InviteAFriend_Disabled"
		"labelText"				"#L4D360UI_Lobby_InviteFriends"
		"style"					"DefaultButton"
	}
	"DrpInviteFriends"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpInviteFriends"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"246"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"260"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"visible"				"0"			[$WIN32]
		"visible"				"1"			[$X360]
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnInviteFriends"
		"navDown"				"DrpGameAccess"
		"navRight"				"GplSurvivors"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"			"L4D360HybridButton"
			"fieldName"				"BtnDropButton"
			"xpos"					"0"
			"ypos"					"0"
			"wide"					"180"	[$WIN32 && $ENGLISH]
			"wide"					"260"	[$WIN32 && !$ENGLISH]
			"tall"					"15"	[$WIN32]
			"wide"					"180"	[$X360]
			"tall"					"20"	[$X360]
			"autoResize"			"1"
			"pinCorner"				"0"
			"visible"				"1"
			"enabled"				"1"
			"tabPosition"			"0"
			"tooltiptext"			"#L4D360UI_InviteUIOptions_Tip"
			"disabled_tooltiptext"	"#L4D360UI_InviteUIOptions_Tip_Disabled"
			"labelText"				"#L4D360UI_InviteUIOptions"
			"style"					"DropDownButton"
			"command"				"FlmInviteFriends"
			"FocusButtonWidth"		"230"
			"OpenButtonWidth"		"230"
			"ActivationType"		"1" [$X360]
		}
	}			
	"FlmInviteFriends"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmInviteFriends"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnPlayers"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownInviteLive.res"
	}
	
    "IconPermissions"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconPermissions"
		"xpos"					"c-255"		[$WIN32 && $ENGLISH]
		"xpos"					"c-275"		[$WIN32 && !$ENGLISH]
		"ypos"					"266"		[$WIN32]
		"wide"					"15"		[$WIN32]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-285"		[$X360]
		"ypos"					"285"		[$X360]
		"wide"					"20"		[$X360]
		"tall"					"20"		[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"		[$X360]
		"visible"				"0"		[$WIN32]
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_permissions"
		"scaleImage"			"1"
	}	
	"DrpGameAccess"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpGameAccess"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"266"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"285"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"visible"				"1"		[$X360]
		"visible"				"0"		[$WIN32]
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"DrpInviteFriends"
		"navDown"				"BtnStartGame" [$X360]
		"navDown"				"BtnLeaveLobby" [$WIN32]
		"navRight"				"GplSurvivors"
				
		//button and label
		"BtnDropButton"
		{
			"ControlName"			"L4D360HybridButton"
			"fieldName"				"BtnDropButton"
			"xpos"					"0"
			"ypos"					"0"
			"wide"					"180"	[$WIN32 && $ENGLISH]
			"wide"					"260"	[$WIN32 && !$ENGLISH]
			"tall"					"15"	[$WIN32]
			"wide"					"180"	[$X360]
			"tall"					"20"	[$X360]
			"autoResize"			"1"
			"pinCorner"				"0"
			"visible"				"1"
			"enabled"				"1"
			"tabPosition"			"0"
			"labelText"				"#L4D360UI_Lobby_Change_GameAccess"
			"tooltiptext"			"#L4D360UI_Lobby_Change_GameAccess_Tip"
			"disabled_tooltiptext"	"#L4D360UI_Lobby_Change_GameAccess_Disabled_Tip"
			"style"					"DropDownButton"
			"command"				"FlmGameAccess"
			"FocusButtonWidth"		"230"
			"OpenButtonWidth"		"230"
			"ActivationType"		"1" [$X360]
		}
	}			
	
	"FlmGameAccess"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmGameAccess"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"3"
		"InitialFocus"			"BtnPublic"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownGameAccessTeam.res"
	}

    "IconForwardArrow"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconForwardArrow"
		"xpos"					"c-255"		[$WIN32 && $ENGLISH]
		"xpos"					"c-275"		[$WIN32 && !$ENGLISH]
		"ypos"					"286"		[$WIN32]
		"wide"					"15"		[$WIN32]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-285"		[$X360]
		"ypos"					"310"		[$X360]
		"wide"					"20"		[$X360]
		"tall"					"20"		[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_right"
		"scaleImage"			"1"
	}	
	"BtnStartGame"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnStartGame"
		"command"				"StartGame"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"286"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"310"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"DrpGameAccess" [$X360]
		"navUp"					"BtnLeaveLobby" [$WIN32]
		"navDown"				"BtnCancelDedicatedSearch" [$X360]
		"navDown"				"BtnCancelDedicatedSearch" [$WIN32]
		"navLeft"				"BtnCancelDedicatedSearch"
		"navRight"				"GplSurvivors"
		"tooltiptext"			"#L4D360UI_Lobby_FindOpponentTeam_Tip"
		"disabled_tooltiptext"	"#L4D360UI_Lobby_FindOpponentTeam_Tip_Disabled"
		"labelText"				"#L4D360UI_Lobby_FindOpponentTeam"
		"style"					"DefaultButton"
		"fgcolor_override"		"255 12 12 255" [$WIN32]
	}
	
    "IconBackArrow" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconBackArrow"
		"xpos"					"c-255"		[$ENGLISH]
		"xpos"					"c-275"		[!$ENGLISH]
		"ypos"					"286"
		"wide"					"15"
		"tall"					"15"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_left"
		"scaleImage"			"1"
	}
	"BtnCancelDedicatedSearch"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCancelDedicatedSearch"
		"command"				"CancelDedicatedSearch"
		"xpos"					"c-240"		[$WIN32 && $ENGLISH]
		"xpos"					"c-260"		[$WIN32 && !$ENGLISH]
		"ypos"					"286"		[$WIN32]
		"wide"					"180"		[$WIN32 && $ENGLISH]
		"wide"					"260"		[$WIN32 && !$ENGLISH]
		"tall"					"15"		[$WIN32]
		"xpos"					"c-260"		[$X360]
		"ypos"					"310"		[$X360]
		"wide"					"180"		[$X360]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnStartGame"
		"navDown"				"ChatInputLine" [$WIN32]
		"navDown"				"BtnChangeGameSettings" [$X360]
		"navRight"				"GplSurvivors"
		"tooltiptext"			"#L4D360UI_Lobby_CancelMatchmacking_Tip"
		"labelText"				"#L4D360UI_Lobby_CancelMatchmacking"
		"style"					"DefaultButton"
	}
		
	"IconBackArrow2" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconBackArrow2"
		"xpos"					"c-255"		[$ENGLISH]
		"xpos"					"c-275"		[!$ENGLISH]
		"ypos"					"266"
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
	"BtnLeaveLobby" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnLeaveLobby"
		"command"				"LeaveLobby"
		"xpos"					"c-240" [$ENGLISH]
		"xpos"					"c-260" [!$ENGLISH]
		"ypos"					"266"
		"wide"					"180"	[$ENGLISH]
		"wide"					"260"	[!$ENGLISH]
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"DrpGameAccess"
		"navDown"				"BtnStartGame"
		"navRight"				"GplSurvivors"
		"tooltiptext"			"#L4D360UI_Lobby_LeaveLobby_Tip"
		"labelText"				"#L4D360UI_Lobby_LeaveLobby"
		"style"					"DefaultButton"
	}	

	"ChatBackground" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"Divider1"
		"xpos"				  	"c-240" [$ENGLISH]
		"xpos"					"c-260" [!$ENGLISH]
		"ypos"					"306"
		"zpos"					"1"
		"wide"	 				"261"	[$ENGLISH]  
		"wide"	 				"271"	[!$ENGLISH] 
		"tall"	 				"70"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"divider_gradient"
		"scaleImage"			"1"
	}
	
	"LobbyChatHistory" [$WIN32]
	{
		"ControlName"			"RichText"
		"fieldName"				"LobbyChatHistory"
		"xpos"		       		"c-240" [$ENGLISH]
		"xpos"					"c-260" [!$ENGLISH]
		"ypos"					"307"
		"zpos"					"2"
		"wide"	 				"260"	[$ENGLISH]  
		"wide"	 				"270"	[!$ENGLISH] 
		"tall"					"57"
		"wrap"					"1"
		"autoResize"			"1"
		"pinCorner"				"1"
		"visible"				"1"
		"enabled"				"1"
		"labelText"				""
		"textAlignment"			"south-west"
		"font"					"ChatFont"
		"maxchars"				"-1"
		"bgcolor_override"     	"0 0 0 255"
	}

	"ChatInputLine" [$WIN32]
	{
		"ControlName"			"EditablePanel"
		"fieldName" 			"ChatInputLine"
		"visible" 				"1"
		"enabled" 				"1"
		"xpos"		    		"c-240" [$ENGLISH]
		"xpos"					"c-260" [!$ENGLISH]
		"ypos"					"365"
		"zpos"					"2"
		"wide"	 				"260"	[$ENGLISH]  
		"wide"	 				"270"	[!$ENGLISH] 
		"tall"	 				"10"
		"PaintBackgroundType"	"0"
		"bgcolor_override"     	"0 0 0 200"
		"navUp"					"BtnCancelDedicatedSearch"
		"navDown"				"BtnVoiceButton"
	}
	
    "IconButtonVoice" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconButtonVoice"
		"xpos"			        "c-255" [$ENGLISH]
		"xpos"			        "c-275" [!$ENGLISH]
		"ypos"			        "381"
		"wide"					"15"
		"tall"					"15"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_voice"
		"scaleImage"			"1"
	}
	"BtnVoiceButton" [$WIN32]
	{
		"ControlName"		"L4D360HybridButton"
		"fieldName"			"BtnVoiceButton"
		"command"			"ToggleVoice"
		"xpos"				"c-240" [$ENGLISH]
		"xpos"				"c-260" [!$ENGLISH]
		"ypos"				"381"
		"wide"				"180"	[$ENGLISH]
		"wide"				"260"	[!$ENGLISH]
		"tall" 				"15"
		"autoResize"		"1"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
 		"tooltiptext"		"#L4D360UI_Lobby_StartVoiceChat_Tip"
		"disabled_tooltiptext"	"#L4D360UI_Lobby_StartVoiceChat_Disabled_Tip"	
		"labelText"			"#L4D360UI_Lobby_StartVoiceChat"
		"navUp"				"ChatInputLine"
		"navDown"			"BtnChangeGameSettings"
		"style"				"DefaultButton"
	}
}