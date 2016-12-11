"Resource/UI/PZEndGamePanel.res"
{
	"EndGameTitle"
	{
		"ControlName"	"Label"
		"fieldName"		"EndGameTitle"
		"xpos"			"28"
		"ypos"			"34"
		"zpos"			"20"
		"wide"			"300"
		"tall"			"20"
		"visible"		"1"
		"enabled"		"1"
		"textAlignment"		"west"	
		"labelText"		"#L4D_vote_endgame_title"
		"font"			"FrameTitle"
		"fgcolor_override"	"192 192 192 255"
	}

	"TeamVsImage"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"TeamVsImage"
		"xpos"			"27"
		"ypos"			"55"
		"zpos"			"20"
		"wide"			"78"
		"tall"			"78"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"image"			"../vgui/menu_mode_versus"
	}

	"TeamScavengeImage"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"TeamScavengeImage"
		"xpos"			"27"
		"ypos"			"55"
		"zpos"			"20"
		"wide"			"78"
		"tall"			"78"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"image"			"../vgui/menu_mode_scavenge"
	}

	"VotePassed"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"VotePassed"
		"xpos"			"110"
		"ypos"			"50"
		"wide"			"220"
		"tall"			"97"
		"visible"		"0"
		"enabled"		"1"
		"bgcolor_override"	"0 0 0 0"
		"PaintBackgroundType"	"2" // rounded corners
		
		"PassedIcon"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"PassedIcon"
			"xpos"			"10"
			"ypos"			"10"
			"wide"			"17"
			"tall"			"17"
			"visible"		"1"
			"enabled"		"1"
			"scaleImage"	"1"
			"image"			"hud/vote_yes"
		}
		
		"PassedTitle"
		{
			"ControlName"	"Label"
			"fieldName"		"PassedTitle"
			"xpos"			"32"
			"ypos"			"10"
			"wide"			"188"
			"tall"			"32"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4d_vote_vote_passed"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultLarge"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
		}
		
		"PassedResult"
		{
			"ControlName"	"Label"
			"fieldName"		"PassedResult"
			"xpos"			"10"
			"ypos"			"42"
			"wide"			"210"
			"tall"			"40"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_vote_again_won"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
			"noshortcutsyntax" "1"
		}		
	}
	
	"VoteWait"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"VoteWait"
		"xpos"			"110"
		"ypos"			"50"
		"wide"			"220"
		"tall"			"97"
		"visible"		"0"
		"enabled"		"1"
		"bgcolor_override"	"0 0 0 0"
		"PaintBackgroundType"	"2" // rounded corners

		"PassedIcon"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"PassedIcon"
			"xpos"			"10"
			"ypos"			"10"
			"wide"			"17"
			"tall"			"17"
			"visible"		"1"
			"enabled"		"1"
			"scaleImage"	"1"
			"image"			"hud/vote_yes"
		}
		
		"PassedTitle"
		{
			"ControlName"	"Label"
			"fieldName"		"PassedTitle"
			"xpos"			"32"
			"ypos"			"10"
			"wide"			"188"
			"tall"			"26"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_vote_team_again"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
		}

		"FailedIcon"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"FailedIcon"
			"xpos"			"10"
			"ypos"			"10"
			"wide"			"17"
			"tall"			"17"
			"visible"		"1"
			"enabled"		"1"
			"scaleImage"	"1"
			"image"			"hud/vote_no"
		}
		
		"FailedTitle"
		{
			"ControlName"	"Label"
			"fieldName"		"FailedTitle"
			"xpos"			"32"
			"ypos"			"10"
			"wide"			"188"
			"tall"			"32"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_vote_team_return"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"200 30 30 255"
		}

		"WaitTitle"
		{
			"ControlName"	"Label"
			"fieldName"		"WaitTitle"
			"xpos"			"10"
			"ypos"			"36"
			"wide"			"210"
			"tall"			"24"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_vote_waiting"
			"textAlignment"	"west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
		}
	}
	
	"VoteFailed"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"VoteFailed"
		"xpos"			"110"
		"ypos"			"50"
		"wide"			"220"
		"tall"			"97"
		"visible"		"0"
		"enabled"		"1"
		"bgcolor_override"	"0 0 0 0"
		"PaintBackgroundType"	"2" // rounded corners
		
		"FailedIcon"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"FailedIcon"
			"xpos"			"10"
			"ypos"			"10"
			"wide"			"17"
			"tall"			"17"
			"visible"		"1"
			"enabled"		"1"
			"scaleImage"	"1"
			"image"			"hud/vote_no"
		}
		
		"FailedTitle"
		{
			"ControlName"	"Label"
			"fieldName"		"FailedTitle"
			"xpos"			"32"
			"ypos"			"10"
			"wide"			"188"
			"tall"			"32"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4d_vote_vote_failed"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultLarge"
			"wrap"			"1"
			"fgcolor_override"	"200 30 30 255"
		}

		"FailedResult"
		{
			"ControlName"	"Label"
			"fieldName"		"FailedResult"
			"xpos"			"10"
			"ypos"			"42"
			"wide"			"210"
			"tall"			"40"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_vote_return_won"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
			"noshortcutsyntax" "1"
		}		
	}
	
	"VoteActive"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"VoteActive"
		"xpos"			"110"
		"ypos"			"50"
		"wide"			"250"
		"tall"			"97"
		"visible"		"0"
		"enabled"		"1"
		"PaintBackgroundType"	"2" // rounded corners
		"bgcolor_override"	"0 0 0 0"
		
		"Issue"
		{
			"ControlName"	"Label"
			"fieldName"		"Issue"
			"xpos"			"10"
			"ypos"			"2"
			"wide"			"210"
			"tall"			"24"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_text"
			"textAlignment"	"west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"255 255 255 255"
			"wrap"			"1"
			"noshortcutsyntax" "1"
		}
		
		// divider
		"Divider"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"Divider"
			"xpos"			"10"
			"ypos"			"28"
			"wide"			"202"
			"tall"			"1"
			"fillcolor"		"128 128 128 255"
			"zpos"			"0"
		}
		
		// yes legend
		
		"YesBackground_Selected"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"YesBackground_Selected"
			"xpos"			"10"
			"ypos"			"30"
			"zpos"			"-1"
			"wide"			"202"
			"tall"			"16"
			"zpos"			"1"
			"fillcolor"		"88 119 140 180"
			"zpos"			"0"
			"visible"		"1"
		}
		
		"YesPCLabel"	[$WIN32]
		{
			"ControlName"	"Label"
			"fieldName"		"YesPCLabel"
			"xpos"			"10"
			"ypos"			"30"
			"wide"			"210"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_yes_pc_instruction"
			"textAlignment"	"center"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"255 255 255 255"
		}

		"YesLeftLabel"	[$X360]
		{
			"ControlName"	"Label"
			"fieldName"		"YesLeftLabel"
			"xpos"			"0"
			"ypos"			"30"
			"wide"			"99"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_yes_instruction_a"
			"textAlignment"	"east"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"255 255 255 255"
		}
		
		"YesIcon"	[$X360]
		{
			"ControlName"	"Label"
			"fieldName"		"YesIcon"
			"xpos"			"98"
			"ypos"			"30"
			"wide"			"24"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"5"
			"textAlignment"	"center"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"GameUIButtons"
		}
				
		"YesRightLabel"	[$X360]
		{
			"ControlName"	"Label"
			"fieldName"		"YesRightLabel"
			"xpos"			"122"
			"ypos"			"30"
			"wide"			"105"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_yes_instruction_b"
			"textAlignment"	"west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"255 255 255 255"
		}
		
		"NoBackground_Selected"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"NoBackground_Selected"
			"xpos"			"10"
			"ypos"			"46"
			"zpos"			"-1"
			"wide"			"202"
			"tall"			"16"
			"zpos"			"1"
			"fillcolor"		"88 119 140 180"
			"zpos"			"0"
			"visible"		"1"
		}
		
		"NoPCLabel"	[$WIN32]
		{
			"ControlName"	"Label"
			"fieldName"		"NoPCLabel"
			"xpos"			"10"
			"ypos"			"46"
			"wide"			"210"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_no_pc_instruction"
			"textAlignment"	"center"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"255 255 255 255"
		}
		
		"NoLeftLabel"	[$X360]
		{
			"ControlName"	"Label"
			"fieldName"		"NoLeftLabel"
			"xpos"			"5"
			"ypos"			"46"
			"wide"			"94"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_no_instruction_a"
			"textAlignment"	"east"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"255 255 255 255"
		}
		
		// no legend
		"NoIcon"	[$X360]
		{
			"ControlName"	"Label"
			"fieldName"		"NoIcon"
			"xpos"			"98"
			"ypos"			"46"
			"wide"			"24"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"4"
			"textAlignment"	"center"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"GameUIButtons"
		}
				
		"NoRightLabel"	[$X360]
		{
			"ControlName"	"Label"
			"fieldName"		"NoRightLabel"
			"xpos"			"122"
			"ypos"			"46"
			"wide"			"125"
			"tall"			"16"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_no_instruction_b"
			"textAlignment"	"west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"255 255 255 255"
		}
		
		// divider
		"Divider2"
		{
			"ControlName"	"ImagePanel"
			"fieldName"		"Divider2"
			"xpos"			"10"
			"ypos"			"64"
			"wide"			"202"
			"tall"			"1"
			"fillcolor"		"128 128 128 255"
			"zpos"			"0"
		}
		
		"VoteCountLabel"
		{
			"ControlName"	"Label"
			"fieldName"		"VoteCountLabel"
			"xpos"			"10"
			"ypos"			"66"
			"wide"			"210"
			"tall"			"12"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_current_vote_count"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"128 128 128 255"
		}
		
		"SplitscreenPlayer1"
		{
			"ControlName"	"Label"
			"fieldName"		"SplitscreenPlayer1"
			"xpos"			"10"
			"ypos"			"66"
			"wide"			"90"
			"tall"			"12"
			"visible"		"0"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_vote_player1"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"128 128 128 255"
		}
		
		"SplitscreenPlayer2"
		{
			"ControlName"	"Label"
			"fieldName"		"SplitscreenPlayer2"
			"xpos"			"111"
			"ypos"			"66"
			"wide"			"90"
			"tall"			"12"
			"visible"		"0"
			"enabled"		"1"
			"labelText"		"#L4D_vote_endgame_vote_player2"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"fgcolor_override"	"128 128 128 255"
		}
		
		// vote bar
		"VoteBar"
		{
			"ControlName"	"Panel"
			"fieldName"		"VoteBar"
			"xpos"			"11"
			"ypos"			"78"
			"wide"			"90"
			"tall"			"18"
			"zpos"			"2"
			"visible"		"1"
			"enabled"		"1"			
			"box_size"		"16"
			"spacer"		"6"
			"box_inset"		"1"
			"yes_texture"	"vgui/hud/vote_yes"
			"no_texture"	"vgui/hud/vote_no"			
		}			

		// vote bar
		"VoteBar2"
		{
			"ControlName"	"Panel"
			"fieldName"		"VoteBar2"
			"xpos"			"111"
			"ypos"			"78"
			"wide"			"90"
			"tall"			"18"
			"zpos"			"2"
			"visible"		"0"
			"enabled"		"1"			
			"box_size"		"16"
			"spacer"		"6"
			"box_inset"		"1"
			"yes_texture"	"vgui/hud/vote_yes"
			"no_texture"	"vgui/hud/vote_no"			
		}			

	}

	"BackgroundImage"
	{
	    "ControlName"	"ScalableImagePanel"
	    "fieldName"		"BackgroundImage"
	    "xpos"		"20"
	    "ypos"		"30"
	    "wide"		"329"	[!$ENGLISH]
	    "wide"		"319"	[$ENGLISH]
	    "tall"		"120"		
	    "visible"		"1"
	    "enabled"		"1"
	    "scaleImage"	"1"	
	    "image"			"../vgui/hud/ScalablePanel_bgBlack50_outlineGrey"
	    "drawcolor"		"255 64 64 255"
	    "src_corner_height"		"16"			// pixels inside the image
	    "src_corner_width"		"16"
	    "draw_corner_width"		"3"				// screen size of the corners ( and sides ), proportional
	    "draw_corner_height" 	"3"	
	}

	"BackgroundFill"
	{
	    "ControlName"		"ImagePanel"
	    "fieldName"			"BackgroundFill"
	    "xpos"			"20"
	    "ypos"			"30"
	    "wide"			"329"	[!$ENGLISH]
	    "wide"			"319"	[$ENGLISH]
	    "tall"			"120"
	    "scaleImage"		"1"
	    "visible"			"1"
	    "enabled"			"1"
	    "fillcolor" 		"0 0 0 235"
	    "zpos"				"-2"
	}

	"Splatter1"
	{
	    "ControlName"		"ImagePanel"
	    "fieldName"			"Splatter1"
	    "xpos"				"0"
	    "ypos"				"10"
	    "wide"				"100"
	    "tall"				"60"
	    "scaleImage"		"1"
	    "visible"			"1"
	    "enabled"			"1"
	    "image"				"../vgui/hud/splatter1"
	    "drawColor"			"64 64 64 255"
	    "zpos"				"-3"
	}
	
	"Splatter3"
	{
	    "ControlName"		"ImagePanel"
	    "fieldName"			"Splatter3"
	    "xpos"				"36"
	    "ypos"				"55"
	    "wide"				"80"
	    "tall"				"80"
	    "scaleImage"		"1"
	    "visible"			"1"
	    "enabled"			"1"
	    "image"				"../vgui/hud/splatter3"
	    "drawColor"			"64 64 64 255"
	    "zpos"				"-3"
	}
	
	"Splatter4"
	{
	    "ControlName"		"ImagePanel"
	    "fieldName"			"Splatter4"
	    "xpos"				"276"
	    "ypos"				"-6"
	    "wide"				"80"
	    "tall"				"80"
	    "scaleImage"		"1"
	    "visible"			"1"
	    "enabled"			"1"
	    "image"				"../vgui/hud/splatter_corner_upper_right"
	    "drawColor"			"64 64 64 255"
	    "zpos"				"-3"
	}
	
	"Splatter6"
	{
	    "ControlName"		"ImagePanel"
	    "fieldName"			"Splatter6"
	    "xpos"				"190"
	    "ypos"				"150"
	    "wide"				"110"
	    "tall"				"30"
	    "scaleImage"		"1"
	    "visible"			"1"
	    "enabled"			"1"
	    "image"				"../vgui/hud/splatter_horizontal_bottom"
	    "drawColor"			"64 64 64 255"
	    "zpos"				"-3"
	}
}
