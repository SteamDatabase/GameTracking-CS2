"Resource/UI/Econ/VersusCharacters.res"
{
	"MainWindowLayout"
	{
		// Position of the preview panel when in main menu
		"rootbounds_mainmenu"
		{
			"x_left"			"c-71"
			"x_right"		"c256"
			"y_top"			"c-132"
			"y_bottom"		"c100"
		}

		// Position of the preview panel when inspecting own loadout from pause menu
		"rootbounds_ingame"
		{
			"x_left"			"c-163"
			"x_right"		"c166"
			"y_top"			"c-165"
			"y_bottom"		"c70"
		}

		// Position of preview panel when in client viewport of live game spectator HUD
		"rootbounds_inlivegame"
		{
			"x_left"			"c-163"
			"x_right"		"c166"
			"y_top"			"c-65"
			"y_bottom"		"c170"
		}
	}

	"versus-enemy"
	{
		"rule"
		{
			"model_path_partial" "custom_player/legacy/"
		}
		"config"
		{
			"root_mdl"					"models/player/custom_player/uiplayer/animset_uiplayer.mdl"
			"weapon_anim"				"default"
			"weapon_anim_loop"			"default"

"light_directional_clearall" "1"
"light_directional_add"      "rgb{0.47 0.09 0.03} dir[-0.38 -0.70 0.60] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
"light_directional_add"      "rgb{1.00 0.79 0.47} dir[0.66 0.42 -0.62] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
"shadow_light_offset"        "408.42 -80.36 50.49"
"shadow_light_orient"        "1.53 169.03 0.00"
"shadow_light_brightness"    "4.70"
"shadow_light_color"         "[0.87 0.97 1.00]"
"shadow_light_rotation"      "[0.00 0.00 0.00]"
"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
"shadow_light_hfov"       "70.0"
"shadow_light_vfov"       "70.0"
"shadow_light_znear"       " 4.0"
"shadow_light_zfar"       "512.0"
"shadow_light_atten_farz"       "1024.0"
"light_ambient"              "[0.00 0.00 0.00]"

"camera_offset"   "246.01 2.75 51.18"
"camera_orient"   "2.75 -179.08 0.00"
"orbit_pivot"     "0.16 -1.20 39.37"
"root_camera_fov"     "49.6"

			//"orbit_pivot_bone"     "camera_target"

			//"shadow_light_rotation"		"0 0 0"
			//"shadow_light_flicker"		"2 0 1 1"
			"item_rotate"				"y[0 0]"



"camera_preset_add"   "pos[252.68 2.44 37.41] pivot[0.45 -0.60 34.37] orient[0 -180 0.00] fov[49.6]"
"camera_preset_add"   "pos[179.89 1.56 36.53] pivot[0.45 -0.60 34.37] orient[0 -180 0.00] fov[49.6]"

"camera_preset_add"   "pos[-30.96 14.12 58.39] pivot[-0.03 14.49 58.77] orient[0 -180 0.00] fov[49.6]"



		}
	}
	
}
