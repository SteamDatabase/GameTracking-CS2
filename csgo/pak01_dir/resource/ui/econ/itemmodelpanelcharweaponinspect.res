"Resource/UI/Econ/ItemModelPanelCharWeaponInspect.res"
{
	"default_weapons"
	{
		"rule"
		{
			// Default rule matches all weapons and sets up all default settings
		}
		"config"
		{
			"root_mdl"					    ""		                                // Which pedestal model to load, weapon model is merged to the pedestal, null => weapon model is the scene
			"root_anim"					    ""                          			// Which activity to play on the pedestal
			"root_anim_loop"			    ""				                        // Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"				    ""						                // Which activity to play on the weapon
			"weapon_anim_loop"			    ""	                					// Which activity to play on the weapon after the initial weapon animation finishes
			"root_camera"				    "cam_inspect"							// Which attachment specifies camera location
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.89 0.89 0.89} dir[-0.34 -0.90 -0.29] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.73 0.73 0.73} dir[0.23 0.94 -0.24] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.88 0.88 0.88} dir[0.97 0.02 -0.23] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "36.42 26.30 15.58"
			"shadow_light_orient"        "33.72 -112.77 0.00"
			"shadow_light_brightness"    "2.7"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.06 0.06 0.06]"
			"item_rotate"		"x[-180 180] z[-180 180] y[-180 180]"			// rotate bounds and order of rotation for mouse drag in x then y axis, i.e. y[-10 10] z[20 -20] means dragging mouse horizontally results in a rotation around y between -10 and 10 degrees, and dragging mouse vertically results in a rotation around z between 20 and -20 degrees (sign of bounds indicate which flipped 'sense' the rotation is in)
			"item_orient"	   "0.0 0.0 0.0"									// initial orientation of item (if not attached)
		}
	}


	"coin"
	{
		"rule"
		{
			"model_partial" "inventory_items"
		}
		"config"
		{
			"root_mdl"					"models/weapons/pedestal_badges_panorama.mdl"		// Which pedestal model to load, weapon model is merged to the pedestal
			"root_anim"					"ACT_IDLE_INSPECT"				// Which activity to play on the pedestal
			"root_anim_loop"			"ACT_IDLE_INSPECT"				// Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"				"ACT_IDLE_INSPECT"						// Which activity to play on the weapon
			"weapon_anim_loop"			"ACT_IDLE_INSPECT"						// Which activity to play on the weapon after the initial weapon animation finishes
			"root_camera"				"cam_inspect"								// Which attachment specifies camera location
			"root_camera_fov"			"54.0"									// Camera will use the specified FOV
			"light_directional_clearall" "1"
			"light_ambient"				"[.01 .01 .01]"
			"light_directional_add" 	"rgb{.5 1.0 2.0} dir[1 -75 10.0]"
			"shadow_light_brightness"		"1.2"									// Shadow light color brightness multiplier
			"shadow_light_color"		"[1 1 1]"	
			"shadow_light_texture"		"effects/flashlight_inspect"					// Shadow light texture cookie
			"camera_offset"				"0 0 0"
			"camera_orient"				"0 0 0"
			"shadow_light_offset"		"-1 2 -7"
			"shadow_light_orient"		"-3 0 0"
		}
	}

	"music_kit"
	{
		"rule"
		{
			"type" "other"
			"model_partial" "music_kit"
		}
		"config"
		{
			"root_mdl"					"models\weapons\pedestal_music_kits_panorama.mdl"
			"camera_offset"   "3.13 0.33 21.43"
			"camera_orient"   "84.50 -172.53 0.00"
			"orbit_pivot"     "1.09 0.06 0.03"
			"item_rotate"				    "x[-0 0] y[-0 0]"

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.15 0.23 0.30} dir[-0.29 -0.62 0.73] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-7.71 15.99 23.52"
			"shadow_light_orient"        "51.96 -60.33 0.00"
			"shadow_light_brightness"    "6.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
		}
	}

	/////////////////////////////
	//guns
	/////////////////////////////

	"elite"
	{
		"rule"
		{
			"model" "v_pist_elite"
		}
		"config"
		{
			"camera_offset"   "44.64 23.04 -1.77"
			"camera_orient"   "4.19 -139.42 0.00"
			"orbit_pivot"     "18.10 0.30 -4.33"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stikerpreview_elite"
	{
		"rule"
		{
			"model" "v_pist_elite"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "1.77 11.36 -1.77"
			"camera_orient"   "10.38 -39.95 0.00"
			"orbit_pivot"     "17.04 -1.43 -5.42"
			"item_rotate"	  "y[-15 15] x[ 0 0 ]"

			// Presets start here when called from JS thier index starts at 1
			"camera_preset_add"   "pos[0.02 -9.71 -1.78] pivot[15.90 0.59 -4.65] orient[8.64 32.97 0.00]" // sticker slot 2 and 3
		}
	}

	"cz75"
	{
		"rule"
		{
			"model" "v_pist_cz_75"
		}
		"config"
		{
			"camera_offset"   "36.42 14.54 -3.60"
			"camera_orient"   "1.44 -135.52 0.00"
			"orbit_pivot"     "18.63 -2.93 -4.23"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	
	"stickerpreview_cz75"
	{
		"rule"
		{
			"model" "v_pist_cz_75"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "10.24 19.53 -2.47"
			"camera_orient"   "4.19 -69.52 0.00"
			"orbit_pivot"     "18.63 -2.93 -4.23"
			"item_rotate"	  "y[-40 40] x[ 0 0 ]"
		}
	}

	"glock18"
	{
		"rule"
		{
			"model" "v_pist_glock18"
		}
		"config"
		{
			"camera_offset"   "23.61 18.92 -4.59"
			"camera_orient"   "-2.36 -105.04 0.00"
			"orbit_pivot"     "17.71 -3.02 -3.65"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_glock18"
	{
		"rule"
		{
			"model" "v_pist_glock18"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "8.06 14.59 -1.19"
			"camera_orient"   "7.27 -61.27 0.00"
			"orbit_pivot"     "17.71 -3.01 -3.75"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-30 30] x[ 0 0 ]"
		}
	}

	"deagle"
	{
		"rule"
		{
			"model" "v_pist_deagle"
		}
		"config"
		{
			"camera_offset"   "30.86 17.73 -1.32"
			"camera_orient"   "5.11 -119.47 0.00"
			"orbit_pivot"     "18.64 -3.89 -3.54"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_deagle"
	{
		"rule"
		{
			"model" "v_pist_deagle"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "12.39 14.27 -2.19"
			"camera_orient"   "4.88 -71.35 0.00"
			"orbit_pivot"     "18.55 -3.98 -3.84"
			"item_rotate"	  "y[-50 20] x[ 0 0 ]"
		}
	}

	"usp"
	{
		"rule"
		{
			"model" "v_pist_223"
		}
		"config"
		{
			"camera_offset"   "42.48 22.31 -4.45"
			"camera_orient"   "-0.53 -128.42 0.00"
			"orbit_pivot"     "22.45 -2.95 -4.15"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_usp"
	{
		"rule"
		{
			"model" "v_pist_223"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "5.64 15.81 -1.84"
			"camera_orient"   "7.26 -51.87 0.00"
			"orbit_pivot"     "20.79 -3.49 -4.96"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-20 40] x[ 0 0 ]"
		}
	}

	"p250"
	{
		"rule"
		{
			"model" "v_pist_p250"
		}
		"config"
		{
			"camera_offset"   "36.54 16.89 -5.00"
			"camera_orient"   "-2.82 -134.14 0.00"
			"orbit_pivot"     "17.45 -2.77 -3.65"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_p250"
	{
		"rule"
		{
			"model" "v_pist_p250"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "13.57 16.60 0.74"
			"camera_orient"   "12.54 -78.68 0.00"
			"orbit_pivot"     "17.45 -2.77 -3.65"
			"item_rotate"	  "y[-50 40] x[ 0 0 ]"
		}
	}

	"fiveseven"
	{
		"rule"
		{
			"model" "v_pist_fiveseven"
		}
		"config"
		{
			"camera_offset"   "36.32 17.23 -4.98"
			"camera_orient"   "-2.59 -132.54 0.00"
			"orbit_pivot"     "17.92 -2.82 -3.75"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_fiveseven"
	{
		"rule"
		{
			"model" "v_pist_fiveseven"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "7.47 20.23 -0.32"
			"camera_orient"   "7.72 -65.62 0.00"
			"orbit_pivot"     "17.92 -2.82 -3.75"
			"item_rotate"	  "y[-40 40] x[ 0 0 ]"
		}
	}

	"tec9"
	{
		"rule"
		{
			"model" "v_pist_tec9"
		}
		"config"
		{
			"camera_offset"   "44.57 18.35 -5.47"
			"camera_orient"   "1.30 -135.29 0.00"
			"orbit_pivot"     "20.88 -5.10 -6.23"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_tec9"
	{
		"rule"
		{
			"model" "v_pist_tec9"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "4.23 17.46 3.35"
			"camera_orient"   "19.63 -54.39 0.00"
			"orbit_pivot"     "20.49 -5.24 -6.61"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"p2000"
	{
		"rule"
		{
			"model" "v_pist_hkp2000"
		}
		"config"
		{
			"camera_offset"   "34.41 18.87 -3.89"
			"camera_orient"   "-0.07 -127.50 0.00"
			"orbit_pivot"     "17.83 -2.75 -3.85"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_p2000"
	{
		"rule"
		{
			"model" "v_pist_hkp2000"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "8.68 19.28 -0.81"
			"camera_orient"   "7.26 -67.45 0.00"
			"orbit_pivot"     "17.83 -2.75 -3.85"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-20 50] x[ 0 0 ]"
		}
	}

	"revolver"
	{
		"rule"
		{
			"model" "v_pist_revolver"
		}
		"config"
		{
			"camera_offset"   "36.93 22.88 -3.42"
			"camera_orient"   "1.30 -124.29 0.00"
			"orbit_pivot"     "18.77 -3.75 -4.15"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	
	"stickerpreview_revolver"
	{
		"rule"
		{
			"model" "v_pist_revolver"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "23.94 17.51 1.27"
			"camera_orient"   "13.91 -103.66 0.00"
			"orbit_pivot"     "18.77 -3.75 -4.15"
			"item_rotate"	  "y[-20 20] x[ 0 0 ]"

			// Presets start here when called from JS thier index starts at 1
			"camera_preset_add"   "pos[10.35 -22.81 4.44] pivot[18.77 -3.75 -4.15] orient[22.39 66.16 0.00]" // sticker slot 4
		}
	}

	"SMGs"
	{
		"rule"
		{
			"type" "SubMachinegun"
		}
		"config"
		{
			"camera_offset"   "43.08 19.85 -6.68"
			"camera_orient"   "0.23 -128.48 0.00"
			"orbit_pivot"     "22.67 -5.83 -6.81"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"mac10"
	{
		"rule"
		{
			"model" "v_smg_mac10"
		}
		"config"
		{
			"camera_offset"   "22.91 25.82 -4.91"
			"camera_orient"   "3.44 -90.44 0.00"
			"orbit_pivot"     "22.67 -5.83 -6.81"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}
	
	"stickerpreview_mac10"
	{
		"rule"
		{
			"model" "v_smg_mac10"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "22.91 25.82 -4.91"
			"camera_orient"   "3.44 -90.44 0.00"
			"orbit_pivot"     "22.67 -5.83 -6.81"
			"item_rotate"		"y[-50 50]"
		}
	}

	"bizon"
	{
		"rule"
		{
			"model" "v_smg_bizon"
		}
		"config"
		{
			"camera_offset"   "39.98 32.14 -7.62"
			"camera_orient"   "-2.98 -117.94 0.00"
			"orbit_pivot"     "20.13 -5.28 -5.41"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_bizon"
	{
		"rule"
		{
			"model" "v_smg_bizon"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "8.92 24.93 3.30"
			"camera_orient"   "15.12 -74.17 0.00"
			"orbit_pivot"     "17.62 -5.73 -5.32"
			"item_rotate"	  "y[-50 30] x[ 0 0 ]"
		}
	}

	"mp9"
	{
		"rule"
		{
			"model" "v_smg_mp9"
		}
		"config"
		{
			"camera_offset"   "25.61 31.32 -0.24"
			"camera_orient"   "6.34 -109.85 0.00"
			"orbit_pivot"     "12.74 -4.33 -4.45"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_mp9"
	{
		"rule"
		{
			"model" "v_smg_mp9"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "20.18 24.05 -5.65"
			"camera_orient"   "-2.14 -101.60 0.00"
			"orbit_pivot"     "14.25 -4.86 -4.55"
			"item_rotate"	  "y[-50 50] x[ 0 0 ]"
		}
	}

	"mp7"
	{
		"rule"
		{
			"model" "v_smg_mp7"
		}
		"config"
		{
			"camera_offset"   "36.61 21.15 -5.69"
			"camera_orient"   "-0.07 -124.29 0.00"
			"orbit_pivot"     "18.45 -5.48 -5.65"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_mp7"
	{
		"rule"
		{
			"model" "v_smg_mp7"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "12.98 26.14 -4.14"
			"camera_orient"   "2.68 -79.14 0.00"
			"orbit_pivot"     "19.05 -5.49 -5.65"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"p90"
	{
		"rule"
		{
			"model" "v_smg_p90"
		}
		"config"
		{
			"camera_offset"   "33.69 20.78 -5.72"
			"camera_orient"   "-1.91 -126.81 0.00"
			"orbit_pivot"     "14.38 -5.02 -4.65"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_p90"
	{
		"rule"
		{
			"model" "v_smg_p90"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "2.53 25.33 -4.66"
			"camera_orient"   "0.15 -69.06 0.00"
			"orbit_pivot"     "14.06 -4.78 -4.75"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"ump45"
	{
		"rule"
		{
			"model" "v_smg_ump45"
		}
		"config"
		{
			"camera_offset"   "52.65 30.63 -8.85"
			"camera_orient"   "-2.37 -129.56 0.00"
			"orbit_pivot"     "23.35 -4.84 -6.95"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_ump45"
	{
		"rule"
		{
			"model" "v_smg_ump45"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "9.22 35.35 1.96"
			"camera_orient"   "10.92 -70.89 0.00"
			"orbit_pivot"     "23.15 -4.86 -6.25"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}
	
	"Rifles"
	{
		"rule"
		{
			"type" "Rifle"
		}
		"config"
		{
			"camera_offset"   "40.16 25.73 -4.63"
			"camera_orient"   "1.80 -124.98 0.00"
			"orbit_pivot"     "12.14 -14.32 -6.17"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"ak47"
	{
		"rule"
		{
			"model" "v_rif_ak47"
		}
		"config"
		{
			"camera_offset"   "48.96 37.18 -5.19"
			"camera_orient"   "0.43 -125.90 0.00"
			"orbit_pivot"     "18.35 -5.10 -5.58"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_ak47"
	{
		"rule"
		{
			"model" "v_rif_ak47"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "4.53 30.22 2.44"
			"camera_orient"   "11.20 -70.44 0.00"
			"orbit_pivot"     "17.24 -5.55 -5.08"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"aug"
	{
		"rule"
		{
			"model" "v_rif_aug"
		}
		"config"
		{
			"camera_offset"   "46.78 29.27 -3.42"
			"camera_orient"   "3.36 -133.00 0.00"
			"orbit_pivot"     "16.24 -3.47 -6.05"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_aug"
	{
		"rule"
		{
			"model" "v_rif_aug"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "0.92 32.48 -2.51"
			"camera_orient"   "4.51 -75.02 0.00"
			"orbit_pivot"     "10.55 -3.49 -5.45"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"mp5"
	{
		"rule"
		{
			"model" "v_smg_mp5sd"
		}
		"config"
		{
			"camera_offset"   "43.16 43.59 -14.25"
			"camera_orient"   "-8.64 -109.46 0.00"
			"orbit_pivot"     "25.97 -5.07 -6.40"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"

			"camera_preset_add"   "pos[25.28 30.75 -4.87] pivot[26.73 -5.19 -6.31] orient[2.29 -87.69 0.00] fov[54.3]" //1 sideview for update panel
			"camera_preset_add"   "pos[40.49 27.39 -7.87] pivot[26.73 -5.19 -6.31] orient[-2.52 -112.90 0.00] fov[54.3]"
		}
	}

	"famas"
	{
		"rule"
		{
			"model" "v_rif_famas"
		}
		"config"
		{
			"camera_offset"   "49.43 35.84 -7.12"
			"camera_orient"   "-0.08 -124.97 0.00"
			"orbit_pivot"     "20.12 -6.07 -7.05"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_famas"
	{
		"rule"
		{
			"model" "v_rif_famas"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "-0.40 40.13 3.84"
			"camera_orient"   "12.07 -68.14 0.00"
			"orbit_pivot"     "18.22 -6.28 -6.85"
			"item_rotate"	  "y[-50 30] x[ 0 0 ]"
		}
	}


	"galilar"
	{
		"rule"
		{
			"model" "v_rif_galilar"
		}
		"config"
		{
			"camera_offset"   "48.21 34.63 -7.48"
			"camera_orient"   "-1.91 -124.98 0.00"
			"orbit_pivot"     "20.28 -5.29 -5.85"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_galilar"
	{
		"rule"
		{
			"model" "v_rif_galilar"
			"sticker_preview" "1"
		} 
		"config"
		{
			"camera_offset"   "-0.06 30.73 -4.83"
			"camera_orient"   "-0.08 -64.70 0.00"
			"orbit_pivot"     "17.69 -6.83 -4.78"
			"item_rotate"	  "y[-50 30] x[ 0 0 ]"
		}
	}

	"m4a1"
	{
		"rule"
		{
			"model" "v_rif_m4a1"
		}
		"config"
		{
			"camera_offset"   "50.05 35.62 -10.30"
			"camera_orient"   "-4.20 -126.81 0.00"
			"orbit_pivot"     "19.55 -5.14 -6.56"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_m4a1"
	{
		"rule"
		{
			"model" "v_rif_m4a1"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "17.08 35.99 5.97"
			"camera_orient"   "16.88 -91.29 0.00"
			"orbit_pivot"     "16.15 -5.57 -6.65"
			"item_rotate"	  "y[-50] x[ 0 0 ]"
		}
	}

	"m4a1_s"
	{
		"rule"
		{
			"model" "v_rif_m4a1_s"
		}
		"config"
		{
			"camera_offset"   "51.17 -49.90 -9.69"
			"camera_orient"   "-5.12 149.54 0.00"
			"orbit_pivot"     "-3.04 -18.01 -4.05"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.34 0.34 0.34} dir[-0.77 0.61 0.17] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.53 0.53 0.53} dir[0.85 0.45 0.27] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "37.03 -23.96 24.07"
			"shadow_light_orient"        "34.77 171.56 0.00"
			"shadow_light_brightness"    "2.5"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       "18.1"
			"shadow_light_zfar"       "67.6"
			"shadow_light_atten_farz"       "135.2"
			"light_ambient"              "[0.06 0.06 0.06]"
		}
	}

	"stickerpreview_m4a1_s"
	{
		"rule"
		{
			"model" "v_rif_m4a1_s"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "39.64 -4.46 -1.39"
			"camera_orient"   "4.28 -169.89 0.00"
			"orbit_pivot"     "-3.31 -12.12 -4.65"
			"item_rotate"	  "y[-50 30] x[ 0 0 ]"
		}
	}

	"awp"
	{
		"rule"
		{
			"model" "v_snip_awp"
		}
		"config"
		{
			"camera_offset"   "61.21 48.22 -6.88"
			"camera_orient"   "-0.72 -121.54 0.00"
			"orbit_pivot"     "28.30 -5.40 -6.09"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_awp"
	{
		"rule"
		{
			"model" "v_snip_awp"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "35.88 33.49 -3.65"
			"camera_orient"   "1.80 -114.89 0.00"
			"orbit_pivot"     "18.33 -4.33 -4.96"
			"item_rotate"	  "y[-50 30] x[ 0 0 ]"
		}
	}

	"g3sg1"
	{
		"rule"
		{
			"model" "v_snip_g3sg1"
		}
		"config"
		{
			"camera_offset"   "58.72 35.38 -8.03"
			"camera_orient"   "-3.52 -130.47 0.00"
			"orbit_pivot"     "24.16 -5.12 -4.76"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_g3sg1"
	{
		"rule"
		{
			"model" "v_snip_g3sg1"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "18.88 40.54 3.71"
			"camera_orient"   "10.00 -92.20 0.00"
			"orbit_pivot"     "17.14 -4.67 -4.27"
			"item_rotate"	  "y[-40 20] x[ 0 0 ]"
		}
	}

	"sg553"
	{
		"rule"
		{
			"model" "v_rif_sg556"
		}
		"config"
		{
			"camera_offset"   "51.36 31.68 -7.87"
			"camera_orient"   "-3.75 -126.34 0.00"
			"orbit_pivot"     "24.18 -5.26 -4.86"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_sg553"
	{
		"rule"
		{
			"model" "v_rif_sg556"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "9.70 29.05 -3.81"
			"camera_orient"   "3.35 -76.38 0.00"
			"orbit_pivot"     "17.97 -5.07 -5.86"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"scar20"
	{
		"rule"
		{
			"model" "v_snip_scar20"
		}
		"config"
		{
			"camera_offset"   "44.85 46.66 -5.82"
			"camera_orient"   "-1.00 -112.60 0.00"
			"orbit_pivot"     "23.28 -5.16 -4.85"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_scar20"
	{
		"rule"
		{
			"model" "v_snip_scar20"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "31.30 30.88 -3.67"
			"camera_orient"   "1.75 -110.76 0.00"
			"orbit_pivot"     "17.64 -5.15 -4.85"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"ssg08"
	{
		"rule"
		{
			"model" "v_snip_ssg08"
		}
		"config"
		{
			"camera_offset"   "58.68 44.05 -1.28"
			"camera_orient"   "3.05 -124.22 0.00"
			"orbit_pivot"     "24.93 -5.57 -4.48"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_ssg08"
	{
		"rule"
		{
			"model" "v_snip_ssg08"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "12.43 24.99 1.25"
			"camera_orient"   "10.84 -75.40 0.00"
			"orbit_pivot"     "20.75 -6.94 -5.07"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"Shotguns"
	{
		"rule"
		{
			"type" "Shotgun"
		}
		"config"
		{
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.71 0.71 0.71} dir[-0.06 -0.97 -0.22] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.42 0.42 0.42} dir[-0.92 0.29 0.27] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "31.03 27.83 19.50"
			"shadow_light_orient"        "35.32 -105.43 0.00"
			"shadow_light_brightness"    "3.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       "14.7"
			"shadow_light_zfar"       "67.2"
			"shadow_light_atten_farz"       "134.5"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_offset"				    "48 38 13"
			"camera_orient"				    "23.8 -111 0"
			"orbit_pivot"					"26.86 -15.6 -12.27"
			"shadow_light_offset"		    "50.35 -36.38 81.06"
			"shadow_light_orient"		    "62.82 131.73 0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"mag7"
	{
		"rule"
		{
			"model" "v_shot_mag7"
		}
		"config"
		{
			"camera_offset"   "44.80 36.95 -8.49"
			"camera_orient"   "-1.21 -112.61 0.00"
			"orbit_pivot"     "26.65 -6.63 -7.50"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_mag7"
	{
		"rule"
		{
			"model" "v_shot_mag7"
			"sticker_preview" "1"
		}
		"config"
		{
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.43 0.43 0.43} dir[0.08 -0.99 0.10] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.42 0.42 0.42} dir[-0.92 0.29 0.27] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "18.64 23.06 9.27"
			"shadow_light_orient"        "28.90 -76.55 0.00"
			"shadow_light_brightness"    "3.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       " 3.9"
			"shadow_light_zfar"       "54.1"
			"shadow_light_atten_farz"       "108.2"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_offset"   "24.31 25.26 -14.62"
			"camera_orient"   "-13.82 -90.38 0.00"
			"orbit_pivot"     "24.10 -6.61 -6.78"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"nova"
	{
		"rule"
		{
			"model" "v_shot_nova"
		}
		"config"
		{
			"camera_offset"   "45.75 46.27 -10.29"
			"camera_orient"   "-5.35 -115.35 0.00"
			"orbit_pivot"     "21.82 -4.24 -5.05"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_nova"
	{
		"rule"
		{
			"model" "v_shot_nova"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "-1.74 11.79 7.70"
			"camera_orient"   "25.36 -37.20 0.00"
			"orbit_pivot"     "19.52 -4.35 -4.95"
			"item_rotate"	  "y[-20 20] x[ 0 0 ]"
			"camera_preset_add"   "pos[15.27 27.31 3.09] pivot[19.52 -4.35 -4.95] orient[14.13 -82.35 0.00]" // for sticker slots >1
		}
	}

	"sawedoff"
	{
		"rule"
		{
			"model" "v_shot_sawedoff"
		}
		"config"
		{
			"camera_offset"   "36.59 35.41 -9.60"
			"camera_orient"   "-7.18 -109.85 0.00"
			"orbit_pivot"     "22.15 -4.57 -4.24"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_sawedoff"
	{
		"rule"
		{
			"model" "v_shot_sawedoff"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "20.61 26.25 1.39"
			"camera_orient"   "9.55 -87.85 0.00"
			"orbit_pivot"     "21.76 -4.34 -3.75"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"xm1014"
	{
		"rule"
		{
			"model" "v_shot_xm1014"
		}
		"config"
		{
			"camera_offset"   "59.13 36.53 -5.70"
			"camera_orient"   "-0.77 -131.62 0.00"
			"orbit_pivot"     "21.85 -5.44 -4.95"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_xm1014"
	{
		"rule"
		{
			"model" "v_shot_xm1014"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "15.31 30.19 -2.10"
			"camera_orient"   "4.50 -79.60 0.00"
			"orbit_pivot"     "21.85 -5.44 -4.95"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"m249"
	{
		"rule"
		{
			"model" "v_mach_m249para"
		}
		"config"
		{
			"camera_offset"   "21.28 49.88 -10.84"
			"camera_orient"   "-5.35 -82.57 0.00"
			"orbit_pivot"     "28.63 -6.54 -5.51"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_m249"
	{
		"rule"
		{
			"model" "v_mach_m249para"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "21.32 27.17 -8.93"
			"camera_orient"   "-5.35 -82.57 0.00"
			"orbit_pivot"     "25.76 -6.93 -5.71"

			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
			"camera_preset_add"   "pos[-3.86 9.61 -4.67] pivot[25.76 -6.93 -5.71] orient[1.75 -29.17 0.00]"// for sticker slots 4
		}
	}

	"negev"
	{
		"rule"
		{
			"model" "v_mach_negev"
		}
		"config"
		{
			"camera_offset"   "62.06 30.59 -8.13"
			"camera_orient"   "-3.29 -132.31 0.00"
			"orbit_pivot"     "27.22 -7.68 -5.15"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"stickerpreview_negev"
	{
		"rule"
		{
			"model" "v_mach_negev"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"   "34.38 26.98 -3.28"
			"camera_orient"   "3.36 -102.97 0.00"
			"orbit_pivot"     "26.44 -7.50 -5.35"
			"item_rotate"	  "y[-40 30] x[ 0 0 ]"
		}
	}

	"taser"
	{
		"rule"
		{
			"model" "v_eq_taser"
		}
		"config"
		{
			"camera_offset"   "24.23 26.44 -5.52"
			"camera_orient"   "-0.92 -91.22 0.00"
			"orbit_pivot"     "23.57 -4.85 -5.02"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"Grenades"
	{
		"rule"
		{
			"type" "Grenade"
		}
		"config"
		{
			"camera_offset"   "2.86 -20.90 -0.48"
			"camera_orient"   "10.32 46.24 0.00"
			"orbit_pivot"     "18.64 -4.42 -4.63"
			"root_camera_fov"     "54.0"

			"shadow_light_offset"		    "17.86 4.92 20.73"
			"shadow_light_orient"		    "70.13 -80.33 0"
			"shadow_light_brightness"		"3.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"molotov"
	{
		"rule"
		{
			"model" "v_eq_molotov"
		}
		"config"
		{
			"camera_offset"   "-18.70 12.30 -6.85"
			"camera_orient"   "-2.98 -15.36 0.00"
			"orbit_pivot"     "30.02 -1.09 -4.23"
			"root_camera_fov"     "54.0"

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.65 0.65 0.65} dir[0.04 -0.97 -0.25] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.73 0.73 0.73} dir[0.23 0.94 -0.24] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.17 0.14 0.14} dir[-0.96 -0.14 0.23] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-0.86 -10.44 16.18"
			"shadow_light_orient"        "32.31 16.84 0.00"
			"shadow_light_brightness"    "2.25"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "54.0"
			"shadow_light_vfov"       "54.0"
			"shadow_light_znear"       "-28.4"
			"shadow_light_zfar"       "154.7"
			"shadow_light_atten_farz"       "309.4"
			"light_ambient"              "[0.13 0.13 0.13]"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"gloves"
	{
		"rule"
		{
			"model_partial" "v_glove"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"light_ambient"					"[.12 .12 .12]"
			"light_directional_add" 		"rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
			"shadow_light"					"cam_inspect_light"						// Which attachment specifies light to render shadows from
			"shadow_light_znear"			"4.0"									// Shadow light near Z
			"shadow_light_zfar"				"512.0"									// Shadow light far Z
			"shadow_light_hfov"				"54.0"									// Shadow light horizontal FOV
			"shadow_light_vfov"				"54.0"									// Shadow light vertical FOV
			"shadow_light_atten_quadratic"	"0.0"									// Shadow light quadratic attenuation
			"shadow_light_atten_linear"		"512.0"									// Shadow light linear attenuation
			"shadow_light_atten_constant"	"0.0"									// Shadow light constant attenuation
			"shadow_light_atten_farz"		"512.0"									// Shadow light far Z attenuation
			"shadow_light_brightness"		"2.0"									// Shadow light color brightness multiplier
			"shadow_light_color"			"[1 1 1]"								// Shadow light color
			"shadow_light_texture"			"effects/flashlight_inspect"					// Shadow light texture cookie
			"shadow_light_rotation"			"0 0 0"										// shadow light rotation in each axis - seconds per 360 degree revolution
			"shadow_light_flicker"			"0 0 0"					// shadow light flicker, turbulence function - "amplitude(0..1) frequency(seconds) numOctaves(0..4)"
			"camera_offset"					"0 0 0"
			"camera_orient"					"0 0 0"
	        "orbit_pivot"					"0 0 0"	
			"shadow_light_offset"			"0 0 0"
			"shadow_light_orient"			"0 0 0"
			"root_mdl"						"models/weapons/pedestal_gloves.mdl"
			"root_anim"						"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
		}
	}

	"sticker_tool"
	{
		"rule"
		{
			"type" "sticker_tool"
		}
		"config"
		{
"light_directional_clearall" "1"
"light_directional_add"      "rgb{0.47 0.47 0.47} dir[-0.47 -0.84 -0.26] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
"light_directional_add"      "rgb{0.00 0.27 0.89} dir[0.96 -0.00 -0.27] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
"light_directional_add"      "rgb{0.08 0.08 0.08} dir[-0.59 0.78 0.22] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
"shadow_light_offset"        "-0.79 7.85 12.19"
"shadow_light_orient"        "43.25 -100.16 0.00"
"shadow_light_brightness"    "1.00"
"shadow_light_color"         "[1.00 1.00 1.00]"
"shadow_light_rotation"      "[0.00 0.00 0.00]"
"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
"shadow_light_hfov"       "24.0"
"shadow_light_vfov"       "24.0"
"shadow_light_znear"       " 9.7"
"shadow_light_zfar"       "52.1"
"shadow_light_atten_farz"       "104.2"
"light_ambient"              "[0.16 0.16 0.16]"
			"root_mdl"					"models\weapons\pedestal_sticker_panorama.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
			"mergemdl_add"			"models/weapons/ct_arms_fbi.mdl"
			"camera_offset"   "1.44 1.17 -0.16"
			"camera_orient"   "-0.07 -126.05 0.00"
			"orbit_pivot"     "-3.10 -5.06 -0.15"
			"item_rotate"				    "y[0 0] x[0 0]"
		}
	}

	"patch_tool"
	{
		"rule"
		{
			"type" "patch_tool"
		}
		"config"
		{
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.68 0.68 0.82} dir[0.21 -0.91 -0.37] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.47 0.39 0.39} dir[-0.34 -0.40 -0.85] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{1.14 1.14 1.14} dir[-0.59 0.78 0.22] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.20 0.20 0.22} dir[-0.40 -0.52 -0.76] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "3.08 20.89 12.45"
			"shadow_light_orient"        "21.24 -97.18 0.00"
			"shadow_light_brightness"    "1.2"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "8"
			"shadow_light_zfar"       "32"
			"shadow_light_atten_farz"       "57.4"
			"light_ambient"              "[0.5 0.5 0.5]"
			"root_mdl"					"models\weapons\pedestal_patch.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
			"camera_offset"   "-6.24 23.49 6.45"
			"camera_orient"   "5.04 -75.63 0.00"
			"orbit_pivot"     "-0.21 -0.05 4.30"
			"root_camera_fov"     "54.0"
			"item_rotate"				    "y[-8 8] x[-1 1]"
		}
	}
	

	"Knives"
	{
		"rule"
		{
			"model_partial" "v_knife"
		}
		"config"
		{

			"root_mdl"					 "models/weapons/pedestal_knives_panorama.mdl"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.20 0.20 0.20} dir[-0.29 0.88 0.38] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{1.00 1.00 1.00} dir[0.84 0.47 -0.25] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "5.91 -14.06 11.01"
			"shadow_light_orient"        "26.06 112.25 0.00"
			"shadow_light_brightness"    "2.58"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "48.8"
			"shadow_light_vfov"       "48.8"
			"shadow_light_znear"       "13.0"
			"shadow_light_zfar"       "21.6"
			"shadow_light_atten_farz"       "43.2"
			"light_ambient"              "[0.31 0.31 0.31]"
			"camera_offset"   "2.39 -23.57 3.19"
			"camera_orient"   "-0.99 96.02 0.00"
			"orbit_pivot"     "-0.15 0.49 3.61"
			"root_camera_fov"     "54.0"
			"orbit_pivot"     "0.05 0.52 3.61"
			"root_camera_fov"     "54.0"
			"item_rotate"				    "y[-360 360] x[0 0]"
		}
	}

	"UidNameTag"
	{
		"rule"
		{
			"nametag" "1"
		}
		"config"
		{
			"weaponmergemdl_add"		"models/weapons/uid_weaponpreview.mdl"
		}
	}
	
	"small_uid_glock"
	{
		"rule"
		{
			"model" "v_pist_glock18"
			"nametag" "1"
		}
		"config"
		{
			"weaponmergemdls_clearall"		"1"
			"weaponmergemdl_add"		"models/weapons/uid_small_weaponpreview.mdl"
		}
	}
	
	"small_uid_p2000"
	{
		"rule"
		{
			"model" "v_pist_hkp2000"
			"nametag" "1"
		}
		"config"
		{
			"weaponmergemdls_clearall"		"1"
			"weaponmergemdl_add"		"models/weapons/uid_small_weaponpreview.mdl"
		}
	}
	
	"xsmall_uid_knife"
	{
		"rule"
		{
			"type" "knife"
			"nametag" "1"
		}
		"config"
		{
			"weaponmergemdls_clearall"		"1"
			"weaponmergemdl_add"		"models/weapons/uid_xsmall_weaponpreview.mdl"
		}
	}
	
	"small_uid_falchion"
	{
		"rule"
		{
			"type" "knife"
			"model" "v_knife_falchion_advanced"
			"nametag" "1"
		}
		"config"
		{
			"weaponmergemdls_clearall"		"1"
			"weaponmergemdl_add"		"models/weapons/uid_small_weaponpreview.mdl"
		}
	}
	
	"small_uid_butterfly"
	{
		"rule"
		{
			"type" "knife"
			"model" "v_knife_butterfly"
			"nametag" "1"
		}
		"config"
		{
			"weaponmergemdls_clearall"		"1"
			"weaponmergemdl_add"		"models/weapons/uid_small_weaponpreview.mdl"
		}
	}

	/////////////////////////////
	//Pickem and fantasy Trophies
	/////////////////////////////

	"inventory_items"
	{
		"rule"
		{
			"model_partial" "inventory_items"
		}
		"config"
		{
			"camera_offset"   "46.38 0.54 3.53"
			"camera_orient"   "-4.19 -179.40 0.00"
			"orbit_pivot"     "-0.60 0.05 6.98"
			"root_camera_fov" "54.0"
			"item_rotate"	  "y[-20 20] x[-4 20]"			
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-36.84 -18.90 90.92"
			"shadow_light_orient"        "65.25 29.06 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"pickem_trophy"
	{
		"rule"
		{
			"model_partial" "pickem"
		}
		"config"
		{
			"camera_offset"   "12.59 -3.95 -2.16"
			"camera_orient"   "-23.21 162.72 0.00"
			"orbit_pivot"     "-0.40 0.09 3.67"
			"root_camera_fov"     "70.0"
			"item_rotate"		"y[-20 40]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "17.53 12.91 14.56"
			"shadow_light_orient"        "26.29 -144.43 0.00"
			"shadow_light_brightness"    "3.95"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "31.6"
			"shadow_light_vfov"       "31.6"
			"shadow_light_znear"       "19.7"
			"shadow_light_zfar"       "29.2"
			"shadow_light_atten_farz"       "58.4"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"fantasy_trophy"
	{
		"rule"
		{
			"model_partial" "fantasy"
		}
		"config"
		{
			"camera_offset"   "12.59 -3.95 -2.16"
			"camera_orient"   "-23.21 162.72 0.00"
			"orbit_pivot"     "-0.40 0.09 3.67"
			"root_camera_fov"     "70.0"
			"item_rotate"		"y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "24.51 15.87 18.68"
			"shadow_light_orient"        "26.98 -147.64 0.00"
			"shadow_light_brightness"    "2.13"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "21.7"
			"shadow_light_vfov"       "21.7"
			"shadow_light_znear"       "27.4"
			"shadow_light_zfar"       "38.4"
			"shadow_light_atten_farz"       "76.8"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}
	
	"prediction"
	{
		"rule"
		{
			"model_partial" "prediction"
		}
		"config"
		{
			"camera_offset"   "9.33 32.34 -3.94"
			"camera_orient"   "-25.51 -105.15 0.00"
			"orbit_pivot"     "0.02 -2.07 13.07"
			"root_camera_fov"     "70.0"
			"item_rotate"	  "y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{5.93 5.93 5.93} dir[-0.78 0.29 -0.56] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[-0.02 -0.85 -0.52] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.50 0.52 0.55} dir[0.36 -0.08 0.93] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.29 0.29 0.29} dir[0.48 -0.54 -0.69] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-7.76 36.18 46.13"
			"shadow_light_orient"        "40.72 -78.66 0.00"
			"shadow_light_brightness"    "3.07"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "32.7"
			"shadow_light_vfov"       "32.7"
			"shadow_light_znear"       "27.6"
			"shadow_light_zfar"       "70.1"
			"shadow_light_atten_farz"       "140.2"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"prediction_plaque"
	{
		"rule"
		{
			"model_partial" "prediction_plaque"
		}
		"config"
		{
			"camera_offset"   "9.05 31.30 -6.20"
			"camera_orient"   "-25.51 -105.15 0.00"
			"orbit_pivot"     "-0.26 -3.11 10.81"
			"root_camera_fov"     "70.0"
			"item_rotate"	  "y[20 -20] z[-0 0]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{5.93 5.93 5.93} dir[-0.78 0.29 -0.56] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[-0.02 -0.85 -0.52] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.50 0.52 0.55} dir[0.36 -0.08 0.93] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.29 0.29 0.29} dir[0.48 -0.54 -0.69] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-7.76 36.18 46.13"
			"shadow_light_orient"        "40.72 -78.66 0.00"
			"shadow_light_brightness"    "3.07"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "32.7"
			"shadow_light_vfov"       "32.7"
			"shadow_light_znear"       "27.6"
			"shadow_light_zfar"       "70.1"
			"shadow_light_atten_farz"       "140.2"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"katowice2015_trophy"
	{
		"rule"
		{
			"model_partial" "katowice2015_trophy_"
		}
		"config"
		{
			"camera_offset"   "30.52 -8.57 4.35"
			"camera_orient"   "-5.34 165.24 0.00"
			"orbit_pivot"     "-0.78 -0.33 7.37"
			"root_camera_fov"     "70.0"
			"item_rotate"		"y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "43.35 31.68 43.95"
			"shadow_light_orient"        "32.93 -144.61 0.00"
			"shadow_light_brightness"    "2.80"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}


	"kat_2015"
	{
		"rule"
		{
			"model_partial" "inventory_items/kat_2015"
		}
		"config"
		{
			"camera_offset"   "35.65 -12.29 0.44"
			"camera_orient"   "-14.51 161.57 0.00"
			"orbit_pivot"     "0.48 -0.57 10.03"
			"root_camera_fov"     "70.0"
			"item_rotate"		"y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{2.09 2.09 2.09} dir[-0.79 -0.48 0.38] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[-0.87 -0.30 -0.38] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.95 0.22 -0.21] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[-0.16 -0.59 0.79] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "35.64 36.57 25.34"
			"shadow_light_orient"        "16.66 -133.43 0.00"
			"shadow_light_brightness"    "5.77"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "48.4"
			"shadow_light_vfov"       "48.4"
			"shadow_light_znear"       "37.6"
			"shadow_light_zfar"       "68.8"
			"shadow_light_atten_farz"       "137.7"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"katowice_trophy"
	{
		"rule"
		{
			"model_partial" "katowice_trophy_"
		}
		"config"
		{
			"camera_offset"   "12.03 -2.97 1.93"
			"camera_orient"   "-5.34 165.24 0.00"
			"orbit_pivot"     "-0.98 0.45 3.19"
			"root_camera_fov"     "70.0"
			"item_rotate"		"y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "43.35 31.68 43.95"
			"shadow_light_orient"        "32.93 -144.61 0.00"
			"shadow_light_brightness"    "2.80"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"trophy_majors"
	{
		"rule"
		{
			"model_partial" "inventory_items/trophy_majors"
		}
		"config"
		{
			"camera_offset"   "81.82 0.64 7.55"
			"camera_orient"   "-0.75 -179.36 0.00"
			"orbit_pivot"     "0.14 -0.27 8.62"
			"root_camera_fov"     "34.0"
			"item_rotate"		"y[-360 360]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.49 0.49 0.49} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{1.75 1.97 2.13} dir[0.70 -0.48 -0.53] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.54 0.48 0.70] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "43.35 31.68 43.95"
			"shadow_light_orient"        "32.93 -144.61 0.00"
			"shadow_light_brightness"    "2.69"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
			
			// used in tournament journal
			"camera_preset_add"   "pos[-24.55 0.72 16.55] pivot[-0.30 -0.06 15.22] orient[3.14 -1.83 0.00] fov[20.0]"

		}
	}

	"service_medal"
	{
		"rule"
		{
			"model_partial" "service_medal"
		}
		"config"
		{
			"camera_offset"   "0.85 -0.01 26.15"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "-0.38 0.01 0.47"
			"root_camera_fov"     "54.0"
			"item_orient"		"-10 0 0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}


	"operation7_medals"
	{
		"rule"
		{
			"model_partial" "inventory_items/operation_7"
		}
		"config"
		{
			"camera_offset"   "9.04 -0.01 18.15"
			"camera_orient"   "77.16 179.69 0.00"
			"orbit_pivot"     "4.70 0.01 -0.85"
			"root_camera_fov"     "60.0"
			"item_orient"		"-5 0 0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.38 0.38 0.38} dir[-0.03 -0.48 -0.87] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.56 0.63 0.69} dir[-0.25 -0.44 -0.86] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.33 0.35 0.37} dir[-0.31 -0.74 -0.60] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.08 0.08 0.08} dir[-0.68 -0.44 0.59] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-0.20 -4.77 13.26"
			"shadow_light_orient"        "64.33 43.68 0.00"
			"shadow_light_brightness"    "4.96"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "46.6"
			"shadow_light_vfov"       "46.6"
			"shadow_light_znear"       "10.3"
			"shadow_light_zfar"       "19.2"
			"shadow_light_atten_farz"       "38.3"
			"light_ambient"              "[0.41 0.41 0.41]"
			"root_mdl"					 ""
		}
	}


	"operation8_medals"
	{
		"rule"
		{
			"model_partial" "inventory_items/operation_8"
		}
		"config"
		{
			"camera_offset"   "18.76 0.38 -0.18"
			"camera_orient"   "-0.53 -178.71 0.00"
			"orbit_pivot"     "-0.03 -0.04 -0.01"
			"root_camera_fov"     "60.0"
			"item_orient"		"170 0 0"
			"item_rotate"		"y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.38 0.38 0.38} dir[-0.98 0.18 0.02] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.41 0.46 0.50} dir[-0.92 0.38 -0.10] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.33 0.35 0.37} dir[-0.81 -0.52 -0.27] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.08 0.08 0.08} dir[-0.67 -0.50 0.54] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "46.80 14.12 16.57"
			"shadow_light_orient"        "18.72 -163.18 0.00"
			"shadow_light_brightness"    "4.96"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "8.1"
			"shadow_light_vfov"       "8.1"
			"shadow_light_znear"       "47.5"
			"shadow_light_zfar"       "56.4"
			"shadow_light_atten_farz"       "112.7"
			"light_ambient"              "[0.29 0.29 0.29]"
			"root_mdl"					 ""
		}
	}

	"bloodhound"
	{
		"rule"
		{
			"model_partial" "inventory_items/bloodhound_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.17 0.17 0.17} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.17 0.19 0.21} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.28 0.29 0.31} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[0.95 0.95 0.95]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.20 0.20 0.20]"
			"root_mdl"					 ""

		}
	}

	"vanguard"
	{
		"rule"
		{
			"model_partial" "inventory_items/vanguard_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10 0 0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"breakout"
	{
		"rule"
		{
			"model_partial" "inventory_items/breakout_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"5yr"
	{
		"rule"
		{
			"model_partial" "inventory_items/5_year_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}
	
	"10yr"
	{
		"rule"
		{
			"model_partial" "inventory_items/10_year_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"bravo"
	{
		"rule"
		{
			"model_partial" "inventory_items/bravo_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "2.8"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"col2015_trophy"
	{
		"rule"
		{
			"model_partial" "col2015_trophy"
		}
		"config"
		{
			"camera_offset"   "12.18 -3.22 1.91"
			"camera_orient"   "-5.34 165.24 0.00"
			"orbit_pivot"     "-1.03 0.26 3.19"
			"root_camera_fov"     "70.0"
			"item_rotate"		"y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "43.35 31.68 43.95"
			"shadow_light_orient"        "32.93 -144.61 0.00"
			"shadow_light_brightness"    "2.80"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"cologne_trophy"
	{
		"rule"
		{
			"model_partial" "cologne_trophy"
		}
		"config"
		{
			"camera_offset"   "43.84 -0.39 4.45"
			"camera_orient"   "-4.42 179.68 0.00"
			"orbit_pivot"     "-0.53 -0.15 7.88"
			"root_camera_fov"     "54.0"
			"item_rotate"	  "y[-20 20]"			
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-36.84 -18.90 90.92"
			"shadow_light_orient"        "65.25 29.06 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"dhw"
	{
		"rule"
		{
			"model_partial" "dhw_"
		}
		"config"
		{
			"camera_offset"   "16.07 -4.61 -1.74"
			"camera_orient"   "-16.11 162.72 0.00"
			"orbit_pivot"     "-0.91 0.67 3.40"
			"root_camera_fov"     "68.2"
			"item_rotate"	  "y[-20 20]"	
			"item_orient"	   "0.0 0.0 0.0"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.65 0.65 0.65} dir[-0.67 0.49 0.56] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{5.13 5.78 6.22} dir[0.96 -0.27 0.02] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "20.55 19.53 25.62"
			"shadow_light_orient"        "37.75 -138.70 0.00"
			"shadow_light_brightness"    "4.56"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "25.3"
			"shadow_light_vfov"       "25.3"
			"shadow_light_znear"       "27.1"
			"shadow_light_zfar"       "44.4"
			"shadow_light_atten_farz"       "88.7"
			"light_ambient"              "[0.05 0.05 0.05]"
			"root_mdl"					 ""
		}
	}

	"dhw_pickem"
	{
		"rule"
		{
			"model_partial" "dhw_2014_pickem"
		}
		"config"
		{
			"camera_offset"   "15.91 -5.30 -1.55"
			"camera_orient"   "-16.11 162.72 0.00"
			"orbit_pivot"     "-1.07 -0.01 3.59"
			"root_camera_fov"     "68.2"
			"item_rotate"	  "y[-20 20]"	
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.65 0.65 0.65} dir[-0.67 0.49 0.56] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{5.13 5.78 6.22} dir[0.96 -0.27 0.02] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "20.55 19.53 25.62"
			"shadow_light_orient"        "37.75 -138.70 0.00"
			"shadow_light_brightness"    "4.56"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "25.3"
			"shadow_light_vfov"       "25.3"
			"shadow_light_znear"       "27.1"
			"shadow_light_zfar"       "44.4"
			"shadow_light_atten_farz"       "88.7"
			"light_ambient"              "[0.05 0.05 0.05]"
			"root_mdl"					 ""
		}
	}

	"dreamhack_trophy"
	{
		"rule"
		{
			"model_partial" "dreamhack_trophy"
		}
		"config"
		{
			"camera_offset"   "19.24 0.12 1.93"
			"camera_orient"   "-6.71 179.91 0.00"
			"orbit_pivot"     "-0.82 0.15 4.29"
			"root_camera_fov"     "64.6"
			"item_rotate"	  "y[-20 20]"			
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{1.40 1.40 1.40} dir[-0.89 -0.38 -0.24] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{5.55 6.23 6.74} dir[-0.30 0.69 0.65] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[0.60 -0.71 -0.38] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-13.89 -25.99 4.61"
			"shadow_light_orient"        "0.62 63.44 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[0.57 0.57 0.57]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "60.1"
			"shadow_light_zfar"       "75.7"
			"shadow_light_atten_farz"       "151.3"
			"light_ambient"              "[0.22 0.22 0.22]"
			"root_mdl"					 ""
		}
	}

	"payback"
	{
		"rule"
		{
			"model_partial" "inventory_items/payback_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10 0 0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			"root_mdl"					 ""
		}
	}

	"phoenix"
	{
		"rule"
		{
			"model_partial" "inventory_items/phoenix_"
		}
		"config"
		{
			"camera_offset"   "0.98 -0.01 18.33"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
			"root_camera_fov"     "60.0"
			"item_orient"		"-10 0 0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.50 0.56 0.61} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.43 0.46 0.48} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.12 0.12 0.12} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[0.94 0.94 0.94]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.04 0.04 0.04]"
			"root_mdl"					 ""
		}
	}

	"collectible_pin"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin"
		}
		"config"
		{
			"camera_offset"   "2.26 -0.03 22.18"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "1.22 -0.01 0.40"
			"root_camera_fov"     "45.0"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.60 0.68 0.73} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.19 0.24 0.24} dir[0.28 0.52 -0.80] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.18 0.18 0.18} dir[-0.06 -0.23 -0.97] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-7.92 -5.79 24.91"
			"shadow_light_orient"        "67.77 35.48 0.00"
			"shadow_light_brightness"    "1.77"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "54.8"
			"shadow_light_vfov"       "54.8"
			"shadow_light_znear"       "22.3"
			"shadow_light_zfar"       "30.9"
			"shadow_light_atten_farz"       "61.8"
			"light_ambient"              "[0.09 0.09 0.09]"
			"root_mdl"					 ""
		}
	}

	"collectible_pin_aces_high"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_aces_high"
		}
		"config"
		{
			"camera_offset"   "0.71 -0.60 25.46"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "-0.49 -0.57 0.48"
		}
	}

	"collectible_pin_baggage"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_baggage"
		}
		"config"
		{
			"camera_offset"   "1.61 -0.02 23.11"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 0.01 0.43"
		}
	}

	"collectible_pin_bloodhound"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_bloodhound"
		}
		"config"
		{
			"camera_offset"   "1.63 -0.12 23.51"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 -0.10 0.44"
		}
	}

	"collectible_pin_bravo"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_bravo"
		}
		"config"
		{
			"camera_offset"   "1.91 -0.03 20.99"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.92 -0.01 0.42"
		}
	}	

	"collectible_pin_brigadier_general"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_brigadier_general"
		}
		"config"
		{
			"camera_offset"   "1.01 -0.01 23.24"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "-0.08 0.02 0.46"
		}
	}

	"collectible_pin_canals"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_canals"
		}
		"config"
		{
			"camera_offset"   "2.06 -0.13 22.19"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "1.02 -0.11 0.41"
		}
	}

	"collectible_pin_chroma"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_chroma"
		}
		"config"
		{
			"camera_offset"   "2.18 -0.03 24.59"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "1.02 -0.01 0.41"
		}
	}

	"collectible_pin_cobble"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_cobble"
		}
		"config"
		{
			"camera_offset"   "1.98 -0.03 22.49"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.92 -0.00 0.41"
			"shadow_light_offset"        "6.78 8.69 14.02"
			"shadow_light_orient"        "52.41 -123.98 0.00"
			"shadow_light_brightness"    "1.88"
		}
	}	

	"collectible_pin_death"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_death"
		}
		"config"
		{
			"camera_offset"   "1.60 0.08 22.91"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 0.10 0.43"
		}
	}

	"collectible_pin_dust2"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_dust2"
		}
		"config"
		{
			"camera_offset"   "1.67 -0.02 24.31"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 0.01 0.43"
			"shadow_light_offset"        "-18.22 -1.18 16.99"
			"shadow_light_orient"        "41.41 3.63 0.00"
			"shadow_light_brightness"    "1.24"
		}
	}

	"collectible_pin_easy_peasy"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_easy_peasy"
		}
		"config"
		{
			"camera_offset"   "1.20 -0.01 22.93"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.12 0.01 0.45"
		}
	}	

	"collectible_pin_guardian"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_guardian"
		}
		"config"
		{
			"camera_offset"   "1.94 -0.03 25.90"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.72 -0.00 0.42"
		}
	}

	"collectible_pin_howl"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_howl"
		}
		"config"
		{
			"camera_offset"   "1.92 -0.03 25.50"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.72 -0.00 0.42"
		}
	}

	"collectible_pin_hydra"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_hydra"
		}
		"config"
		{
			"camera_offset"   "1.83 -0.02 25.70"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.62 0.00 0.43"
		}
	}

	"collectible_pin_inferno"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_inferno"
		}
		"config"
		{
			"camera_offset"   "1.81 0.08 25.21"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.62 0.10 0.43"
		}
	}

	"collectible_pin_inferno_2"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_inferno_2"
		}
		"config"
		{
			"camera_offset"   "1.21 0.09 25.24"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.02 0.11 0.46"
		}
	}

	"collectible_pin_italy"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_italy"
		}
		"config"
		{
			"camera_offset"   "1.71 -0.03 25.22"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 -0.00 0.44"
		}
	}

	"collectible_pin_militia"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_militia"
		}
		"config"
		{
			"camera_offset"   "1.51 -0.02 25.23"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.32 0.00 0.45"
		}
	}

	"collectible_pin_mirage"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_mirage"
		}
		"config"
		{
			"camera_offset"   "2.18 -0.03 24.59"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "1.02 -0.01 0.41"
		}
	}	

	"collectible_pin_nuke"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_nuke"
		}
		"config"
		{
			"camera_offset"   "1.88 0.07 24.60"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.72 0.10 0.42"
		}
	}	

	"collectible_pin_office"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_office"
		}
		"config"
		{
			"camera_offset"   "1.88 -0.02 26.70"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.62 0.00 0.43"
		}
	}	

	"collectible_pin_overpass"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_overpass"
		}
		"config"
		{
			"camera_offset"   "1.67 -0.02 24.31"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 0.01 0.43"
		}
	}

	"collectible_pin_phoenix"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_phoenix"
		}
		"config"
		{
			"camera_offset"   "2.05 -0.02 23.99"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.92 0.00 0.41"
		}
	}

	"collectible_pin_tactics"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_tactics"
		}
		"config"
		{
			"camera_offset"   "1.77 -0.02 22.20"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.72 0.00 0.42"
		}
	}	

	"collectible_pin_train"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_train"
		}
		"config"
		{
			"camera_offset"   "1.79 0.08 26.81"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 0.11 0.43"
		}
	}	

	"collectible_pin_valeria"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_valeria"
		}
		"config"
		{
			"camera_offset"   "1.78 -0.03 24.61"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.62 -0.00 0.43"
		}
	}

	"collectible_pin_victory"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_victory"
		}
		"config"
		{
			"camera_offset"   "1.57 -0.02 22.21"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.52 0.01 0.43"
		}
	}

	"collectible_pin_welcome"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_welcome"
		}
		"config"
		{
			"camera_offset"   "2.23 -0.14 23.69"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "1.12 -0.11 0.41"
		}
	}

	"collectible_pin_wildfire"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin_wildfire"
		}
		"config"
		{
			"camera_offset"   "1.42 0.09 23.32"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.32 0.11 0.44"
		}
	}

	"maptoken"
	{
		"rule"
		{
			"model_partial" "inventory_items/maptoken_"
		}
		"config"
		{
			"camera_offset"   "1.23 -0.01 21.43"
			"camera_orient"   "87.25 178.77 0.00"
			"orbit_pivot"     "0.22 0.01 0.45"
			"root_camera_fov"     "60.0"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.04 0.05 0.05} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.03 0.03 0.03} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.00 0.00 0.00]"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"root_mdl"					 ""
		}
	}

	"mlg"
	{
		"rule"
		{
			"model_partial" "inventory_items/mlg_"
		}
		"config"
		{
			"camera_offset"   "12.01 -5.86 -1.72"
			"camera_orient"   "-19.08 154.93 0.00"
			"orbit_pivot"     "-0.66 0.06 3.12"
			"root_camera_fov"     "70.0"
			"item_rotate"		"y[-20 20]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.01 0.01 0.01} dir[-0.41 0.30 0.86] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "17.12 3.60 10.76"
			"shadow_light_orient"        "22.85 -168.73 0.00"
			"shadow_light_brightness"    "1.70"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.25 0.25 0.25]"
			"root_mdl"					 ""
		}
	}

	"coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/prime_"
		}
		"config"
		{
			"camera_offset"   "0.28 -0.19 17.45"
			"camera_orient"   "89.77 179.92 0.00"
			"orbit_pivot"     "0.21 -0.19 0.45"
			"root_camera_fov"     "60.0"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.04 0.05 0.05} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.03 0.03 0.03} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.00 0.00 0.00]"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"root_mdl"					 ""
		}
	}

	"katowice_pickem_2019"
	{
		"rule"
		{
			"model_partial" "inventory_items/katowice_pickem_2019"
		}
		"config"
		{
			"camera_offset"   "0.21 0.02 13.70"
			"camera_orient"   "90.00 178.76 0.00"
			"orbit_pivot"     "0.21 0.02 0.00"
			"root_camera_fov"     "60"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.04 0.05 0.05} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.03 0.03 0.03} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.00 0.00 0.00]"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"root_mdl"					 ""

			"camera_preset_add"   "pos[0.22 0.01 13.05] pivot[0.22 0.01 0.45] orient[90.00 179.46 0.00] fov[30.5]"
		}
	}

	
	"starladder_pickem_2019"
	{
		"rule"
		{
			"model_partial" "inventory_items/starladder_pickem_2019"
		}
		"config"
		{
			"camera_offset"   "0.21 0.02 13.70"
			"camera_orient"   "90.00 178.76 0.00"
			"orbit_pivot"     "0.21 0.02 0.00"
			"root_camera_fov"     "60"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.04 0.05 0.05} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.03 0.03 0.03} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-29.75 20.14 42.52"
			"shadow_light_orient"        "50.35 -32.59 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.00 0.00 0.00]"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"z[20 -20]"
			"root_mdl"					 ""

			"camera_preset_add"   "pos[0.22 0.01 13.05] pivot[0.22 0.01 0.45] orient[90.00 179.46 0.00] fov[30.5]"
		}
	}

	"op09"
	{
		"rule"
		{
			"model_partial" "inventory_items/operation_9"
		}
		"config"
		{
			"camera_offset"   "24.61 -0.83 11.24"
			"camera_orient"   "15.06 178.08 0.00"
			"orbit_pivot"     "1.15 -0.04 4.92"
			"root_camera_fov"     "60"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.62 0.64 0.83} dir[-0.44 -0.56 -0.70] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{4.35 0.00 0.43} dir[0.21 0.95 -0.22] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "13.82 10.32 20.07"
			"shadow_light_orient"        "42.79 -140.72 0.00"
			"shadow_light_brightness"    "3.86"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "12.6"
			"shadow_light_zfar"       "31.6"
			"shadow_light_atten_farz"       "63.2"
			"light_ambient"              "[0.03 0.03 0.03]"
			"item_orient"		"-10.0 0.0 0.0"
			"item_rotate"		"y[-20 20]"
			"root_mdl"					 ""
		}
	}

	/////////////////////////////
	//spray
	/////////////////////////////
	"spray_tool"
	{
		"rule"
		{
			"type" "spray_tool"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"light_ambient"				"[.05 .05 .05]"
			"light_directional_add" 	"rgb[15 34 62] dir[0 -1 -0.2]"
			"root_mdl"					"models/sprays/pedestal_sprays.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.06 0.13 0.24} dir[0.00 -1.00 -0.20] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.06 0.13 0.24} dir[0.00 -1.00 -0.20] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.06 0.13 0.24} dir[0.00 -1.00 -0.20] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{1.00 1.00 1.00} dir[0.31 -0.92 0.25] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "57.08 -78.06 91.71"
			"shadow_light_orient"        "13.22 126.92 0.00"
			"shadow_light_brightness"    "2"
			"shadow_light_color"         "[1.00 0.97 0.77]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "58.6"
			"shadow_light_zfar"       "149.1"
			"shadow_light_atten_farz"       "298.2"
			"light_ambient"              "[0.05 0.05 0.05]"
			"item_rotate"				 "x[-0 0] y[-0 0]"
		}
	}

	"pedestal_character_panorama"
	{
		"rule"
		{
			"model_path_partial" "custom_player/legacy/"
		}
		"config"
		{
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.21 0.21 0.22} dir[-0.50 0.80 0.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.07 0.10 0.13} dir[0.70 -0.80 0.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "46.28 -8.61 143.56"
			"shadow_light_orient"        "60.89 164.89 0.00"
			"shadow_light_brightness"    "5.41"
			"shadow_light_color"         "[0.81 0.92 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_znear"       	"4.0"
			"shadow_light_zfar"       	"256.0"
			"shadow_light_atten_farz"   "512.0"
			"light_ambient"             "[0.19 0.22 0.29]"
			"root_mdl"					"models/player/custom_player/uiplayer/animset_uiplayer.mdl"
			"weapon_anim"				"default"
			"weapon_anim_loop"			"default"
			"root_camera_fov"			"20.0"									// Camera will use the specified FOV
			"camera_offset"   "142.72 141.81 53.25"
			"camera_orient"   "4.13 -136.92 0.00"
			"orbit_pivot_bone"     "camera_target"
			//"orbit_pivot"     "-1.56 6.88 39.00"
			//"shadow_light_rotation"		"0 0 0"
			//"shadow_light_flicker"		"2 0 1 1"
			"item_rotate"				"y[-360 360]"

			// Presets start here when called from JS thier index starts at 1
			"camera_preset_add"   "pos[305.97 -6.14 64.35] pivot<camera_target> orient[4.81 178.85 0.00]" // inspect weapons -> character preview

			"camera_preset_add"   "" // 2 UNUSED - AVAILABLE
			"camera_preset_add"   "" // 3 UNUSED - AVAILABLE
			"camera_preset_add"   "" // 4 UNUSED - AVAILABLE
	
			"camera_preset_add"   "pos[238.40 -33.78 36.46] pivot<camera_target> orient[-0.91 171.74 0.00] fov[20.0]" // 	5 character loadout		 	
			"camera_preset_add"   "pos[102.04 -11.88 54.78] pivot<camera_target> orient[-3.66 172.43 0.00] fov[20.0]" // 	6 character loadout zoom

			"camera_preset_add"   "" // 7 UNUSED - AVAILABLE

			"camera_preset_add"   "pos[152.35 -18.31 73.99] pivot<camera_target> orient[2.53 172.66 0.00] fov[20.0]" // 	8 item acknowledge

			// UNUSED - AVAILABLE
			"camera_preset_add"   "" // 9 UNUSED - AVAILABLE

			//10 
			// default characterlineup.js camera preset
			//
			"camera_preset_add"   "pos[270 0 55] pivot<camera_target> orient[-0.23 180 0.00] fov[20.0]" / 10

			// 11-15 are receding camera positions. e.g. A 'V' formation would be 15-14-13-12-11-10-11-12-13-14-15

			"camera_preset_add"   "pos[290 0 55] pivot<camera_target> orient[-0.23 180 0.00] fov[20.0]" // 11
			"camera_preset_add"   "pos[310 0 55] pivot<camera_target> orient[-0.23 180 0.00] fov[20.0]" // 12
			"camera_preset_add"   "pos[330 0 55] pivot<camera_target> orient[-0.23 180 0.00] fov[20.0]" // 13
			"camera_preset_add"   "pos[350 0 55] pivot<camera_target> orient[-0.23 180 0.00] fov[20.0]" // 14
			"camera_preset_add"   "pos[370 0 55] pivot<camera_target> orient[-0.23 180 0.00] fov[20.0]" // 15

			//inspect
			"camera_preset_add"   "pos[382.11 -54.77 28.43] pivot[-0.74 0.81 42.31] orient[-2.06 171.74 0.00] fov[20.0]" // 16 inspect unzoomed
			"camera_preset_add"   "pos[124.97 -16.83 62.49] pivot[0.13 1.29 64.50]  orient[-0.91 171.74 0.00] fov[20.0]" // 17 inspect zoomed

			// buymenu
			"camera_preset_add"   "pos[226.06 73.87 64.82] pivot[-1.00 0.66 53.36] orient[2.75 -162.13 0.00] fov[20.0]"// 18 buymenu

			// operation item store
			"camera_preset_add"   "pos[184.68 -48.68 53.68] pivot[-0.00 -0.85 69.06] orient[-4.61 165.48 0.00] fov[20.0]" //19 Position
			"camera_preset_add"   "pos[104.82 -19.56 63.48] pivot[0.08 -0.15 67.89] orient[-2.37 169.50 0.00] fov[20.0]" //20 Position for smaller tiles

			// operation item store inspect hover
			"camera_preset_add"   "pos[97.52 -14.58 108.28] pivot[-0.12 -0.80 67.50] orient[22.47 171.97 0.00] fov[20.0]" //21 Position 
		}

	}

	"StatTrak"
	{
		"rule"
		{
			"stattrak" "1"
		}
		"config"
		{
			"weaponmergemdl_add"		"models/weapons/stattrack_weaponpreview.mdl"		// Merge the actual indicator to the gun
		}
	}

		"StatTrak_knives"
	{
		"rule"
		{
			"stattrak" "1"
			"type" "Knife"
		}
		"config"
		{
			"mergemdls_clearall"			"1"
			"weaponmergemdl_clear"	"models/weapons/stattrack_weaponpreview.mdl"
			"weaponmergemdl_add"	"models/weapons/stattrack_cut_inspect_xsmall.mdl"
		}
	}
	
	"StatTrak_butterfly"
	{
		"rule"
		{
			"stattrak" "1"
			"model" "v_knife_butterfly"
		}
		"config"
		{
			"weaponmergemdls_clear" "models/weapons/stattrack_cut_inspect_xsmall.mdl"
			"weaponmergemdls_add" "models/weapons/stattrack_cut_inspect_small.mdl"
		}
	}
	
	"StatTrak_falchion"
	{
		"rule"
		{
			"stattrak" "1"
			"model" "v_knife_falchion_advanced"
		}
		"config"
		{
			"weaponmergemdls_clear" "models/weapons/stattrack_cut_inspect_xsmall.mdl"
			"weaponmergemdls_add" "models/weapons/stattrack_cut_inspect_small.mdl"
		}
	}	

	
	"uid"
	{
		"rule"
		{
			"model_partial" "uid"
		}
		"config"
		{	
			"camera_offset"   "-3.03 2.90 0.40"
			"camera_orient"   "5.50 -43.78 0.00"
			"orbit_pivot"     "0.00 0.00 0.00"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.75 0.75 0.77} dir[0.00 -0.30 -1.00]  rot[-7.1 24.8 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.28 0.44 0.55} dir[0.00 -0.20 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-7.36 21.15 2.16"
			"shadow_light_orient"        "5.50 -70.82 0.00"
			"shadow_light_brightness"    "7.19"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"

			// Presets start here when called from JS thier index starts at 1
			"camera_preset_add"   "pos[-3.03 2.90 0.40] pivot[0.00 0.00 0.00] orient[5.50 -43.78 0.00]" // start po
			"camera_preset_add"   "pos[0.00 3.21 0.01] pivot[0.00 0.00 0.00] orient[0.23 -90.08 0.00]" // end pos
		}
	}

	"c4"
	{
		"rule"
		{
			"model_partial" "ied"
		}
		"config"
		{	
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.15 0.23 0.30} dir[0.97 -0.18 0.16] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[0.08 -1.00 -0.02] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-1.35 -15.31 4.15"
			"shadow_light_orient"        "20.33 26.07 0.00"
			"shadow_light_brightness"    "1.88"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "54.0"
			"shadow_light_vfov"       "54.0"
			"shadow_light_znear"       "11.9"
			"shadow_light_zfar"       "41.7"
			"shadow_light_atten_farz"       "83.5"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_offset"   "-11.46 -5.02 -2.34"
			"camera_orient"   "7.79 5.50 0.00"
			"orbit_pivot"     "27.30 -1.29 -7.67"
			"root_camera_fov"     "45.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"defuser"
	{
		"rule"
		{
			"model_partial" "defuser"
		}
		"config"
		{	
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[-0.76 -0.16 -0.64] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[0.43 0.71 -0.56] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.31 0.33 0.34} dir[-0.52 -0.49 0.70] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[-0.34 -0.11 -0.93] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-26.95 7.51 11.14"
			"shadow_light_orient"        "20.35 -12.67 0.00"
			"shadow_light_brightness"    "1.88"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "54.0"
			"shadow_light_vfov"       "54.0"
			"shadow_light_znear"       "11.9"
			"shadow_light_zfar"       "41.7"
			"shadow_light_atten_farz"       "83.4"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_offset"   "-49.89 3.89 13.64"
			"camera_orient"   "9.39 -2.80 0.00"
			"orbit_pivot"     "0.23 -0.03 0.37"
			"root_camera_fov"     "45.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	
	"assault_suit"
	{
		"rule"
		{
			"model_partial" "assault_suit"
		}
		"config"
		{	
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[-0.78 0.47 -0.42] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[0.08 -1.00 -0.02] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "60.06 4.06 35.34"
			"shadow_light_orient"        "32.71 -166.63 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       " 0.2"
			"shadow_light_zfar"       "98.0"
			"shadow_light_atten_farz"       "196.0"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_offset"   "158.05 136.38 8.37"
			"camera_orient"   "2.75 -138.89 0.00"
			"orbit_pivot"     "-1.72 -3.05 -1.81"
			"root_camera_fov"     "45.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}
	
	"helmet"
	{
		"rule"
		{
			"model_partial" "helmet"
		}
		"config"
		{	
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.15 0.23 0.30} dir[0.97 -0.18 0.16] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[0.08 -1.00 -0.02] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-1.35 -15.31 4.15"
			"shadow_light_orient"        "20.33 26.07 0.00"
			"shadow_light_brightness"    "1.88"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "54.0"
			"shadow_light_vfov"       "54.0"
			"shadow_light_znear"       "11.9"
			"shadow_light_zfar"       "41.7"
			"shadow_light_atten_farz"       "83.5"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_offset"   "132.78 107.46 10.83"
			"camera_orient"   "4.12 -141.18 0.00"
			"orbit_pivot"     "-2.67 -1.52 -1.71"
			"root_camera_fov"     "45.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}
	
	"armor"
	{
		"rule"
		{
			"model_partial" "armor"
		}
		"config"
		{	
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[-0.78 0.47 -0.42] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.85 0.85 0.85} dir[0.08 -1.00 -0.02] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "60.06 4.06 35.34"
			"shadow_light_orient"        "32.71 -166.63 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       " 0.2"
			"shadow_light_zfar"       "98.0"
			"shadow_light_atten_farz"       "196.0"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_offset"   "158.05 136.38 8.37"
			"camera_orient"   "2.75 -138.89 0.00"
			"orbit_pivot"     "-1.72 -3.05 -1.81"
			"root_camera_fov"     "45.0"
			"item_rotate"	  "y[-360 360] x[ 0 0 ]"
		}
	}

	"weapon_case"
	{
		"rule"
		{
			//csgo/trunk/game/csgo/models/props/crates/csgo_drop_crate_armsdeal1.mdl
			"model_partial" "crate_"
		}
		"config"
		{

			"root_mdl"					    ""		                                // Which pedestal model to load, weapon model is merged to the pedestal, null => weapon model is the scene
			"root_anim"					    ""                          			// Which activity to play on the pedestal
			"root_anim_loop"			    ""				                        // Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"				    ""						                // Which activity to play on the weapon
			"weapon_anim_loop"			    ""										// Which pedestal model to load, weapon model is merged to the pedestal
			"root_camera"				"cam_inspect"								// Which attachment specifies camera location
			"root_camera_fov"			"54.0"									// Camera will use the specified FOV
			"camera_offset"   "-51.44 99.98 42.06"
			"camera_orient"   "16.04 -62.80 0.00"
			"orbit_pivot"     "0.67 -1.39 9.29"
			"item_rotate" "y[-20 60]" //- x horizontal, z vertical

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.89 0.89 0.89} dir[-0.34 -0.90 -0.29] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-37.95 46.33 54.77"
			"shadow_light_orient"        "35.78 -51.35 0.00"
			"shadow_light_brightness"    "2.59"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       "42.3"
			"shadow_light_zfar"       "115.7"
			"shadow_light_atten_farz"       "231.4"
			"light_ambient"              "[0.06 0.06 0.06]"

			"camera_preset_add"   "pos[-79.35 181.14 49.98] pivot[-0.71 4.45 -10.68] orient[17.42 -66.01 0.00] fov[54.0]" // zoomed out.
			"camera_preset_add"   "pos[-85.12 165.55 63.25] pivot[0.67 -1.39 9.29] orient[16.04 -62.80 0.00] fov[54.0]" // opening scroll
			"camera_preset_add"   "pos[-53.09 121.06 39.72] pivot[2.30 -4.75 22.04] orient[7.33 -66.24 0.00] fov[54.0]" // open anim
		}
	}
	
	"weapon_case"
	{
		"rule"
		{
			"model_partial" "patch_envelope"
		}
		"config"
		{

			"root_mdl"					    ""		                                // Which pedestal model to load, weapon model is merged to the pedestal, null => weapon model is the scene
			"root_anim"					    ""                          			// Which activity to play on the pedestal
			"root_anim_loop"			    ""				                        // Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"				    ""						                // Which activity to play on the weapon
			"weapon_anim_loop"			    ""										// Which pedestal model to load, weapon model is merged to the pedestal
			"root_camera"				"cam_inspect"								// Which attachment specifies camera location
			"camera_offset"   "8.29 29.57 71.52"
			"camera_orient"   "66.92 -104.28 0.00"
			"orbit_pivot"     "0.93 0.66 1.52"
			"root_camera_fov"     "54.0"
			"item_rotate" "y[-10 5]" //- x horizontal, z vertical

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.77 0.94 1.00} dir[0.15 -0.39 -0.91] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.73 0.73 0.73} dir[0.63 0.53 -0.56] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.79 0.67 0.41} dir[0.24 0.87 -0.43] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "14.24 -34.26 52.07"
			"shadow_light_orient"        "58.60 111.56 0.00"
			"shadow_light_brightness"    "2.70"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "53.9"
			"shadow_light_vfov"       "53.9"
			"shadow_light_znear"       "23.9"
			"shadow_light_zfar"       "59.7"
			"shadow_light_atten_farz"       "119.4"
			"light_ambient"              "[0.06 0.06 0.06]"

			"camera_preset_add"   "pos[4.88 53.53 144.79] pivot[-0.38 3.69 -7.05] orient[71.74 -96.03 0.00] fov[39.8]" // zoomed out.
			"camera_preset_add"   "pos[31.70 5.11 128.97] pivot[-8.17 0.07 -4.72] orient[73.27 -172.81 0.00] fov[39.8]" // opening scroll
			"camera_preset_add"   "pos[120.13 49.61 121.84] pivot[-15.86 -4.33 7.64] orient[37.98 -158.37 0.00] fov[39.8]" // open anim
		}
	}

		"weapon_case"
	{
		"rule"
		{
			//csgo/trunk/game/csgo/models/props/crates/csgo_drop_crate_armsdeal1.mdl
			"model_partial" "_crate_community_24"
		}
		"config"
		{

			"root_mdl"					    ""		                                // Which pedestal model to load, weapon model is merged to the pedestal, null => weapon model is the scene
			"root_anim"					    ""                          			// Which activity to play on the pedestal
			"root_anim_loop"			    ""				                        // Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"				    ""						                // Which activity to play on the weapon
			"weapon_anim_loop"			    ""										// Which pedestal model to load, weapon model is merged to the pedestal
			"root_camera"				"cam_inspect"								// Which attachment specifies camera location
			"root_camera_fov"			"54.0"									// Camera will use the specified FOV
			"camera_offset"   "-51.44 99.98 42.06"
			"camera_orient"   "16.04 -62.80 0.00"
			"orbit_pivot"     "0.67 -1.39 9.29"
			"item_rotate" "y[-20 60]" //- x horizontal, z vertical

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.47 0.46 0.49} dir[-0.10 -0.95 -0.30] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.53 0.53 0.53} dir[0.69 -0.66 -0.28] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-73.32 75.74 69.69"
			"shadow_light_orient"        "38.30 -44.47 0.00"
			"shadow_light_brightness"    "4.19"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       "42.3"
			"shadow_light_zfar"       "115.7"
			"shadow_light_atten_farz"       "231.4"
			"light_ambient"              "[3.93 3.93 3.93]"

			"camera_preset_add"   "pos[-79.35 181.14 49.98] pivot[-0.71 4.45 -10.68] orient[17.42 -66.01 0.00] fov[54.0]" // zoomed out.
			"camera_preset_add"   "pos[-85.12 165.55 63.25] pivot[0.67 -1.39 9.29] orient[16.04 -62.80 0.00] fov[54.0]" // opening scroll
			"camera_preset_add"   "pos[-53.09 121.06 39.72] pivot[2.30 -4.75 22.04] orient[7.33 -66.24 0.00] fov[54.0]" // open anim
		}
	}

	"team_coins"
	{
		"rule"
		{
			//csgo/trunk/game/csgo/models/props/crates/csgo_drop_crate_armsdeal1.mdl
			"model_partial" "/scoreboard_logos/logo_"
		}
		"config"
		{

			"root_mdl"					    ""		                                // Which pedestal model to load, weapon model is merged to the pedestal, null => weapon model is the scene
			"root_anim"					    "idle"                          			// Which activity to play on the pedestal
			"root_anim_loop"			    "idle"				                        // Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"				    ""						                // Which activity to play on the weapon
			"weapon_anim_loop"			    ""										// Which pedestal model to load, weapon model is merged to the pedestal
			"root_camera"				"cam_inspect"								// Which attachment specifies camera location
			"camera_offset"   "63.52 -1.19 -5.88"
			"camera_orient"   "-5.11 179.00 0.00"
			"orbit_pivot"     "-1.12 -0.06 -0.10"
			"root_camera_fov"     "30"
			"item_rotate" "y[-20 60]" //- x horizontal, z vertical

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.89 0.89 0.89} dir[-0.34 -0.90 -0.29] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "38.30 19.63 22.77"
			"shadow_light_orient"        "27.30 -153.34 0.00"
			"shadow_light_brightness"    "1.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       "42.3"
			"shadow_light_zfar"       "115.7"
			"shadow_light_atten_farz"       "231.4"
			"light_ambient"              "[0.06 0.06 0.06]"
			"camera_preset_add"   "pos[3.14 -0.33 -41.80] pivot[-11.48 -0.14 -3.16] orient[-69.28 179.23 0.00] fov[54.0]"
		}
	}

	"skill_groups"
	{
		"rule"
		{
			//csgo/trunk/game/csgo/models/props/crates/csgo_drop_crate_armsdeal1.mdl
			"model_partial" "/skillgroups/"
		}
		"config"
		{

			"root_mdl"					    ""		                                // Which pedestal model to load, weapon model is merged to the pedestal, null => weapon model is the scene
			"root_anim"					    ""                          			// Which activity to play on the pedestal
			"root_anim_loop"			    ""				                        // Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"				    ""						                // Which activity to play on the weapon
			"weapon_anim_loop"			    ""										// Which pedestal model to load, weapon model is merged to the pedestal
			"root_camera"				"cam_inspect"								// Which attachment specifies camera location
			"camera_offset"   "0.29 -0.07 82.47"
			"camera_orient"   "89.77 179.91 0.00"
			"orbit_pivot"     "-0.07 -0.07 -7.94"
			"root_camera_fov"     "29.3"
			"item_rotate" "y[-20 60]" //- x horizontal, z vertical

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.50 0.50 0.50} dir[-0.34 -0.90 -0.29] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-60.33 52.04 108.05"
			"shadow_light_orient"        "54.94 -39.89 0.00"
			"shadow_light_brightness"    "1.46"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"shadow_light_hfov"       "70.0"
			"shadow_light_vfov"       "70.0"
			"shadow_light_znear"       "42.3"
			"shadow_light_zfar"       "115.7"
			"shadow_light_atten_farz"       "231.4"
			"light_ambient"              "[0.06 0.06 0.06]"

			"camera_preset_add"   "pos[87.22 -2.01 28.32] pivot[2.13 -0.17 -7.94] orient[23.08 178.76 0.00] fov[29.3]"//in
			"camera_preset_add"   "pos[182.70 -28.86 109.65] pivot[1.06 0.00 -7.41] orient[32.48 170.97 0.00] fov[29.3]" //out
		}
	}
}
