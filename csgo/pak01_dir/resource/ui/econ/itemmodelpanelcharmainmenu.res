"Resource/UI/Econ/ItemModelPanelCharMainMenu.res"
{
	"mainmenu_player-model"
	{
		"rule"
		{
			"model_partial" "custom_player/legacy/"
		}
		"config"
		{
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.11 0.11 0.11} dir[-0.50 0.80 0.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.07 0.10 0.14} dir[0.83 -0.24 -0.49] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.15 0.15 0.15} dir[-0.56 -0.52 0.65] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "46.28 -8.61 143.56"
			"shadow_light_orient"        "60.89 164.89 0.00"
			"shadow_light_brightness"    "4.90"
			"shadow_light_color"         "[0.81 0.92 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       	 "50.9"
			"shadow_light_vfov"       	 "50.9"
			"shadow_light_znear"       	 "75.5"
			"shadow_light_zfar"       	 "165.0"
			"shadow_light_atten_farz"    "330.0"
			"light_ambient"              "[0.17 0.20 0.26]"

			"root_mdl"					"models/player/custom_player/uiplayer/animset_uiplayer.mdl"
			"weapon_anim"				"default"
			"weapon_anim_loop"			"default"

			"camera_offset"   			"117.27 5.90 50.58"
			"camera_orient"   			"0.00 -147.69 0.00"
			"orbit_pivot"     			"-0.00 4.50 54.80"
			"root_camera_fov"     		"45.0"

			"item_rotate"				"y[-360 360]"

			"camera_preset_add"   "pos[117.27 3.3 50.58] pivot[-0.00 4.50 54.80] orient[0.00 -180.00 0.00]"
			"camera_preset_add"   "pos[117.27 3.3 50.58] pivot[-0.00 4.50 54.80] orient[0.00 -180.00 0.00]"

			//"light_directional_clearall" "1"
			//"light_directional_add"      "rgb{0.13 0.14 0.13} dir[-0.81 0.41 0.43] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			//"light_directional_add"      "rgb{2.37 0.60 0.28} dir[0.86 0.45 0.24] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			//"light_directional_add"      "rgb{0.00 0.43 0.61} dir[0.50 -0.69 -0.52] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			//"shadow_light_offset"        "38.67 40.11 107.51"
			//"shadow_light_orient"        "45.08 -137.36 0.00"
			//"shadow_light_brightness"    "1.64"
			//"shadow_light_color"         "[0.81 0.92 1.00]"
			//"shadow_light_rotation"      "[0.00 0.00 0.00]"
			//"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			//"shadow_light_hfov"       "50.9"
			//"shadow_light_vfov"       "50.9"
			//"shadow_light_znear"       "75.5"
			//"shadow_light_zfar"       "165.0"
			//"shadow_light_atten_farz"       "330.0"
			//"light_ambient"              "[0.12 0.21 0.46]"
		}
	}
}