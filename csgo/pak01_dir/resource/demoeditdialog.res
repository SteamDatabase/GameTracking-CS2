	"Resource/DemoEditDialog.res"
{
	"TypeLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"TimeLabel"
		"xpos"			"10"
		"ypos"			"32"
		"wide"			"96"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"labelText"		"Command"
		"textAlignment"	"west"
		"dulltext"		"0"
	}
	
	"TypeBox"
	{
		"ControlName"	"ComboBox"
		"fieldName"		"TypeBox"
		"xpos"			"104"
		"ypos"			"32"
		"wide"			"224"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"1"
		"textHidden"	"0"
		"editable"		"0"
		"maxchars"		"-1"
	}
	
	
	
	"TimeLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"TimeLabel"
		"xpos"			"10"
		"ypos"			"64"
		"wide"			"96"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"labelText"		"Time"
		"textAlignment"	"west"
		"dulltext"		"0"
	}
	
	"TimeEntry"
	{
		"ControlName"	"TextEntry"
		"fieldName"		"ServerNameEdit"
		"xpos"			"104"
		"ypos"			"64"
		"wide"			"224"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"1"
		"textHidden"	"0"
		"editable"		"1"
		"maxchars"		"-1"
	}
	
	// 8 data buttons generated in GameUI
	
	"OkButton"
	{
		"ControlName"	"Button"
		"fieldName"		"OkButton"
		"xpos"			"262"
		"ypos"			"346"
		"wide"			"64"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"3"
		"command"		"ok"
	}	
	
	"CancelButton"
	{
		"ControlName"	"Button"
		"fieldName"		"CancelButton"
		"xpos"			"190"
		"ypos"			"346"
		"wide"			"64"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"3"
		"command"		"Close"
	}
	
	"GetViewButton"
	{
		"ControlName"	"Button"
		"fieldName"		"GetViewButton"
		"xpos"			"80"
		"ypos"			"346"
		"wide"			"64"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"3"
		"command"		"getview"
	}
	
	"GetTimeButton"
	{
		"ControlName"	"Button"
		"fieldName"		"GetTimeButton"
		"xpos"			"10"
		"ypos"			"346"
		"wide"			"64"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"3"
		"command"		"gettime"
	}
}
