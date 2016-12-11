"Resource/UI/ItemModelPanel.res"
{
	"itemmodelpanel"
	{
		"ControlName"		"CEmbeddedItemModelPanel"
		"fieldName"		"itemmodelpanel"
	
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"1"		
		"wide"			"140"
		"tall"			"100"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"useparentbg"		"1"
		
		"inset_eq_x"	"2"
		"inset_eq_y"	"2"

		"fov"			"54"
		"start_framed"		"1"

		"disable_manipulation"	"1"

		"use_large_inventory_images"	"1"
		"force_square_image"			"1"

		//-13.1485 315.401 1.51682

		"model"
		{
			"angles_x"		"-13"
			"angles_y"		"-126"
			"angles_z"		"1.5"
		}
	}
	
	"namelabel"
	{
		"ControlName"	"CExLabel"
		"fieldName"		"namelabel"
		"font"			"ItemFontNameLarge"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"2"
		"wide"			"140"
		"tall"			"30"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%itemname%"
		"textAlignment"	"south"
		"fgcolor"		"235 226 202 255"
		"centerwrap"	"1"
	}
	"attriblabel"
	{
		"ControlName"	"CExLabel"
		"fieldName"		"attriblabel"
		"font"			"ItemFontAttribLarge"
		"xpos"			"0"
		"ypos"			"30"
		"zpos"			"2"
		"wide"			"140"
		"tall"			"60"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%attriblist%"
		"textAlignment"	"south"
		"fgcolor"		"0 0 0 255"
		"centerwrap"	"1"
	}
	
	"equippedlabel"
	{
		"ControlName"	"CExLabel"
		"fieldName"		"equippedlabel"
		"font"			"ItemFontAttribLarge"
		"xpos"			"37"
		"ypos"			"28"
		"zpos"			"2"
		"wide"			"35"
		"tall"			"10"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#ItemPanelEquipped"
		"textAlignment"	"center"
		"fgcolor"		"200 80 60 255"
		"bgcolor_override"		"0 0 0 255"
		"PaintBackgroundType"	"2"
		"paintbackground"	"0"
		"paintborder"		"0"
	}

	"tf2_icon"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"tf2_icon"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"2"
		"wide"			"12"
		"tall"			"12"
		"visible"		"0"
		"enabled"		"1"
		"image"			"store/store_icon_tf"
		"tileImage"		"0"
		"tileVertically" "0"
		"drawcolor"		"112 176 74 255"
	}
	
	"paint_icon"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"paint_icon"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"2"
		"wide"			"16"
		"tall"			"16"
		"visible"		"0"
		"enabled"		"1"
		"image"			"backpack_jewel_paint_splatter"
		"tileImage"		"0"
		"tileVertically" "0"
		"drawcolor"		"112 176 74 255"
	}

	"empty_socket_icon"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"empty_socket_icon"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"2"
		"wide"			"16"
		"tall"			"16"
		"visible"		"0"
		"enabled"		"1"
		"image"			"backpack_jewel_modify_target_b_g"
		"tileImage"		"0"
		"tileVertically" "0"
		"drawcolor"		"64 64 64 255"
	}

	"filled_socket_icon"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"filled_socket_icon"
		"xpos"			"0"
		"ypos"			"0"
		"zpos"			"2"
		"wide"			"16"
		"tall"			"16"
		"visible"		"0"
		"enabled"		"1"
		"image"			"backpack_jewel_modify_target_b_g"
		"tileImage"		"0"
		"tileVertically" "0"
		"drawcolor"		"255 255 255 255"
	}

	"quantitylabel"
	{
		"ControlName"	"CExLabel"
		"fieldName"		"quantitylabel"
		"font"			"ItemFontAttribSmall"
		"xpos"			"4"
		"ypos"			"4"
		"zpos"			"2"
		"wide"			"10"
		"tall"			"10"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"	"center"
		"fgcolor"		"200 80 60 255"
		"bgcolor_override"		"0 0 0 255"
		"PaintBackgroundType"	"2"
	}

	"contained_item_panel"
	{
		"ControlName"	"CItemModelPanel"
		"xpos"			"32"
		"ypos"			"20"
		"zpos"			"4"
		"wide"			"18"
		"tall"			"18"
		"visible"		"0"
		"bgcolor_override"		"0 0 0 200"
		"noitem_textcolor"		"117 107 94 255"
		"PaintBackgroundType"	"2"
		"paintborder"	"0"
		"useparentbg"	"0"
		
		"enabled"		"1"
		
		"model_xpos"	"1"
		"model_ypos"	"1"
		"model_wide"	"16"
		"model_tall"	"16"
		"text_ypos"		"60"
		"text_center"	"1"
		"model_only"	"1"
		
		"inset_eq_x"	"2"
		"inset_eq_y"	"2"
		
		"itemmodelpanel"
		{
			"use_item_rendertarget" "0"
			"allow_rot"				"0"
		}
		
		"use_item_sounds"	"1"
	}
}
