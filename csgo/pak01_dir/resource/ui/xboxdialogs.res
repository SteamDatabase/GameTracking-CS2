//----------------------------------------------------------------------------------------
// Master control settings file for all Xbox 360 dialogs. File is loaded once and held by
// BasePanel, then used by the various dialogs as they're created. This prevents the
// expensive DVD access every time a new UI dialog is opened.
//----------------------------------------------------------------------------------------

"resource/XboxDialogs.res"
{

//--------------------------------------
// Settings Dialog
//--------------------------------------
"SettingsDialog.res"
{	
	"SettingsDialog"
	{
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"f0"
		"tall"				"480"
		"paintbackground"	"0"
	}

    "ControllerDialogPanel"
	{
		"ControlName"		"ScalableImagePanel"		
		"xpos"				"c-252"
		"ypos"				"c-186"
		"wide"				"504"
		"tall"				"372"
		"image"				"screens/panel-controls"
		"scaleImage"		"1"
	}

	"TitleLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"TitleLabel"
		"font"				"X360_Title_2"
		"xpos"				"c-241"	
		"ypos"				"c-180"
		"zpos"				"2"
		"wide"				"491"
		"tall"				"27"
		"textAlignment"		"center"
		"labelText"			"#GameUI_SettingsScreen_Title"
		"fgcolor_override"	"153 202 83 255"
	}

	"OptionsSelectionLeft"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsSelectionLeft"
		"xpos"				"c-242"
		"ypos"				"c-153"
		"zpos"				"75"
		"wide"				"484"
		"tall"				"25"
		"image"				"screens/panel-controls-select"
		"scaleImage"		"1"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsSelectionUp"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsSelectionUp"
		"xpos"				"c-242"
		"ypos"				"c-153"
		"zpos"				"75"
		"wide"				"484"
		"tall"				"25"
		"image"				"screens/panel-controls-select-up"
		"scaleImage"		"1"
		"visible"			"0"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsToggleBackground"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsToggleBackground"
		"xpos"				"c+17"
		"ypos"				"c-148"
		"zpos"				"3"
		"wide"				"210"
		"tall"				"16"
		"image"				"screens/panel-controls-insert"
		"scaleImage"		"1"
		"visible"			"0"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsToggleLeftArrow"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsToggleLeftArrow"
		"xpos"				"c+4"
		"xpos_hidef"		"c+3"
		"ypos"				"c-148"
		"zpos"				"3"
		"wide"				"16"
		"tall"				"16"
		"image"				"screens/btn-arrow-lt-sm_up"
		"scaleImage"		"1"
		"visible"			"0"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsToggleRightArrow"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsToggleRightArrow"
		"xpos"				"c+224"
		"ypos"				"c-148"
		"zpos"				"3"
		"wide"				"16"
		"tall"				"16"
		"image"				"screens/btn-arrow-rt-sm_up"
		"scaleImage"		"1"
		"visible"			"0"
	}

	"DownArrow"
	{
		"ControlName" 		"Label"
		"fieldName"			"DownArrow"
		"xpos" 				"c+202"
		"ypos"				"c+165"
		"ypos_hidef"		"c+162"
		"zpos"				"150"
		"wide"				"32"
		"tall"				"32"
		"labelText"			"#GameUI_Icons_DOWNCURSOR"
		"textAlignment"		"north-west"
		"font"				"GameUIButtons"
		"fgcolor_override"	"255 255 255 255"
	}
	
	"UpArrow"
	{
		"ControlName" 		"Label"
		"fieldName"			"UpArrow"
		"xpos" 				"c+220"
		"ypos"				"c+165"
		"ypos_hidef"		"c+162"
		"zpos"				"150"
		"wide"				"32"
		"tall"				"32"
		"labelText"			"#GameUI_Icons_UPCURSOR"
		"textAlignment"		"north-west"
		"font"				"GameUIButtons"
		"fgcolor_override"	"255 255 255 255"
	}

	"OptionLabel0"
	{
		"ControlName"		"Label"
		"fieldName"			"OptionLabel0"
		"xpos"				"c-234"
		"ypos"				"c-153"
		"zpos"				"100"
		"wide"				"222"
		"tall"				"27"
		"textAlignment"		"west"
		"labelText"			""
		"fgcolor_override"	"220 220 220 255"
	}	

	"ValueLabel0"
	{
		"ControlName"		"Label"
		"fieldName"			"ValueLabel0"
		"xpos"				"c+6"
		"ypos"				"c-153"
		"zpos"				"100"
		"wide"				"230"
		"tall"				"27"
		"textAlignment"		"center"
		"labelText"			""
		"fgcolor_override"	"220 220 220 255"
	}	

	"ValueBar0"
	{
		"ControlName"		"AnalogBar"
		"fieldName"			"ValueBar0"
		"xpos"				"c+6"
		"ypos"				"c-153"
		"zpos"				"100"
		"wide"				"230"
		"tall"				"27"
		"tabPosition"		"0"
		"progress"			"0.5"
	}	

	"SprayPaintBackgroundSelect"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"SprayPaintBackgroundSelect"
		"xpos"				"c-242"
		"ypos"				"c+36"
		"ypos_hidef"		"c+35"
		"zpos"				"1"
		"wide"				"484"
		"tall"				"142"
		"image"				"screens/panel-settings-insert-spray-panel-select"
		"scaleImage"		"1"
	}

	"SprayPaintBackgroundUp"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"SprayPaintBackgroundUp"
		"xpos"				"c-242"
		"ypos"				"c+36"
		"ypos_hidef"		"c+35"
		"zpos"				"1"
		"wide"				"484"
		"tall"				"142"
		"image"				"screens/panel-settings-insert-spray-panel-simple"
		"scaleImage"		"1"
	}

	"SprayPaintBackgroundInset"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"SprayPaintBackgroundInset"
		"xpos"				"c+17"
		"ypos"				"c+59"
		"ypos_hidef"		"c+58"
		"zpos"				"3"
		"wide"				"210"
		"tall"				"110"
		"image"				"screens/panel-settings-insert-spray"
		"scaleImage"		"1"
	}

	// Note: this image is only used for position and size.
	"SprayPaintImage"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"SprayPaintImage"
		"xpos"				"c+84"
		"ypos"				"c+79"
		"ypos_hidef"		"c+78"
		"zpos"				"4"
		"wide"				"75"
		"tall"				"75"
		"scaleImage"		"1"
		"fillcolor"			"100 100 100 255"
		"visible"			"0"
	}
}

//--------------------------------------
// Controller Dialog
//--------------------------------------
"ControllerDialog.res"
{	
	"ControllerDialog"
	{
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"f0"
		"tall"				"480"
		"paintbackground"	"0"
	}

    "ControllerDialogPanel"
	{
		"ControlName"		"ScalableImagePanel"		
		"xpos"				"c-252"
		"ypos"				"c-186"
		"wide"				"504"
		"tall"				"372"
		"image"				"screens/panel-controls"
		"scaleImage"		"1"
	}
	
	"TitleLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"TitleLabel"
		"font"				"X360_Title_2"
		"xpos"				"c-241"	
		"ypos"				"c-180"
		"zpos"				"2"
		"wide"				"491"
		"tall"				"27"
		"textAlignment"		"center"
		"labelText"			"#GameUI_GameMenu_Controller"
		"fgcolor_override"	"153 202 83 255"
	}

	"OptionsSelectionLeft"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsSelectionLeft"
		"xpos"				"c-242"
		"ypos"				"c-153"
		"zpos"				"75"
		"wide"				"484"
		"tall"				"25"
		"image"				"screens/panel-controls-select"
		"scaleImage"		"1"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsSelectionUp"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsSelectionUp"
		"xpos"				"c-242"
		"ypos"				"c-153"
		"zpos"				"75"
		"wide"				"484"
		"tall"				"25"
		"image"				"screens/panel-controls-select-up"
		"scaleImage"		"1"
		"visible"			"0"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsToggleBackground"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsToggleBackground"
		"xpos"				"c+17"
		"ypos"				"c-148"
		"zpos"				"3"
		"wide"				"210"
		"tall"				"16"
		"image"				"screens/panel-controls-insert"
		"scaleImage"		"1"
		"visible"			"0"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsToggleLeftArrow"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsToggleLeftArrow"
		"xpos"				"c+4"
		"xpos_hidef"		"c+3"
		"ypos"				"c-148"
		"zpos"				"3"
		"wide"				"16"
		"tall"				"16"
		"image"				"screens/btn-arrow-lt-sm_up"
		"scaleImage"		"1"
		"visible"			"0"
	}

	// Note: this image is only used for size, positioning, and texture.
	"OptionsToggleRightArrow"
	{
		"ControlName"		"ScalableImagePanel"
		"fieldName"			"OptionsToggleRightArrow"
		"xpos"				"c+224"
		"ypos"				"c-148"
		"zpos"				"3"
		"wide"				"16"
		"tall"				"16"
		"image"				"screens/btn-arrow-rt-sm_up"
		"scaleImage"		"1"
		"visible"			"0"
	}

	"DownArrow"
	{
		"ControlName" 		"Label"
		"fieldName"			"DownArrow"
		"xpos" 				"c+202"
		"ypos"				"c+165"
		"ypos_hidef"		"c+162"
		"zpos"				"150"
		"wide"				"32"
		"tall"				"32"
		"labelText"			"#GameUI_Icons_DOWNCURSOR"
		"textAlignment"		"north-west"
		"font"				"GameUIButtons"
		"fgcolor_override"	"255 255 255 255"
	}
	
	"UpArrow"
	{
		"ControlName" 		"Label"
		"fieldName"			"UpArrow"
		"xpos" 				"c+220"
		"ypos"				"c+165"
		"ypos_hidef"		"c+162"
		"zpos"				"150"
		"wide"				"32"
		"tall"				"32"
		"labelText"			"#GameUI_Icons_UPCURSOR"
		"textAlignment"		"north-west"
		"font"				"GameUIButtons"
		"fgcolor_override"	"255 255 255 255"
	}

	"OptionLabel0"
	{
		"ControlName"		"Label"
		"fieldName"			"OptionLabel0"
		"xpos"				"c-234"
		"ypos"				"c-153"
		"zpos"				"100"
		"wide"				"222"
		"tall"				"27"
		"textAlignment"		"west"
		"labelText"			""
		"fgcolor_override"	"220 220 220 255"
	}	

	"ValueLabel0"
	{
		"ControlName"		"Label"
		"fieldName"			"ValueLabel0"
		"xpos"				"c+6"
		"ypos"				"c-153"
		"zpos"				"100"
		"wide"				"230"
		"tall"				"27"
		"textAlignment"		"center"
		"labelText"			""
		"fgcolor_override"	"220 220 220 255"
	}	

	"ValueBar0"
	{
		"ControlName"		"AnalogBar"
		"fieldName"			"ValueBar0"
		"xpos"				"c+6"
		"ypos"				"c-153"
		"zpos"				"100"
		"wide"				"230"
		"tall"				"27"
		"tabPosition"		"0"
		"progress"			"0.5"
	}	
}

//------------------------------------
// Dialog Menu Item Base
//------------------------------------
"MenuItem.res"
{
	"bottommargin"			"3"
	"bottommargin_lodef"	"3"
	"rightmargin"			"10"

	"menuitemtext"
	{
		"ControlName"	"label"
		"xpos"			"8"
		"ypos"			"8"
		"ypos_lodef"	"3"
		"font"			"MatchmakingDialogMenuLarge"
	}
	
	"menuitemdesc"
	{
		// This label should only be created in code, so don't set "ControlName"
		"xpos"			"8"
		"ypos"			"25"
		"ypos_lodef"	"22"
		"font"			"MatchmakingDialogMenuSmall"
	}
}

//------------------------------------
// Message Dialog
//------------------------------------
"MessageDialog.res"
{	
	"MessageDialog"
	{
		"fieldName"			"MessageDialog"
		"wide"				"363"
		"tall"				"180"
		"titlecolor"		"255 255 255 255"
		"messagecolor"		"255 255 255 255"
		"buttontextcolor"	"255 255 255 255"
		"button_margin"		"15"
		"activity_indent"	"80"
	}
	
	"Background"
	{	
		"xpos"				"0"
		"ypos"				"0"
 		"wide"				"363"
 		"tall"				"145"
		"image"				"common/message_dialog"
		"scaleimage"		"1"
		"visible"			"1"
	}

 	"WarningBackground"
 	{	
 		"xpos"				"0"
 		"ypos"				"0"
 		"wide"				"363"
 		"tall"				"145"
 		"image"				"common/message_dialog_warning"
 		"scaleimage"		"1"
 		"visible"			"1"
 	}
 
 	"ErrorBackground"
 	{	
 		"xpos"				"0"
 		"ypos"				"0"
 		"wide"				"363"
 		"tall"				"145"
 		"image"				"common/message_dialog_error"
 		"scaleimage"		"1"
 		"visible"			"1"
 	}

	"TitleLabel"
	{	
		"ControlName"		"Label"
		"fieldName"			"TitleLabel"
		"font"				"X360_Title_1"
		"xpos"				"14"
		"ypos"				"10"
		"zpos"				"2"
		"wide"				"335"
		"tall"				"25"
		"textAlignment"		"Left"
	}

	"MessageLabelWithTitle"
	{	
		"ControlName"		"Label"
		"fieldName"			"MessageLabelWithTitle"
		"font"				"X360_Body_1"
		"xpos"				"14"	
		"ypos"				"40"
		"zpos"				"2"
		"wide"				"335"
		"tall"				"95"
		"wrap"				"1"
		"textAlignment"		"center"
		"textcolor"			"0 0 0 255"
		"visible"			"0"
	}

	"MessageLabelNoTitle"
	{	
		"ControlName"		"Label"
		"fieldName"			"MessageLabelNoTitle"
		"font"				"X360_Body_1"
		"xpos"				"14"	
		"ypos"				"10"
		"zpos"				"3"
		"wide"				"335"
		"tall"				"125"
		"wrap"				"1"
		"textAlignment"		"center"
		"textcolor"			"0 0 0 255"
		"visible"			"0"
	}

	"AnimatingPanel"
	{
		"ControlName"		"AnimatingImagePanel"
		"fieldName"			"AnimatingPanel"
		"xpos"				"7"
		"ypos"				"55"
		"zpos"				"9"
		"wide"				"64"
		"tall"				"64"
		"scaleImage"		"1"
		"image"				"load-gizmo"
		"frames"			"13"
		"anim_framerate"	"30"
	}
}

"LoadingDialogNoBanner.res"
{	
	"LoadingDialog"
	{
		"ControlName"		"Frame"
		"fieldName"			"LoadingDialog"
		"wide"				"f0"
		"tall"				"360"
		"visible"			"0"
	}

	"LoadingDialogBG"
	{
		"ControlName"		"Frame"
		"fieldName"			"LoadingDialogBG"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"0"
		"tall"				"0"
		"visible"			"0"
	}

	"InitialBackgroundImage"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"InitialBackgroundImage"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"1"
		"wide"				"640"
		"wide_hidef"		"f0"
		"tall"				"480"
		"scaleImage"		"1"
		"image"				"screens/loading_screen_generic_background"
		"image_hidef"		"screens/loading_screen_generic_background_wide"
		"visible"			"0"
	}

	"MissionPanel"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"MissionPanel"
		"xpos"				"c-225"
		"ypos"				"c-166"
		"zpos"				"2"
		"wide"				"450"
		"tall"				"332"
		"scaleImage"		"1"
		"image"				"screens/panel-load-wide"
		"labelText"			""
		"visible"			"0"
	}

    "MapName"
    {
		"ControlName"		"Label"
		"fieldName"			"MapName"
		"xpos"				"c-210"
		"ypos"				"c-154"
		"zpos"				"3"
		"wide"				"423"
		"tall"				"18"
		"font"				"X360_Title_2"
		"textAlignment"		"center"
		"fgcolor_override"	"153 202 83 255"
		"labelText"			""
		"visible"			"0"
    }

    "BodyLabel"
    {
		"ControlName"		"Label"
		"fieldName"			"BodyLabel"
		"xpos"				"c-55"
		"ypos"				"c-120"
		"zpos"				"3"
		"wide"				"414"
		"tall"				"241"
		"font"				"X360_Title_1"
		"textAlignment"		"center"
		"fgcolor_override"	"220 220 220 255"
		"wrap"				"1"
		"text"				""
		"labelText"			"#GameUI_Loading"
    }

	"ProgressBarBackground"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ProgressBarBackground"
		"xpos"					"c+47"
		"ypos"					"c+30"
		"zpos"					"3"
		"wide"					"161"
		"tall"					"22"
		"scaleImage"			"1"
		"image"					"screens/loading_dialog_progress_bar_bg"
		"visible"				"0"
	}

	"ProgressBar"
	{
		"ControlName"			"ScalableImagePanel"
		"fieldName"				"ProgressBar"
		"xpos"					"c+47"
		"ypos"					"c+30"				
		"zpos"					"4"
		"wide"					"0"   //This starts at 0 because it is an empty progress bar.
		"tall"					"22"
		"scaleImage"			"1"
		"image"					"screens/loading_dialog_progress_bar"

		"src_corner_height"		"0"
		"src_corner_width"		"14"
		"draw_corner_height"	"0"
		"draw_corner_width"		"10"
		"visible"				"0"
	}

	// [jason] This panel isn't rendered on console, but its size is used to calculate the size of the DrawBox calls!
	"Progress"
	{
		"ControlName"			"ScalableImagePanel"
		"fieldName"				"Progress"
		"xpos"					"c"
		"ypos"					"c"				
		"zpos"					"4"
		"wide"					"256"
		"tall"					"32"
		"scaleImage"			"1"
		"visible"				"0"
		"image"					"screens/loading_dialog_progress_bar"

		"src_corner_height"		"0"
		"src_corner_width"		"14"
		"draw_corner_height"	"0"
		"draw_corner_width"		"10"
	}

    "LoadingLabel"
    {
		"ControlName"			"Label"
		"fieldName"				"LoadingLabel"
		"xpos"					"c-111"
		"ypos"					"c+130"
		"zpos"					"3"
		"wide"					"150"
		"labelText"				""
		"tall"					"22"
		"font"					"X360_Title_3"
		"textAlignment"			"center"
		"fgcolor_override"		"220 220 220 255"
		"visible"				"0"
    }
}

"FadeDialog.res"
{
	"FadeDialog"
	{
		"ControlName"		"Frame"
		"fieldName"			"FadeDialog"
		"xpos"				"0"
		"ypos"				"0"
		"ypos_hidef"		"0"
		"zpos"				"0"
		"wide"				"640"
		"wide_hidef"		"1280"
		"tall"				"480"
		"tall_hidef"		"720"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"paintBackgroundType" "2"
		"bgColor" "0 0 0 255"
		"alpha" "0"
	}
}

//------------------------------------
// How To Play Dialog
//------------------------------------
"HowToPlayDialog.res"
{
	"HowToPlayDialog"
	{
		"ControlName"		"Frame"
		"fieldName"			"HowToPlayDialog"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"640"
		"wide_hidef"		"f0"
		"tall"				"480"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"paintbackground"	"0"
	}

    "HowToPlayPanel"
	{
		"ControlName"		"ScalableImagePanel"		
		"xpos"				"c-252"
		"ypos"				"72"
		"wide"				"504"
		"tall"				"336"
		"image"				"screens/panel-how-to-play"
		"scaleImage"		"1"
	}
	
	"Title"
	{
		"ControlName"		"Label"
		"xpos"				"c-252"
		"ypos"				"78"
		"wide"				"504"
		"tall"				"30"
		"textAlignment"		"center"
		"labelText"			"#HowToPlay"
		"fgcolor_override"	"160 207 101 255"
		"font"				"X360_Title_1"
	}
	
	"ScrollablePanelLocation"
	{
		"ControlName"			"Panel"
		"xpos"					"c-65"
		"ypos"					"114"
		"wide"					"301"
		"tall"					"278"		
	}
	
	"FirstButtonLocation"
	{
		"ControlName"			"Panel"
		"xpos"					"c-240"
		"ypos"					"110"
		"wide"					"174"
		"tall"					"20"
	}
	
	"UpArrow"
	{
		"ControlName"		"ImagePanel"		
		"image"				"screens/btn-arrow-vertical-up-sm_up"		
		"xpos"				"c+210"
		"ypos"				"112"
		"wide"				"23"
		"tall"				"23"		
		"zpos"				"10"	
		"scaleImage"		"1"	
	}
	
	"DownArrow"
	{
		"ControlName"		"ImagePanel"		
		"image"				"screens/btn-arrow-vertical-down-sm_up"
		"xpos"				"c+210"
		"ypos"				"370"
		"wide"				"23"		
		"tall"				"23"		
		"zpos"				"10"
		"scaleImage"		"1"
	}

	"button_pin_right"		"68"
}

"GameLogo.res"
{
	"GameLogo"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"GameLogo"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"50"
		"wide"			"256"
		"tall"			"128"
		"autoResize"	"1"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"offsetX"		"4"
		"offsetY"		"-4"
	}

	"Logo"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"Logo"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"50"
		"wide"			"256"
		"tall"			"128"
		"visible"		"1"
		"enabled"		"1"
		"image"			"logo/portal_logo"
		"scaleImage"	"1"		
	}
}

"ReadyUpDialog.res"
{
	"ReadyUpDialog"
	{
		"ControlName"		"Frame"
		"fieldName"			"ReadyUpDialog"
		"xpos"				"0"		
		"ypos"				"0"				
		"zpos"				"1"				
		"wide"				"f0"		
		"tall"				"480"	
		"RoundedCorners"	"0"
		"visible"			"0"			
	}
	
	"ReadyUpBar"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"ReadyUpBar"
		"xpos"			"0"
		"ypos"			"c+100"	
		"zpos"			"1"	
		"wide"			"f0"
		"tall"			"70"		
		"scaleImage"	"1"		
		"image"			"screens/ready_up_bar"		
	}
	
	"Logo"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"Logo"
		"xpos"			"c-200"
		"ypos"			"c-50"	
		"zpos"			"1"	
		"wide"			"400"
		"tall"			"80"		
		"scaleImage"	"1"		
		"image"			"screens/cs_title"		
	}
	
	"PressStartLabel"
	{
		"ControlName" 		"Label"
		"fieldName"			"PressStartLabel"
		"xpos" 				"0"
		"ypos"				"c+100"
		"zpos"				"2"
		"wide"				"f0"
		"tall"				"70"				
		"labelText"			"#PressStart"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"font"				"Default"
		"font_hidef"		"UIBold"
	}
}

"StartupMoviesDialog.res"
{
	"StartupMoviesDialog"
	{
		"ControlName"		"Frame"
		"fieldName"			"StartupMoviesDialog"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"1"
		"wide"				"f0"
		"tall"				"480"
		"visible"			"1"
	}

	"Background"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"Background"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"1"
		"wide"				"f0"
		"tall"				"480"
		"scaleImage"		"1"
		"fillcolor"			"0 0 0 255"
		"visible"			"1"
	}
}

"MainGameMenuScreen.res"
{
	"BaseGameUIPanel"
	{
		"ControlName"		"Panel"
		"FieldName"			"BaseGameUIPanel"
		"TransitionTime"	"2.0"
		"HoldTime"			"10.0"	
		"CrossfadeImage1"	"screens/menu_background_1"
		"CrossfadeImage2"	"screens/menu_background_2"
		"CrossfadeImage3"	"screens/menu_background_3"
		"CrossfadeImage4"	"screens/menu_background_4"
	}
	
	"Logo"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"Logo"
		"xpos"			"22"
		"xpos_hidef"	"30"
		"ypos"			"172"
		"ypos_hidef"	"110"
		"zpos"			"1"	
		"wide"			"400"
		"tall"			"80"		
		"scaleImage"	"1"		
		"image"			"screens/cs_title"		
		"alpha"			"0"					
	}

	"CodeVersionLabel"
	{
		"ControlName" 		"Label"
		"fieldName"			"CodeVersionLabel"
		"xpos" 				"820"
		"xpos_hidef" 		"1060"
		"ypos"				"57"
		"ypos_hidef"		"36"
		"zpos"				"100"
		"wide"				"120"
		"tall"				"12"
		"labelText"			""
		"textAlignment"		"north-east"
		"font"				"X360_Body_2"
		"fgcolor_override"	"100 100 100 255"
		"visible"			"0"
	}

	"ContentVersionLabel"
	{
		"ControlName" 		"Label"
		"fieldName"			"ContentVersionLabel"
		"xpos" 				"820"
		"xpos_hidef" 		"1060"
		"ypos"				"70"
		"ypos_hidef"		"50"
		"zpos"				"100"
		"wide"				"120"
		"tall"				"12"
		"labelText"			""
		"textAlignment"		"north-east"
		"font"				"X360_Body_2"
		"fgcolor_override"	"100 100 100 255"
		"visible"			"0"
	}

// [smessick] Enable to display the title safe area on the main menu
//	"TitleSafe"
//	{
//		"ControlName" 		"ImagePanel"
//		"fieldName"			"TitleSafe"
//		"xpos" 				"76"
//		"xpos_hidef" 		"94"
//		"ypos"				"57"
//		"ypos_hidef"		"36"
//		"zpos"				"100"
//		"wide"				"870"
//		"wide_hidef"		"1088"
//		"tall"				"652"
//		"tall_hidef"		"648"
//		"fillcolor"			"255 0 0 10"
//	}
}

//=============================================================================
// HPE_BEGIN
// mjohnson
//=============================================================================

//--------------------------------------
// Counter-Strike Source leaderboards dialog
//--------------------------------------
"CSLeaderboardsDialog.res"
{
	"CSLeaderboardsDialog"
	{
		"ControlName"					"CSLeaderboardsDialog"
		"xpos"							"0"
		"ypos"							"0"
		"wide"							"640"
		"wide_hidef"					"f0"
		"tall"							"480"
		"autoResize"					"0"
		"pinCorner"						"0"
		"tabPosition"					"0"
		"paintbackground"				"0"
	}
	
	"LeaderboardLabel"
	{
		"ControlName"					"Label"
		"xpos"							"c-216"
		"ypos"							"c-181"
		"zpos"							"50"
		"wide"							"432"
		"tall"							"32"
		"labelText"						"#GameUI_Leaderboards_Title"
		"textAlignment"					"center"
		"font"							"X360_Title_3"
		"fgcolor_override"				"163 205 105 255"
	}

	"LeaderboardTypeLabel"
	{
		"ControlName"					"Label"
		"xpos"							"c-216"
		"ypos"							"c-155"
		"zpos"							"50"
		"wide"							"432"
		"tall"							"32"
		"labelText"						""
		"textAlignment"					"center"
		"font"							"X360_Title_4"
		"fgcolor_override"				"163 205 105 255"
	}

	"LeaderboardModeTitleLabel"
	{
		"ControlName"					"Label"
		"xpos"							"c-226"
		"ypos"							"c-131"
		"zpos"							"50"
		"wide"							"212"
		"tall"							"32"
		"labelText"						"#GameUI_Leaderboards_Mode_Title"
		"textAlignment"					"center"
		"font"							"X360_Title_4"
		"fgcolor_override"				"191 191 191 255"
	}
	
	"LeaderboardModeLabel"
	{
		"ControlName"					"Label"
		"xpos"							"c-226"
		"ypos"							"c-115"
		"zpos"							"50"
		"wide"							"212"
		"tall"							"32"
		"labelText"						""
		"textAlignment"					"center"
		"font"							"X360_Title_4"
		"fgcolor_override"				"163 205 105 255"
	}

	"LeaderboardFilterTitleLabel"
	{
		"ControlName"					"Label"
		"xpos"							"c+12"
		"ypos"							"c-131"
		"zpos"							"50"
		"wide"							"212"
		"tall"							"32"
		"labelText"						"#GameUI_Leaderboards_Filter_Title"
		"textAlignment"					"center"
		"font"							"X360_Title_4"
		"fgcolor_override"				"191 191 191 255"
	}
	
	"LeaderboardFilterLabel"
	{
		"ControlName"					"Label"
		"xpos"							"c+12"
		"ypos"							"c-115"
		"zpos"							"50"
		"wide"							"212"
		"tall"							"32"
		"labelText"						""
		"textAlignment"					"center"
		"font"							"X360_Title_4"
		"fgcolor_override"				"163 205 105 255"
	}
	
	"XButton"
	{
		"ControlName"					"Label"
		"xpos"							"c-262"
		"ypos"							"c-115"
		"zpos"							"50"
		"wide"							"32"
		"tall"							"32"
		"labelText"						"#GameUI_Icons_X_BUTTON"
		"textAlignment"					"center"
		"font"							"GameUIButtons"
		"fgcolor_override"				"255 255 255 255"
	}

	"YButton"
	{
		"ControlName"					"Label"
		"xpos"							"c+230"
		"ypos"							"c-115"
		"zpos"							"50"
		"wide"							"32"
		"tall"							"32"
		"labelText"						"#GameUI_Icons_Y_BUTTON"
		"textAlignment"					"center"
		"font"							"GameUIButtons"
		"fgcolor_override"				"255 255 255 255"
	}
	
	"LeaderboardMessage"
	{
		"ControlName"					"Label"
		"xpos"							"c-230"
		"ypos"							"c+38"
		"zpos"							"50"
		"wide"							"460"
		"tall"							"32"
		"labelText"						""
		"textAlignment"					"north"
		"centerwrap"					"1"
		"font"							"X360_Body_2"
		"fgcolor_override"				"191 191 191 255"
	}
	
	"LeaderboardTotalEntries"
	{
		"ControlName"					"Label"
		"xpos"							"c-47"
		"ypos"							"c+145"
		"zpos"							"50"
		"wide"							"300"
		"tall"							"32"
		"labelText"						""
		"textAlignment"					"east"
		"font"							"X360_Title_5"
		"fgcolor_override"				"191 191 191 255"
	}
	
	"LeaderboardTypeLeftArrow"
	{
		"ControlName"					"ScalableImagePanel"
		"xpos"							"c-263"
		"ypos"							"c-150"
		"zpos"							"50"
		"wide"							"24"
		"tall"							"24"
		"image"							"screens/btn-arrow-lt-sm_up"
		"scaleImage"					"1"
	}
	
	"LeaderboardTypeRightArrow"
	{
		"ControlName"					"ScalableImagePanel"
		"xpos"							"c+238"
		"ypos"							"c-150"
		"zpos"							"50"
		"wide"							"24"
		"tall"							"24"
		"image"							"screens/btn-arrow-rt-sm_up"
		"scaleImage"					"1"
	}
	
	"LeaderboardListDownArrow"
	{
		"ControlName"					"ScalableImagePanel"
		"xpos"							"c-250"
		"ypos"							"c+149"
		"zpos"							"50"
		"wide"							"24"
		"tall"							"24"
		"image"							"screens/btn-arrow-vertical-down-sm_up"
		"scaleImage"					"1"
	}
	
	"LeaderboardListUpArrow"
	{
		"ControlName"					"ScalableImagePanel"
		"xpos"							"c-231"
		"ypos"							"c+149"
		"zpos"							"50"
		"wide"							"24"
		"tall"							"24"
		"image"							"screens/btn-arrow-vertical-up-sm_up"
		"scaleImage"					"1"
	}
	
	"LeaderboardSelectionPanel"
	{
		"ControlName"					"ScalableImagePanel"
		"xpos"							"c-256"
		"ypos"							"c-48"
		"zpos"							"50"
		"wide"							"513"
		"tall"							"24"
		"image"							"screens/leaderboard-select"
		"scaleImage"					"1"
	}
	
	// Defines the position of the leaderboard list headers and acts as a template for each column
	"LeaderboardListHeadersPosition"
	{
		"ControlName"					"Label"
		"xpos"							"c-250"
		"ypos"							"c-92"
		"wide"							"20"
		"tall"							"40"
		"labelText"						""
		"visible"						"0"
		"font"							"X360_Title_5"
		"fgcolor_override"				"191 191 191 255"
	}
	
	// Defines the positioning of the leaderboard list and acts as a template for each element
	"LeaderboardListPosition"
	{
		"ControlName"					"Label"
		"xpos"							"c-250"
		"ypos"							"c-44"
		"wide"							"30"
		"tall"							"20"
		"labelText"						""
		"visible"						"0"
		"font"							"X360_Body_3"
		"fgcolor_override"				"191 191 191 255"
	}

	"LeaderboardDialogPanel"
	{
		"ControlName"					"ScalableImagePanel"
		"xpos"							"c-272"
		"ypos"							"c-186"
		"wide"							"544"
		"tall"							"372"
		"image"							"screens/panel-leaderboard"
		"scaleImage"					"1"
	}
	
	"button_pin_right"					"48"
	
	"LeaderboardFilters"
	{
		"Overall"
		{
			"labelText"					"#GameUI_Leaderboards_Filter_Overall"
		}
			
		"Me"
		{
			"labelText"					"#GameUI_Leaderboards_Filter_Me"
		}
		
		"Friends"
		{
			"labelText"					"#GameUI_Leaderboards_Filter_Friends"
		}
	}

	"Leaderboards"
	{
		"KillDeathRatio"
		{
			"labelText"						"#GameUI_Leaderboards_KillDeathRatio"
			
			// The keys come from css_xbla.spa.h, the keys are not used and are just for reference.
			// The values are used in the "equation" key for the "Column" section to define how the
			// data in the backend leaderboard storage maps to data the user sees.
			"ColumnIds"
			{
				"deaths"					"1"
				"kills"						"2"
				"shots"						"3"
				"hits"						"4"
				"headshots"					"5"
			}

			"Modes"
			{
				"OnlineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCasual"
					"id"					"2" // This value comes from css_xbla.spa.h
				}
				
				"OnlineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCompetitive"
					"id"					"3" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePrivate"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePrivate"
					"id"					"16" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePro"
					"id"					"4" // This value comes from css_xbla.spa.h
				}
				"OfflineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCasual"
					"id"					"22"
				}
				"OfflineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCompetitive"
					"id"					"23"
				}
				"OfflinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflinePro"
					"id"					"24"
				}					
			}
			
			"Columns"
			{
				"Rank"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Rank"
					"wideHeader"            "80"
					"wide"					"80"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"rank"
				}
				
				"Gamertag"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Gamertag"
					"wideHeader"            "230"
					"wide"					"230"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"gamertag"
				}
				
				"KillsDeaths"
				{
					"labelText"				"#GameUI_Leaderboards_Column_KillsDeaths"
					"wideHeader"            "120"
					"wide"					"107"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"(id1 > 0) ? (id2 / id1) : (id2)"
					"format"				"%.2f"
				}
				
				"HeadShots"
				{
					"labelText"				"#GameUI_Leaderboards_Column_HeadShots"
					"wideHeader"            "110"
					"wide"					"107"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"(id5 / id4) * 100"
					"format"				"%2.1f%%"
				}
				
				"Hits"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Hits"
					"wideHeader"            "85"
					"wide"					"107"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"(id4 / id3) * 100"
					"format"				"%2.1f%%"
				}
				
				"Kills"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Kills"
					"wideHeader"            "120"
					"wide"					"107"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id2"
					"format"				"abbreviated"
				}
			}
		}
		
		"Wins"
		{
			"labelText"						"#GameUI_Leaderboards_Wins"

			// The keys come from css_xbla.spa.h, the keys are not used and are just for reference.
			// The values are used in the "equation" key for the "Column" section to define how the
			// data in the backend leaderboard storage maps to data the user sees.
			"ColumnIds"
			{
				"WinAsCT"					"1"
				"WinAsT"					"2"
				"LossAsCT"					"3"
				"LossAsT"					"4"
			}

			"Modes"
			{
				"OnlineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCasual"
					"id"					"5" // This value comes from css_xbla.spa.h
				}
				
				"OnlineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCompetitive"
					"id"					"6" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePrivate"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePrivate"
					"id"					"18" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePro"
					"id"					"7" // This value comes from css_xbla.spa.h
				}
				"OfflineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCasual"
					"id"					"28"
				}
				"OfflineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCompetitive"
					"id"					"29"
				}
				"OfflinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflinePro"
					"id"					"30"
				}					
			}
			
			"Columns"
			{
				"Rank"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Rank"
					"wideHeader"            "80"
					"wide"					"80"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"rank"
				}
				
				"Gamertag"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Gamertag"
					"wideHeader"            "230"
					"wide"					"230"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"gamertag"
				}
				
				"WinPercent"
				{
					"labelText"				"#GameUI_Leaderboards_Column_WinPercent"
					"wideHeader"            "88"
					"wide"					"78"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"((id1 + id2) / (id1 + id2 + id3 + id4)) * 100"
					"format"				"%2.1f%%"
				}
				
				"Wins"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Wins"
					"wideHeader"            "88"
					"wide"					"85"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id1 + id2"
					"format"				"abbreviated"
				}
				
				"Losses"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Losses"
					"wideHeader"            "95"
					"wide"					"85"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id3 + id4"
					"format"				"abbreviated"
				}
				
				"WinPercentAsCT"
				{
					"labelText"				"#GameUI_Leaderboards_Column_WinPercentAsCT"
					"wideHeader"            "98"
					"wide"					"98"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"(id1 / (id1 + id3)) * 100"
					"format"				"%2.1f%%"
				}
				
				"WinPercentAsT"
				{
					"labelText"				"#GameUI_Leaderboards_Column_WinPercentAsT"
					"wideHeader"            "98"
					"wide"					"98"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"(id2 / (id2 + id4)) * 100"
					"format"				"%2.1f%%"
				}
			}
		}
		
		"Stars"
		{
			"labelText"						"#GameUI_Leaderboards_Stars"

			// The keys come from css_xbla.spa.h, the keys are not used and are just for reference.
			// The values are used in the "equation" key for the "Column" section to define how the
			// data in the backend leaderboard storage maps to data the user sees.
			"ColumnIds"
			{
				"BombsPlanted"				"1"
				"BombsDetonated"			"2"
				"BombsDefused"				"3"
				"HostagesRescued"			"4"
			}

			"Modes"
			{
				"OnlineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCasual"
					"id"					"8" // This value comes from css_xbla.spa.h
				}
				
				"OnlineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCompetitive"
					"id"					"10" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePrivate"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePrivate"
					"id"					"17" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePro"
					"id"					"9" // This value comes from css_xbla.spa.h
				}
				"OfflineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCasual"
					"id"					"25"
				}
				"OfflineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCompetitive"
					"id"					"26"
				}
				"OfflinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflinePro"
					"id"					"27"
				}					
			}

			"Columns"
			{
				"Rank"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Rank"
					"wideHeader"            "80"
					"wide"					"80"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"rank"
				}
				
				"Gamertag"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Gamertag"
					"wideHeader"            "176"
					"wide"					"176"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"gamertag"
				}
				
				"Stars"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Stars"
					"wideHeader"            "85"
					"wide"					"70"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"format"				"rating"
				}
				
				"BombsPlanted"
				{
					"labelText"				"#GameUI_Leaderboards_Column_BombsPlanted"
					"wideHeader"            "125"
					"wide"					"96"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id1"
					"format"				"abbreviated"
				}
				
				"BombsDetonated"
				{
					"labelText"				"#GameUI_Leaderboards_Column_BombsDetonated"
					"wideHeader"            "110"
					"wide"					"110"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id2"
					"format"				"abbreviated"
				}
				
				"BombsDefused"
				{
					"labelText"				"#GameUI_Leaderboards_Column_BombsDefused"
					"wideHeader"            "105"
					"wide"					"105"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id3"
					"format"				"abbreviated"
				}
				
				"HostagesRescued"
				{
					"labelText"				"#GameUI_Leaderboards_Column_HostagesRescued"
					"wideHeader"            "95"
					"wide"					"95"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id4"
					"format"				"abbreviated"
				}
			}
		}
		
		"Medals"
		{
			"labelText"						"#GameUI_Leaderboards_Medals"

			"Modes"
			{
				"Overall"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_All"
					"id"					"11" // This value comes from css_xbla.spa.h
				}
			}

			"Columns"
			{
				"Rank"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Rank"
					"wideHeader"            "80"
					"wide"					"80"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"rank"
				}
				
				"Gamertag"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Gamertag"
					"wideHeader"            "440"
					"wide"					"440"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"gamertag"
				}
				
				"Medals"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Medals"
					"wideHeader"            "235"
					"wide"					"220"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"format"				"rating"
				}
			}
		}
		
		"GamesPlayed"
		{
			"labelText"						"#GameUI_Leaderboards_GamesPlayed"

			// The keys come from css_xbla.spa.h, the keys are not used and are just for reference.
			// The values are used in the "equation" key for the "Column" section to define how the
			// data in the backend leaderboard storage maps to data the user sees.
			"ColumnIds"
			{
				"GamesPlayedCT"				"1"
				"GamesPlayedT"				"2"
				"MoneyEarned"				"3"
				"TimePlayed"				"4"
			}

			"Modes"
			{
				"OnlineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCasual"
					"id"					"12" // This value comes from css_xbla.spa.h
				}
				
				"OnlineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlineCompetitive"
					"id"					"13" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePrivate"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePrivate"
					"id"					"15" // This value comes from css_xbla.spa.h
				}
				
				"OnlinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OnlinePro"
					"id"					"14" // This value comes from css_xbla.spa.h
				}
				"OfflineCasual"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCasual"
					"id"					"19"
				}
				"OfflineCompetitive"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflineCompetitive"
					"id"					"20"
				}
				"OfflinePro"
				{
					"labelText"				"#GameUI_Leaderboards_Mode_OfflinePro"
					"id"					"21"
				}					
			}

			"Columns"
			{
				"Rank"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Rank"
					"wideHeader"            "80"
					"wide"					"80"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"rank"
				}
				
				"Gamertag"
				{
					"labelText"				"#GameUI_Leaderboards_Column_Gamertag"
					"wideHeader"            "188"
					"wide"					"188"
					"textAlignment"			"west"
					"textAlignmentHeader"	"south-west"
					"format"				"gamertag"
				}
				
				"GamesPlayed"
				{
					"labelText"				"#GameUI_Leaderboards_Column_GamesPlayed"
					"wideHeader"            "95"
					"wide"					"70"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"format"				"rating"
				}
				
				"TimePlayed"
				{
					"labelText"				"#GameUI_Leaderboards_Column_TimePlayed"
					"wideHeader"            "75"
					"wide"					"110"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id4"
					"format"				"time"
				}
				
				"PlayedPercentAsCT"
				{
					"labelText"				"#GameUI_Leaderboards_Column_PlayedPercentAsCT"
					"wideHeader"            "130"
					"wide"					"100"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"(id1 / (id1 + id2)) * 100"
					"format"				"%2.1f%%"
				}
				
				"PlayedPercentAsT"
				{
					"labelText"				"#GameUI_Leaderboards_Column_PlayedPercentAsT"
					"wideHeader"            "90"
					"wide"					"100"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"(id2 / (id1 + id2)) * 100"
					"format"				"%2.1f%%"
				}
				
				"MoneyEarned"
				{
					"labelText"				"#GameUI_Leaderboards_Column_MoneyEarned"
					"wideHeader"            "90"
					"wide"					"100"
					"textAlignment"			"east"
					"textAlignmentHeader"	"south-east"
					"equation"				"id3"
					"format"				"abbreviated_money"
				}
			}
		}
	}
}

//--------------------------------------
// Create Singleplayer Game Dialog
//--------------------------------------
"CreateSingleplayerGameDialog.res"
{
	"CreateSingleplayerGameDialog"
	{
		"ControlName"		"Frame"
		"fieldName"			"CreateSingleplayerGameDialog"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"640"
		"wide_hidef"		"f0"
		"tall"				"480"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"paintbackground"	"0"
	}

    "Background"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "Background"
		"xpos"				"c-252"
		"ypos"				"c-175"
		"zpos"				"0"
		"wide"              "504"
		"tall"              "350"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/panel-mp-wide"
		"scaleImage"        "1"		
    }

    "BackgroundBotDifficultyArea"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "BackgroundBotDifficultyArea"
		"xpos"				"c-242"
		"ypos"				"c+139"
		"zpos"				"0"
		"wide"              "279"
		"tall"              "25"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/panel-mp-select-area"
		"scaleImage"        "1"		
    }

	"TitleLabel"
	{
		"ControlName"		"Label"
		"fieldname"			"TitleLabel"
		"font"				"X360_Title_2"
		"xpos"				"c-232"
		"ypos"				"c-170"
		"xpos_hidef"		"c-362"
		"zpos"				"2"
		"wide"				"470"
		"wide_hidef"		"720"
		"tall"				"35"
		"visible"			"1"
		"enabled"			"1"
		"textalignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"labelText"			""
		"fgcolor_override"  "161 205 104 255"
	}

    "MapImage"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "MapImage"
		"xpos"				"c-245"
		"ypos"				"c-113"
		"zpos"				"-5"
		"wide"              "452"
		"tall"              "221"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/map-image-placeholder"
		"scaleImage"        "1"		
    }

	"MapListValue"
	{
		"ControlName"		"Label"
		"fieldName"			"MapListValue"
		"xpos"				"c-254"
		"ypos"				"c-139"
		"xpos_hidef"        "c-254"
		"ypos_hidef"        "c-139"
		"zpos"				"100"
		"wide"				"300"
		"tall"				"24"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			""
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"wrap"				"0"
		"font"				"X360_Title_2"
		"Default"			"1"
		"tabPosition"		"1"
		"fgcolor_override"  "161 205 104 255"
	}

    "MapHighlight"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "MapHighlight"
		"xpos"				"c-246"
		"ypos"				"c-143"
		"zpos"				"5"
		"wide"              "288"
		"tall"              "32"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/mp-sel-mode"
		"scaleImage"        "1"		
    }

    "LeftArrowMap"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "LeftArrowMap"
		"xpos"				"c-246"
		"ypos"				"c-139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-lt-sm_up"
		"scaleImage"        "1"		
    }

    "RightArrowMap"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "RightArrowMap"
		"xpos"				"c+16"
		"ypos"				"c-139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-rt-sm_up"
		"scaleImage"        "1"		
    }

	"ModeListValue"
	{
		"ControlName"		"Label"
		"fieldName"			"ModeListValue"
		"xpos"				"c-254"
		"ypos"				"c+112"
		"xpos_hidef"        "c-254"
		"ypos_hidef"        "c+112"
		"zpos"				"100"
		"wide"				"300"
		"tall"				"24"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			""
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"tabPosition"		"2"
		"font"				"X360_Title_2"
		"fgcolor_override"  "161 205 104 255"
	}

    "ModeHighlight"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "ModeHighlight"
		"xpos"				"c-246"
		"ypos"				"c+108"
		"zpos"				"5"
		"wide"              "288"
		"tall"              "32"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/mp-sel-mode"
		"scaleImage"        "1"		
    }

    "LeftArrowMode"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "LeftArrowMode"
		"xpos"				"c-246"
		"ypos"				"c+112"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-lt-sm_up"
		"scaleImage"        "1"		
    }

    "RightArrowMode"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "RightArrowMode"
		"xpos"				"c+16"
		"ypos"				"c+112"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-rt-sm_up"
		"scaleImage"        "1"		
    }

    "BotDifficultyValue"
	{
		"ControlName"		"Label"
		"fieldName"			"BotDifficultyValue"
		"xpos"				"c-254"
		"ypos"				"c+140"
		"xpos_hidef"        "c-254"
		"ypos_hidef"        "c+140"
		"zpos"				"100"
		"wide"				"300"
		"tall"				"24"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"3"
		"labelText"			"#Cstrike_Bot_Difficulty3"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"font"				"X360_Title_2"
		"fgcolor_override"  "161 205 104 255"
	}

    "BotDifficultyHighlight"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "BotDifficultyHighlight"
		"xpos"				"c-246"
		"ypos"				"c+135"
		"zpos"				"5"
		"wide"              "288"
		"tall"              "33"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/mp-sel-mode"
		"scaleImage"        "1"		
    }

    "LeftArrowBots"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "LeftArrowBots"
		"xpos"				"c-246"
		"ypos"				"c+139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-lt-sm_up"
		"scaleImage"        "1"		
    }

    "RightArrowBots"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "RightArrowBots"
		"xpos"				"c+16"
		"ypos"				"c+139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-rt-sm_up"
		"scaleImage"        "1"		
    }

	"SkillLevel5"
	{
		"ControlName"		"Label"
		"fieldName"			"SkillLevel5"
		"xpos"				"c-266"
		"ypos"				"c-90"
		"zpos"				"100"
		"wide"				"245"
		"tall"				"24"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"0"
		"labelText"			"#Cstrike_Bot_Difficulty5"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
	}

	"SkillLevel4"
	{
		"ControlName"		"Label"
		"fieldName"			"SkillLevel4"
		"xpos"				"c-266"
		"ypos"				"c-90"
		"zpos"				"100"
		"wide"				"245"
		"tall"				"24"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"0"
		"labelText"			"#Cstrike_Bot_Difficulty4"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
	}

	"SkillLevel3"
	{
		"ControlName"		"Label"
		"fieldName"			"SkillLevel3"
		"xpos"				"c-266"
		"ypos"				"c-90"
		"zpos"				"100"
		"wide"				"245"
		"tall"				"24"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"0"
		"labelText"			"#Cstrike_Bot_Difficulty3"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
	}

	"SkillLevel2"
	{
		"ControlName"		"Label"
		"fieldName"			"SkillLevel2"
		"xpos"				"c-266"
		"ypos"				"c-90"
		"zpos"				"100"
		"wide"				"245"
		"tall"				"24"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"0"
		"labelText"			"#Cstrike_Bot_Difficulty2"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
	}

	"SkillLevel1"
	{
		"ControlName"		"Label"
		"fieldName"			"SkillLevel1"
		"xpos"				"c-266"
		"ypos"				"c-90"
		"zpos"				"100"
		"wide"				"245"
		"tall"				"24"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"0"
		"labelText"			"#Cstrike_Bot_Difficulty1"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
	}

	"SkillLevel0"
	{
		"ControlName"		"Label"
		"fieldName"			"SkillLevel0"
		"xpos"				"c-266"
		"ypos"				"c-90"
		"zpos"				"100"
		"wide"				"245"
		"tall"				"24"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"0"
		"labelText"			"#Cstrike_Bot_Difficulty0"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
	}

	"BombIcon"
	{
		"ControlName"		"Label"
		"fieldName"			"BombIcon"
		"xpos"				"c-66"
		"ypos"				"c-105"
		"zpos"				"100"
		"wide"				"80"
		"tall"				"30"
		"tall_hidef"		"35"
		"visible"			"1"
		"enabled"			"1"
		"font"              "IconsBig"
		"labelText"			"j"
		"textAlignment"		"east"
		"fgcolor_override"  "255 255 255 255"
	}

	"HostageIcon"
	{
		"ControlName"		"Label"
		"fieldName"			"HostageIcon"
		"xpos"				"c-62"
		"ypos"				"c-105"
		"zpos"				"100"
		"wide"				"80"
		"tall"				"30"
		"tall_hidef"		"35"
		"visible"			"0"
		"enabled"			"1"
		"font"              "IconsBig"
		"labelText"			"g"
		"textAlignment"		"east"
		"fgcolor_override"  "255 255 255 255"
	}

	"MapInfoLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"MapInfoLabel"
		"xpos"				"c+53"
		"ypos"				"c-132"
		"zpos"				"100"
		"wide"				"181"
		"tall"				"70"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			""
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
		"wrap"				"1"
		"LineHeightScale"	".8"
	}

	"ScenarioLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ScenarioLabel"
		"xpos"				"c+53"
		"ypos"				"c-68"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Scenario"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"ScenarioValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ScenarioValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-68"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_ScenarioBomb"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	//"FriendlyFireLabel"
	//{
	//	"ControlName"		"Label"
	//	"fieldName"			"FriendlyFireLabel"
	//	"xpos"				"c+53"
	//	"ypos"				"c-40"
	//	"zpos"				"100"
	//	"wide"				"220"
	//	"tall"				"20"
	//	"tall_hidef"		"35"
	//	"autoResize"		"0"
	//	"pinCorner"			"0"
	//	"visible"			"1"
	//	"enabled"			"1"
	//	"font"              "X360_Body_3"
	//	"labelText"			"#Cstrike_Game_FriendlyFire"
	//	"textAlignment"		"north-west"
	//	"dulltext"			"0"
	//	"brighttext"		"0"
	//	"fgcolor_override"  "189 192 185 255"
	//}

	//"FriendlyFireValueLabel"
	//{
	//	"ControlName"		"Label"
	//	"fieldName"			"FriendlyFireValueLabel"
	//	"xpos"				"c+34"
	//	"ypos"				"c-40"
	//	"zpos"				"100"
	//	"wide"				"200"
	//	"tall"				"20"
	//	"tall_hidef"		"35"
	//	"autoResize"		"0"
	//	"pinCorner"			"0"
	//	"visible"			"1"
	//	"enabled"			"1"
	//	"font"              "X360_Body_3"
	//	"labelText"			"Off"
	//	"textAlignment"		"north-east"
	//	"dulltext"			"0"
	//	"brighttext"		"0"
	//	"fgcolor_override"  "189 192 185 255"
	//}

	"CashLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"CashLabel"
		"xpos"				"c+53"
		"ypos"				"c-40"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Cash"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"CashValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"CashValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-40"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"$XX,XXX"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"GameTimeLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"GameTimeLabel"
		"xpos"				"c+53"
		"ypos"				"c-25"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_GameTime"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"WinMatchLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"WinMatchLabel"
		"xpos"				"c+53"
		"ypos"				"c-25"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_WinMatch"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"WinMatchValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"WinMatchValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-25"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"XX minutes"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"SpectateLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"SpectateLabel"
		"xpos"				"c+53"
		"ypos"				"c-10"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Spectate"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"SpectateValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"SpectateValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-10"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"Anyone"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"BotsLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"BotsLabel"
		"xpos"				"c+53"
		"ypos"				"c+5"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Bots"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"BotsValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"BotsValueLabel"
		"xpos"				"c+34"
		"ypos"				"c+5"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"Medium"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"AutoBuyLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"AutoBuyLabel"
		"xpos"				"c+53"
		"ypos"				"c+20"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_AutoBuy"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"AutoBuyValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"AutoBuyValueLabel"
		"xpos"				"c+34"
		"ypos"				"c+20"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"1"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"X"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}
	
	"ProgressLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ProgressLabel"
		"xpos"				"c+53"
		"ypos"				"c+125"
		"zpos"				"100"
		"wide"				"181"
		"tall"				"60"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Progress"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
		"wrap"				"1"
		"LineHeightScale"	".8"
	}

	"button_pin_right"		"68"
}

//--------------------------------------
// Create Multiplayer Match Dialog
//--------------------------------------
"CreateCustomMultiplayerMatchDialog.res"
{
	"CreateCustomMultiplayerMatchDialog"
	{
		"ControlName"		"Frame"
		"fieldName"			"CreateCustomMultiplayerMatchDialog"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"640"
		"wide_hidef"		"f0"
		"tall"				"480"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"paintbackground"	"0"
	}

    "Background"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "Background"
		"xpos"				"c-252"
		"ypos"				"c-175"
		"zpos"				"0"
		"wide"              "504"
		"tall"              "350"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/panel-mp-wide"
		"scaleImage"        "1"		
    }

    "PublicPrivateGameArea"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "PublicPrivateGameArea"
		"xpos"				"c-242"
		"ypos"				"c+139"
		"zpos"				"0"
		"wide"              "279"
		"tall"              "25"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/panel-mp-select-area"
		"scaleImage"        "1"		
    }

	"TitleLabel"
	{
		"ControlName"		"Label"
		"fieldname"			"TitleLabel"
		"font"				"X360_Title_2"
		"xpos"				"c-232"
		"ypos"				"c-170"
		"xpos_hidef"		"c-362"
		"zpos"				"2"
		"wide"				"470"
		"wide_hidef"		"720"
		"tall"				"35"
		"visible"			"1"
		"enabled"			"1"
		"textalignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"labelText"			""
		"fgcolor_override"  "161 205 104 255"
	}

    "MapImage"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "MapImage"
		"xpos"				"c-245"
		"ypos"				"c-113"
		"zpos"				"-5"
		"wide"              "452"
		"tall"              "221"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/map-image-placeholder"
		"scaleImage"        "1"		
    }

	"MapListValue"
	{
		"ControlName"		"Label"
		"fieldName"			"MapListValue"
		"xpos"				"c-254"
		"ypos"				"c-139"
		"xpos_hidef"        "c-254"
		"ypos_hidef"        "c-139"
		"zpos"				"100"
		"wide"				"300"
		"tall"				"24"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			""
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"wrap"				"0"
		"font"				"X360_Title_2"
		"Default"			"1"
		"tabPosition"		"1"
		"fgcolor_override"  "161 205 104 255"
	}

    "MapHighlight"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "MapHighlight"
		"xpos"				"c-246"
		"ypos"				"c-143"
		"zpos"				"5"
		"wide"              "288"
		"tall"              "32"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/mp-sel-mode"
		"scaleImage"        "1"		
    }

    "LeftArrowMap"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "LeftArrowMap"
		"xpos"				"c-246"
		"ypos"				"c-139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-lt-sm_up"
		"scaleImage"        "1"		
    }

    "RightArrowMap"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "RightArrowMap"
		"xpos"				"c+16"
		"ypos"				"c-139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-rt-sm_up"
		"scaleImage"        "1"		
    }

	"ModeListValue"
	{
		"ControlName"		"Label"
		"fieldName"			"ModeListValue"
		"xpos"				"c-254"
		"ypos"				"c+112"
		"xpos_hidef"        "c-254"
		"ypos_hidef"        "c+112"
		"zpos"				"100"
		"wide"				"300"
		"tall"				"24"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			""
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"tabPosition"		"2"
		"font"				"X360_Title_2"
		"fgcolor_override"  "161 205 104 255"
	}

    "ModeHighlight"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "ModeHighlight"
		"xpos"				"c-246"
		"ypos"				"c+108"
		"zpos"				"5"
		"wide"              "288"
		"tall"              "32"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/mp-sel-mode"
		"scaleImage"        "1"		
    }

    "LeftArrowMode"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "LeftArrowMode"
		"xpos"				"c-246"
		"ypos"				"c+112"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-lt-sm_up"
		"scaleImage"        "1"		
    }

    "RightArrowMode"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "RightArrowMode"
		"xpos"				"c+16"
		"ypos"				"c+112"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-rt-sm_up"
		"scaleImage"        "1"		
    }

    "PublicPrivateGameValue"
	{
		"ControlName"		"Label"
		"fieldName"			"PublicPrivateGameValue"
		"xpos"				"c-254"
		"ypos"				"c+140"
		"xpos_hidef"        "c-254"
		"ypos_hidef"        "c+140"
		"zpos"				"100"
		"wide"				"300"
		"tall"				"24"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"3"
		"labelText"			"#Cstrike_Public_Game"
		"textAlignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"font"				"X360_Title_2"
		"fgcolor_override"  "161 205 104 255"
	}

    "PublicPrivateGameHighlight"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "PublicPrivateGameHighlight"
		"xpos"				"c-246"
		"ypos"				"c+135"
		"zpos"				"5"
		"wide"              "288"
		"tall"              "33"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/mp-sel-mode"
		"scaleImage"        "1"		
    }

    "LeftArrowBots"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "LeftArrowBots"
		"xpos"				"c-246"
		"ypos"				"c+139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-lt-sm_up"
		"scaleImage"        "1"		
    }

    "RightArrowBots"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "RightArrowBots"
		"xpos"				"c+16"
		"ypos"				"c+139"
		"zpos"				"5"
		"wide"              "24"
		"tall"              "24"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/btn-arrow-rt-sm_up"
		"scaleImage"        "1"		
    }

	"BombIcon"
	{
		"ControlName"		"Label"
		"fieldName"			"BombIcon"
		"xpos"				"c-66"
		"ypos"				"c-105"
		"zpos"				"100"
		"wide"				"80"
		"tall"				"30"
		"tall_hidef"		"35"
		"visible"			"1"
		"enabled"			"1"
		"font"              "IconsBig"
		"labelText"			"j"
		"textAlignment"		"east"
		"fgcolor_override"  "255 255 255 255"
	}

	"HostageIcon"
	{
		"ControlName"		"Label"
		"fieldName"			"HostageIcon"
		"xpos"				"c-62"
		"ypos"				"c-105"
		"zpos"				"100"
		"wide"				"80"
		"tall"				"30"
		"tall_hidef"		"35"
		"visible"			"0"
		"enabled"			"1"
		"font"              "IconsBig"
		"labelText"			"g"
		"textAlignment"		"east"
		"fgcolor_override"  "255 255 255 255"
	}

	"MapInfoLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"MapInfoLabel"
		"xpos"				"c+53"
		"ypos"				"c-132"
		"zpos"				"100"
		"wide"				"181"
		"tall"				"70"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			""
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
		"wrap"				"1"
		"LineHeightScale"	".8"
	}

	"ScenarioLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ScenarioLabel"
		"xpos"				"c+53"
		"ypos"				"c-68"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Scenario"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"ScenarioValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ScenarioValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-68"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_ScenarioBomb"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	//"FriendlyFireLabel"
	//{
	//	"ControlName"		"Label"
	//	"fieldName"			"FriendlyFireLabel"
	//	"xpos"				"c+53"
	//	"ypos"				"c-40"
	//	"zpos"				"100"
	//	"wide"				"220"
	//	"tall"				"20"
	//	"tall_hidef"		"35"
	//	"autoResize"		"0"
	//	"pinCorner"			"0"
	//	"visible"			"1"
	//	"enabled"			"1"
	//	"font"              "X360_Body_3"
	//	"labelText"			"#Cstrike_Game_FriendlyFire"
	//	"textAlignment"		"north-west"
	//	"dulltext"			"0"
	//	"brighttext"		"0"
	//	"fgcolor_override"  "189 192 185 255"
	//}

	//"FriendlyFireValueLabel"
	//{
	//	"ControlName"		"Label"
	//	"fieldName"			"FriendlyFireValueLabel"
	//	"xpos"				"c+34"
	//	"ypos"				"c-40"
	//	"zpos"				"100"
	//	"wide"				"200"
	//	"tall"				"20"
	//	"tall_hidef"		"35"
	//	"autoResize"		"0"
	//	"pinCorner"			"0"
	//	"visible"			"1"
	//	"enabled"			"1"
	//	"font"              "X360_Body_3"
	//	"labelText"			"Off"
	//	"textAlignment"		"north-east"
	//	"dulltext"			"0"
	//	"brighttext"		"0"
	//	"fgcolor_override"  "189 192 185 255"
	//}

	"CashLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"CashLabel"
		"xpos"				"c+53"
		"ypos"				"c-40"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Cash"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"CashValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"CashValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-40"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"$XX,XXX"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"GameTimeLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"GameTimeLabel"
		"xpos"				"c+53"
		"ypos"				"c-25"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_GameTime"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"WinMatchLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"WinMatchLabel"
		"xpos"				"c+53"
		"ypos"				"c-25"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_WinMatch"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"WinMatchValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"WinMatchValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-25"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"XX minutes"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}
	
	"SpectateLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"SpectateLabel"
		"xpos"				"c+53"
		"ypos"				"c-10"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Spectate"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"SpectateValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"SpectateValueLabel"
		"xpos"				"c+34"
		"ypos"				"c-10"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"Anyone"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"BotsLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"BotsLabel"
		"xpos"				"c+53"
		"ypos"				"c+5"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Bots"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"BotsValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"BotsValueLabel"
		"xpos"				"c+34"
		"ypos"				"c+5"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			""
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"AutoBuyLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"AutoBuyLabel"
		"xpos"				"c+53"
		"ypos"				"c+20"
		"zpos"				"100"
		"wide"				"220"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_AutoBuy"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"AutoBuyValueLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"AutoBuyValueLabel"
		"xpos"				"c+34"
		"ypos"				"c+20"
		"zpos"				"100"
		"wide"				"200"
		"tall"				"20"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"1"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"X"
		"textAlignment"		"north-east"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
	}

	"ProgressLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"ProgressLabel"
		"xpos"				"c+53"
		"ypos"				"c+125"
		"zpos"				"100"
		"wide"				"181"
		"tall"				"60"
		"tall_hidef"		"35"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"font"              "X360_Body_3"
		"labelText"			"#Cstrike_Game_Progress"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"fgcolor_override"  "189 192 185 255"
		"wrap"				"1"
		"LineHeightScale"	".8"
	}

	"button_pin_right"		"68"
}

//--------------------------------------
// Create Search Dialog
//--------------------------------------
"CreateSearchDialog.res"
{
	"CreateSearchDialog"
	{
	    "ControlName"       "Frame"
	    "fieldname"         "CreateSearchDialog"
	    "x"                 "0"
	    "y"                 "0"
		"wide"              "440"
		"tall"              "380"
		"visible"           "1"
		"paintbackground"	"0"
	}

    "Background"
    {
		"ControlName"       "ScalableImagePanel"
		"fieldName"         "Background"
		"xpos"				"0"
		"ypos"				"0"
		"zpos"				"0"
		"wide"              "440"
		"tall"              "380"
		"visible"           "1"
		"enabled"           "1"
		"image"             "../vgui/mp_sp_screens/panel-multiplayer-search"
		"scaleImage"        "1"		
    }

	"SearchMessageLabel"
	{
		"ControlName"		"Label"
		"fieldname"			"SearchMessageLabel"
		"xpos"				"70"
		"ypos"				"64"
		"zpos"				"2"
		"wide"				"300"
		"tall"				"35"
		"visible"			"1"
		"enabled"			"1"
		"textalignment"		"center"
		"dulltext"			"0"
		"brighttext"		"0"
		"font"				"X360_Title_2"
		"labelText"			""
		"fgcolor_override"  "189 192 185 255"
	}

    "CancelLabel"
    {
		"ControlName"	            "Label"
		"fieldName"		            "CancelLabel"
		"xpos"			            "55"
		"ypos"			            "332"
		"wide"			            "350"
		"tall"			            "20"
		"autoResize"	            "0"
		"pinCorner"		            "0"
		"visible"		            "1"
		"enabled"		            "1"
		"labelText"		            "#Cstrike_TitlesTXT_Menu_Cancel"
		"dulltext"		            "0"
		"brighttext"	            "0"
		"font"			            "MenuLarge"
		"textAlignment"	            "north-east"
		"fgcolor_override"          "189 192 185 255"
    }

    "CancelImage"
	{
		"ControlName"	            "Label"
		"fieldName"		            "CancelImage"
		"xpos"		                "300"
		"ypos"		                "325"
		"tall"				        "35"
		"font"			            "GameUIButtons"
		"labeltext"		            "#GameUI_Icons_B_BUTTON"
		"fillcolor"	                "255 255 255 255"
		"fgcolor_override"          "255 255 255 255"
		"textAlignment"	            "north-west"
	}

	"AnimatingPanel"
	{
		"ControlName"	"AnimatingImagePanel"
		"fieldName"		"AnimatingPanel"
		"xpos"			"156"
		"xpos_lodef"	"156"
		"ypos"			"190"
		"ypos_lodef"	"190"
		"zpos"			"9"
		"wide"			"128"
		"wide_lodef"	"128"
		"tall"			"128"
		"tall_lodef"	"128"
		"scaleImage"	"1"
		"image"			"load-gizmo"
		"frames"		"13"
		"anim_framerate"	"30"
	}
}
//=============================================================================
// HPE_END
//=============================================================================

} // end ConsoleDialogs.res
