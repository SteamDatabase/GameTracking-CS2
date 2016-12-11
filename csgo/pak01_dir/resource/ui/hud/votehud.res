"Resource/UI/HUD/VoteHud.res"
{	
	"VotePassed"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"VotePassed"
		"xpos"			"0"
		"ypos"			"35"
		"wide"			"200" [$ENGLISH]
		"wide"			"270" [!$ENGLISH]
		"tall"			"67"
		"visible"		"0"
		"enabled"		"1"
		"bgcolor_override"	"0 0 0 240"
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
			"wide"			"148" [$ENGLISH]
			"wide"			"228" [!$ENGLISH]
			"tall"			"17"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4d_vote_vote_passed"
			"textAlignment"	"west"
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
			"ypos"			"29"
			"wide"			"180" [$ENGLISH]
			"wide"			"250" [!$ENGLISH]
			"tall"			"40"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"%passedresult%"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
			"noshortcutsyntax" "1"
		}		
	}
	
	"VoteFailed"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"VoteFailed"
		"xpos"			"0"
		"ypos"			"35"
		"wide"			"200" [$ENGLISH]
		"wide"			"270" [!$ENGLISH]
		"tall"			"67"
		"visible"		"0"
		"enabled"		"1"
		"bgcolor_override"	"0 0 0 240"
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
			"wide"			"148" [$ENGLISH]
			"wide"			"228" [!$ENGLISH]
			"tall"			"17"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4d_vote_vote_failed"
			"textAlignment"	"west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultLarge"
			"wrap"			"1"
			"fgcolor_override"	"200 30 30 255"
		}
		
		"NotEnoughVotes"
		{
			"ControlName"	"Label"
			"fieldName"		"NotEnoughVotes"
			"xpos"			"10"
			"ypos"			"29"
			"wide"			"180" [$ENGLISH]
			"wide"			"250" [!$ENGLISH]
			"tall"			"40"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4d_vote_not_enough_votes"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
		}		
	}
	
	"VoteActive"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"VoteActive"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"200" [$ENGLISH]
		"wide"			"280" [!$ENGLISH]
		"tall"			"140"
		"visible"		"0"
		"enabled"		"1"
		"PaintBackgroundType"	"2" // rounded corners
		"bgcolor_override"	"0 0 0 240"
		
		"Header"
		{
			"ControlName"	"Label"
			"fieldName"		"Header"
			"xpos"			"10"
			"ypos"			"5"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
			"tall"			"20"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_header"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultLarge"
			"wrap"			"1"
			"fgcolor_override"	"128 128 128 255"
		}
		
		"Issue"
		{
			"ControlName"	"Label"
			"fieldName"		"Issue"
			"xpos"			"10"
			"ypos"			"22"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
			"tall"			"40"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"%voteissue%"
			"textAlignment"	"north-west"
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
			"ypos"			"55"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
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
			"ypos"			"59"
			"zpos"			"-1"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
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
			"ypos"			"59"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
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
			"xpos"			"5" [$ENGLISH]
			"xpos"			"10" [!$ENGLISH]
			"ypos"			"59"
			"wide"			"83" [$ENGLISH]
			"wide"			"118" [!$ENGLISH]
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
			"xpos"			"87" [$ENGLISH]
			"xpos"			"128" [!$ENGLISH]
			"ypos"			"59"
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
			"xpos"			"112" [$ENGLISH]
			"xpos"			"152" [!$ENGLISH]
			"ypos"			"59"
			"wide"			"82" [$ENGLISH]
			"wide"			"118" [!$ENGLISH]
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
			"ypos"			"75"
			"zpos"			"-1"
			"wide"			"180" [$ENGLISH]
			"wide"			"250" [!$ENGLISH]
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
			"ypos"			"75"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
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
			"xpos"			"5" [$ENGLISH]
			"xpos"			"10" [!$ENGLISH]
			"ypos"			"75"
			"wide"			"83" [$ENGLISH]
			"wide"			"118" [!$ENGLISH]
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
			"xpos"			"87" [$ENGLISH]
			"xpos"			"128" [!$ENGLISH]
			"ypos"			"75"
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
			"xpos"			"112" [$ENGLISH]
			"xpos"			"152" [!$ENGLISH]
			"ypos"			"75"
			"wide"			"82" [$ENGLISH]
			"wide"			"118" [!$ENGLISH]
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
			"ypos"			"95"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
			"tall"			"1"
			"fillcolor"		"128 128 128 255"
			"zpos"			"0"
		}
		
		"VoteCountLabel"
		{
			"ControlName"	"Label"
			"fieldName"		"VoteCountLabel"
			"xpos"			"10"
			"ypos"			"97"
			"wide"			"190" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
			"tall"			"20"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4D_vote_current_vote_count"
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
			"ypos"			"113"
			"wide"			"180" [$ENGLISH]
			"wide"			"260" [!$ENGLISH]
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
	}
	
	"CallVoteFailed"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"CallVoteFailed"
		"xpos"			"0"
		"ypos"			"35"
		"wide"			"220" [$ENGLISH]
		"wide"			"270" [!$ENGLISH]
		"tall"			"67" [$ENGLISH]
		"tall"			"77" [!$ENGLISH]
		"visible"		"0"
		"enabled"		"1"
		"bgcolor_override"	"0 0 0 240"
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
			"wide"			"180" [$ENGLISH]
			"wide"			"250" [!$ENGLISH]
			"tall"			"17"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4d_vote_vote_failed"
			"textAlignment"	"west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultLarge"
			"wrap"			"1"
			"fgcolor_override"	"200 30 30 255"
		}
		
		"FailedReason"
		{
			"ControlName"	"Label"
			"fieldName"		"FailedReason"
			"xpos"			"10"
			"ypos"			"29"
			"wide"			"200" [$ENGLISH]
			"wide"			"250" [!$ENGLISH]
			"tall"			"40"
			"visible"		"1"
			"enabled"		"1"
			"labelText"		"#L4d_vote_no_vote_spam"
			"textAlignment"	"north-west"
			"dulltext"		"0"
			"brighttext"	"0"
			"font"			"DefaultMedium"
			"wrap"			"1"
			"fgcolor_override"	"255 255 255 255"
		}		
	}
}
