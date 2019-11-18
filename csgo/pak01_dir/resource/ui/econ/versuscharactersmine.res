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

	"versus-mine"
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
			

//"light_directional_clearall" "1"
//"light_directional_add"      "rgb{0.85 0.44 0.00} dir[-0.67 0.60 0.44] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
//"light_directional_add"      "rgb{0.71 1.19 1.68} dir[-0.11 -0.99 -0.10] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
//"shadow_light_offset"        "98.89 -228.44 141.10"
//"shadow_light_orient"        "17.12 122.49 0.00"
//"shadow_light_brightness"    "1.68"
//"shadow_light_color"         "[1.00 0.85 0.65]"
//"shadow_light_rotation"      "[0.00 0.00 0.00]"
//"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
//"shadow_light_hfov"       "70.0"
//"shadow_light_vfov"       "70.0"
//"shadow_light_znear"       "20.1"
//"shadow_light_zfar"       "512.0"
//"shadow_light_atten_farz"       "1024.0"
//"light_ambient"              "[0.13 0.23 0.24]"

"light_directional_clearall" "1"
"light_directional_add"      "rgb{0.85 0.44 0.00} dir[-0.67 0.60 0.44] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
"light_directional_add"      "rgb{0.71 1.19 1.68} dir[-0.11 -0.99 -0.10] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
"shadow_light_offset"        "269.71 -200.70 121.23"
"shadow_light_orient"        "14.14 143.35 0.00"
"shadow_light_brightness"    "5.0"
"shadow_light_color"         "[1.00 0.88 0.77]"
"shadow_light_rotation"      "[0.00 0.00 0.00]"
"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
"shadow_light_hfov"       "70.0"
"shadow_light_vfov"       "70.0"
"shadow_light_znear"       "20.1"
"shadow_light_zfar"       "512.0"
"shadow_light_atten_farz"       "1024.0"
"light_ambient"              "[0.13 0.23 0.24]"
"camera_offset"   "246.01 2.75 51.18"
"camera_orient"   "2.75 -179.08 0.00"
"orbit_pivot"     "0.16 -1.20 39.37"
"root_camera_fov"     "49.6"
			//"orbit_pivot_bone"     "camera_target"

			//"shadow_light_rotation"		"0 0 0"
			//"shadow_light_flicker"		"2 0 1 1"
			"item_rotate"				"y[0 0]"



"camera_preset_add"   "pos[838.99 -10 36.53] pivot[0 0 36.53] orient[-0.00 -180.50 0.00] fov[25]" // start

"camera_preset_add"   "pos[438.99 -10 36.53] pivot[0 0 36.53] orient[-0.00 -180.50 0.00] fov[25]" // end

"camera_preset_add"   "pos[388.99 0 36.53] pivot[0 0 36.53] orient[-0.00 -179.50 0.00] fov[25]" // drift

"camera_preset_add"   "pos[-5.71 0 36.53] pivot[0 0 36.53] orient[-0.00 -179.50 0.00] fov[25]" // zoom out



"camera_preset_add"   "pos[838.99 -5 36.53] pivot[0 0 36.53] orient[-0.00 -180.00 0.00] fov[25]" // start

"camera_preset_add"   "pos[438.99 -5 36.53] pivot[0 0 36.53] orient[-0.00 -180.00 0.00] fov[25]" // end

"camera_preset_add"   "pos[388.99 -5 36.53] pivot[0 0 36.53] orient[-0.00 -180.00 0.00] fov[25]" // drift

"camera_preset_add"   "pos[-5.71 -5 36.53] pivot[0 0 36.53] orient[-0.00 180.00 0.00] fov[25]" // zoom out


		}
	}
}
