"Resource/UI/ControllerDialog.res"
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