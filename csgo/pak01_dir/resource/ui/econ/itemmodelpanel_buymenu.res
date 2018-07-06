"Resource/UI/Econ/ItemModelPanel_buymenu.res"
{


	"default"
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
			"root_camera_fov"			    "54.0"									// Camera will use the specified FOV
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.15 0.23 0.30} dir[-0.29 -0.62 0.73] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "60.32 18.24 22.44"
			"shadow_light_orient"        "32.02 -143.29 0.00"
			"shadow_light_brightness"    "6.00"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
			"item_rotate"				    "x[-180 180] z[-180 180] y[-180 180]"
		}
	}

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
			"item_rotate"	  "y[-120 30] x[-15 15]"
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
			"item_rotate"	  "y[-100 40] x[-15 15]"
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
			"item_rotate"	  "y[-90 10] x[-15 15]"
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
			"camera_offset"   "32.76 16.73 -1.12"
			"camera_orient"   "5.57 -123.83 0.00"
			"orbit_pivot"     "18.94 -3.89 -3.54"
			"item_rotate"	  "y[-110 20] x[-5 15]"
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
			"item_rotate"	  "y[-110 20] x[-5 15]"
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
			"item_rotate"	  "y[-100 40] x[-15 15]"
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
			"item_rotate"	  "y[-110 30] x[-15 15]"
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
			"item_rotate"	  "y[-110 30] x[-15 15]"
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
			"item_rotate"	  "y[-120 30] x[-15 15]"
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
			"item_rotate"	  "y[-120 30] x[-15 15]"
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
			"item_rotate"		"y[30 -120] x[-15 15]"
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
			"camera_offset"   "44.08 28.98 -5.92"
			"camera_orient"   "-0.69 -126.19 0.00"
			"orbit_pivot"     "19.04 -5.25 -5.41"
			"item_rotate"	  "y[-110 30] x[-10 10]"
		}
	}

	"mp5sd"
	{
		"rule"
		{
			"model" "v_smg_mp5sd"
		}
		"config"
		{
			"camera_offset"   "36.93 22.88 -3.42"
			"camera_orient"   "1.30 -124.29 0.00"
			"orbit_pivot"     "18.77 -3.75 -4.15"
			"item_rotate"	  "y[-120 30] x[-15 15]"
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
			"camera_offset"   "39.94 24.90 -6.22"
			"camera_orient"   "-2.37 -133.23 0.00"
			"orbit_pivot"     "13.84 -2.86 -4.65"
			"item_rotate"	  "y[-120 30] x[-15 15]"
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
			"camera_offset"   "40.45 18.60 -4.65"
			"camera_orient"   "1.76 -131.62 0.00"
			"orbit_pivot"     "19.05 -5.49 -5.65"
			"item_rotate"	  "y[-120 30] x[-15 15]"
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
			"camera_offset"   "33.37 21.02 -5.82"
			"camera_orient"   "-1.91 -126.81 0.00"
			"orbit_pivot"     "14.06 -4.78 -4.75"
			"item_rotate"	  "y[-100 30] x[-15 15]"
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
			"item_rotate"	  "y[-120 30] x[-10 10]"
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
			"item_rotate"	"y[-120 20] x[-5 5]"
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
			"camera_offset"   "28.79 46.34 -2.69"
			"camera_orient"   "2.95 -100.69 0.00"
			"orbit_pivot"     "19.13 -4.89 -5.38"
			"item_rotate"	  "y[-90 10] x[-5 5]"
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
			"item_rotate"	  "y[-120 30] x[-10 10]"
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
			"camera_offset"   "50.31 33.54 -6.51"
			"camera_orient"   "0.38 -128.87 0.00"
			"orbit_pivot"     "18.22 -6.28 -6.85"
			"item_rotate"	  "y[-120 30] x[-10 10]"
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
			"item_rotate"	  "y[-120 30] x[-10 10]"
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
			"camera_offset"   "48.24 36.02 -10.60"
			"camera_orient"   "-4.43 -126.81 0.00"
			"orbit_pivot"     "17.75 -4.73 -6.65"
			"item_rotate"	  "y[-110 30] x[-10 10]"
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
			"camera_offset"   "52.65 30.63 -8.85"
			"camera_orient"   "-2.37 -129.56 0.00"
			"orbit_pivot"     "23.35 -4.84 -6.95"
			"item_rotate"	  "y[-120 30] x[-10 10]"

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.15 0.23 0.30} dir[-0.29 -0.62 0.73] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "63.98 -47.45 54.75"
			"shadow_light_orient"        "36.60 157.35 0.00"
			"shadow_light_brightness"    "5.39"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
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
			"item_rotate"	  "y[-100 30] x[-5 5]"
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
			"item_rotate"	  "y[-100 30] x[-5 5]"
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
			"item_rotate"	  "y[-110 20] x[-5 5]"
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
			"camera_offset"   "59.13 36.53 -5.70"
			"camera_orient"   "-0.77 -131.62 0.00"
			"orbit_pivot"     "21.85 -5.44 -4.95"
			"item_rotate"	  "y[-100 30] x[-5 5]"
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
			"item_rotate"	  "y[-100 30] x[-5 5]"
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
			"camera_offset"				    "48 38 13"
			"camera_orient"				    "23.8 -111 0"
			"orbit_pivot"					"26.86 -15.6 -12.27"
			"shadow_light_offset"		    "50.35 -36.38 81.06"
			"shadow_light_orient"		    "62.82 131.73 0"
			"item_rotate"				    "y[-120 20] x[-5 5]"
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
			"camera_offset"   "55.24 26.76 4.15"
			"camera_orient"   "15.52 -129.80 0.00"
			"orbit_pivot"     "26.12 -8.20 -8.48"
			"item_rotate"	  "y[-100 30] x[-15 15]"
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
			"camera_offset"   "59.13 36.53 -5.70"
			"camera_orient"   "-0.77 -131.62 0.00"
			"orbit_pivot"     "21.85 -5.44 -4.95"
			"item_rotate"	  "y[-120 30] x[-5 5]"
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
			"camera_offset"   "46.12 29.86 -4.67"
			"camera_orient"   "0.38 -124.52 0.00"
			"orbit_pivot"     "21.85 -5.44 -4.95"
			"item_rotate"	  "y[-100 30] x[-5 5]"
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
			"item_rotate"	  "y[-110 30] x[-5 5]"
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
			"camera_offset"   "62.69 38.85 -8.03"
			"camera_orient"   "-3.06 -125.89 0.00"
			"orbit_pivot"     "30.00 -6.33 -5.05"
			"item_rotate"	  "y[-115 30] x[-5 5]"
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
			"item_rotate"	  "y[-115 30] x[-5 5]"
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


	"Grenades"
	{
		"rule"
		{
			"type" "Grenade"
		}
		"config"
		{
			"camera_offset"				    "15.48 16.91 2.3"
			"camera_orient"				    "20.17 -79.53 0.0"
			"orbit_pivot"					"19.44 -4.5 -5.7"
			"shadow_light_offset"		    "17.86 4.92 20.73"
			"shadow_light_orient"		    "70.13 -80.33 0"
			"shadow_light_brightness"		"3.0"
			"item_rotate"				    "y[-120 20] x[-5 5]"
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
			"light_ambient"				"[.12 .12 .12]"
			"light_directional_add" 		"rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
			"root_mdl"					"models/weapons/pedestal_gloves.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
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
		"light_directional_add"      "rgb{0.20 0.20 0.24} dir[0.00 -1.00 -0.20] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
		"light_directional_add"      "rgb{0.47 0.39 0.39} dir[0.00 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
		"light_directional_add"      "rgb{0.39 0.39 0.39} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
		"light_directional_add"      "rgb{0.07 0.07 0.08} dir[0.00 0.00 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
		"shadow_light_offset"        "12.32 15.94 72.23"
		"shadow_light_orient"        "79.69 -88.97 0.00"
		"shadow_light_brightness"    "4.66"
		"shadow_light_color"         "[1.00 1.00 1.00]"
		"shadow_light_rotation"      "[0.00 0.00 0.00]"
		"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
		"light_ambient"              "[0.12 0.12 0.12]"
		"root_mdl"					"models/weapons/pedestal_sticker.mdl"
		"root_anim"					"ACT_IDLE_INSPECT_START"		
		"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
		"mergemdl_add"			"models/weapons/ct_arms_fbi.mdl"
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
			"camera_offset"   "9.61 19.80 1.47"
			"camera_orient"   "0.69 -114.78 0.00"
			"orbit_pivot"     "0.56 0.19 1.21"
			"item_rotate"		"y[-180 180] x[-5 5]"

			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.74 0.74 0.74} dir[0.05 -0.66 0.75] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "41.68 0.39 -17.97"
			"shadow_light_orient"        "-25.51 171.57 0.00"
			"shadow_light_brightness"    "4.66"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
			"weapon_anim"				"idle1"												// Which activity to play on the weapon
		}
	}

	"karam_knife"
	{
		"rule"
		{
			"model_partial" "karam"
		}
		"config"
		{
			"camera_offset"   "19.29 -9.52 -36.07"
			"camera_orient"   "-83.81 93.09 0.00"
			"orbit_pivot"     "19.11 -6.10 -4.45"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.74 0.74 0.74} dir[0.05 -0.66 0.75] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "34.00 -35.48 -22.18"
			"shadow_light_orient"        "-27.20 116.84 0.00"
			"shadow_light_brightness"    "4.66"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"

		}
	}

	"push_knife"
	{
		"rule"
		{
			"model_partial" "knife_push"
		}
		"config"
		{
			"camera_offset"   "34.77 0.49 -30.24"
			"camera_orient"   "-57.00 175.37 0.00"
			"orbit_pivot"     "17.46 1.89 -3.50"
			"item_rotate"	"y[-180 180 ] x[-180 180 ]"
		}
	}

	"knife_default"
	{
		"rule"
		{
			"model_partial" "v_knife_default"
		}
		"config"
		{
			"camera_offset"   "22.99 8.63 -33.65"
			"camera_orient"   "-66.85 -104.46 0.00"
			"orbit_pivot"     "19.82 -3.67 -3.95"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.74 0.74 0.74} dir[0.05 -0.66 0.75] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "26.89 12.87 -18.84"
			"shadow_light_orient"        "-44.53 -121.51 0.00"
			"shadow_light_brightness"    "4.66"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
		}
	}

	"knife_gut"
	{
		"rule"
		{
			"model_partial" "v_knife_gut"
		}
		"config"
		{
			"camera_offset"   "27.23 11.90 -38.75"
			"camera_orient"   "-64.10 -114.09 0.00"
			"orbit_pivot"     "20.28 -3.65 -3.67"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.74 0.74 0.74} dir[0.05 -0.66 0.75] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "34.74 24.12 -19.49"
			"shadow_light_orient"        "-37.06 -116.01 0.00"
			"shadow_light_brightness"    "4.66"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
		}
	}

	"knife_bayonet"
	{
		"rule"
		{
			"model_partial" "v_knife_bayonet"
		}
		"config"
		{
			"camera_offset"   "23.30 9.76 -35.75"
			"camera_orient"   "-70.29 -104.38 0.00"
			"orbit_pivot"     "20.41 -1.51 -3.26"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
		}
	}

	"knife_butterfly"
	{
		"rule"
		{
			"model_partial" "v_knife_butterfly"
		}
		"config"
		{
			"camera_offset"   "22.83 9.82 -30.81"
			"camera_orient"   "-63.19 -101.21 0.00"
			"orbit_pivot"     "20.16 -3.63 -3.68"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
		}
	}

	"knife_falchion"
	{
		"rule"
		{
			"model_partial" "falchion_advanced"
		}
		"config"
		{
			"camera_offset"   "21.35 16.06 -32.89"
			"camera_orient"   "-56.08 -101.72 0.00"
			"orbit_pivot"     "17.42 -2.90 -4.09"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
		}
	}

	
	"knife_flip"
	{
		"rule"
		{
			"model_partial" "v_knife_flip"
		}
		"config"
		{
			"camera_offset"   "23.16 9.34 -33.75"
			"camera_orient"   "-66.92 -102.86 0.00"
			"orbit_pivot"     "20.33 -3.04 -3.95"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
		}
	}


	"knife_m9_bay"
	{
		"rule"
		{
			"model_partial" "v_knife_m9_bay"
		}
		"config"
		{
			"camera_offset"   "24.42 15.21 -39.89"
			"camera_orient"   "-63.64 -103.78 0.00"
			"orbit_pivot"     "20.13 -2.26 -3.59"
			"item_rotate"				"y[-180 180 ] x[-180 180 ]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.74 0.74 0.74} dir[0.05 -0.66 0.75] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "35.60 24.35 -26.34"
			"shadow_light_orient"        "-45.68 -123.80 0.00"
			"shadow_light_brightness"    "4.66"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.06 0.06 0.06]"
		}
	}

	"coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/"
		}
		"config"
		{
			"camera_offset"   "-0.50 0.00 25.93"
			"camera_orient"   "90.00 -179.86 0.00"
			"orbit_pivot"     "-0.50 0.00 0.04"
			"item_rotate"		"y[-5 5] x[-25 25]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-43.01 -10.17 23.49"
			"shadow_light_orient"        "22.85 12.33 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"trophy"
	{
		"rule"
		{
			"model_partial" "trophy"
		}
		"config"
		{
			"camera_offset"   "24.57 -0.23 4.98"
			"camera_orient"   "3.83 179.22 0.00"
			"orbit_pivot"     "-1.26 0.12 3.25"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "21.19 6.79 11.80"
			"shadow_light_orient"        "23.77 -163.46 0.00"
			"shadow_light_brightness"    "2.31"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"trophy_majors"
	{
		"rule"
		{
			"model_partial" "trophy_majors"
		}
		"config"
		{
			"camera_offset"   "41.78 -0.77 11.34"
			"camera_orient"   "3.83 179.22 0.00"
			"orbit_pivot"     "-1.61 -0.18 8.44"
			"item_rotate"		"y[-120 120] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "48.45 12.98 18.49"
			"shadow_light_orient"        "18.27 -165.52 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"cologne_trophy"
	{
		"rule"
		{
			"model_partial" "cologne_trophy_"
		}
		"config"
		{
			"camera_offset"   "44.49 -0.51 11.23"
			"camera_orient"   "3.83 179.22 0.00"
			"orbit_pivot"     "-1.59 0.12 8.14"
			"item_rotate"		"y[-20 20] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "48.45 12.98 18.49"
			"shadow_light_orient"        "18.27 -165.52 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
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
			"camera_offset"   "27.16 2.10 2.97"
			"camera_orient"   "0.39 -175.73 0.00"
			"orbit_pivot"     "-1.05 -0.01 2.78"
			"item_rotate"		"y[-20 20] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "35.77 20.52 23.68"
			"shadow_light_orient"        "23.77 -149.47 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"cologne_prediction"
	{
		"rule"
		{
			"model_partial" "inventory_items/cologne_prediction"
		}
		"config"
		{
			"camera_offset"   "6.80 60.22 23.16"
			"camera_orient"   "8.41 -96.44 0.00"
			"orbit_pivot"     "-0.23 -2.09 13.89"
			"item_rotate"		"y[-15 15] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-15.97 39.52 41.89"
			"shadow_light_orient"        "40.27 -72.01 0.00"
			"shadow_light_brightness"    "6.37"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"cologne_prediction_plaque"
	{
		"rule"
		{
			"model_partial" "inventory_items/cologne_prediction_plaque"
		}
		"config"
		{
			"camera_offset"   "-0.36 51.08 10.74"
			"camera_orient"   "1.53 -89.56 0.00"
			"orbit_pivot"     "0.04 -1.49 9.34"
			"item_rotate"		"y[-20 20] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-14.13 58.19 21.99"
			"shadow_light_orient"        "11.30 -76.36 0.00"
			"shadow_light_brightness"    "6.37"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

"dhw_2014_champion"
	{
		"rule"
		{
			"model_partial" "inventory_items/dhw_2014_"
		}
		"config"
		{
			"camera_offset"   "23.43 0.65 3.10"
			"camera_orient"   "-0.07 179.91 0.00"
			"orbit_pivot"     "-0.76 0.69 3.13"
			"item_rotate"		"y[-20 20] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "76.08 43.05 33.70"
			"shadow_light_orient"        "22.85 -147.36 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 0.97 0.97]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
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
			"camera_offset"   "24.41 -0.64 7.70"
			"camera_orient"   "10.47 178.76 0.00"
			"orbit_pivot"     "-1.05 -0.09 2.99"
			"item_rotate"		"y[-20 20] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "27.92 7.13 40.85"
			"shadow_light_orient"        "49.80 -164.60 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"kat_2015_pickem"
	{
		"rule"
		{
			"model_partial" "/inventory_items/kat_2015_pickem"
		}
		"config"
		{
			"camera_offset"   "52.03 -0.58 14.45"
			"camera_orient"   "4.28 179.45 0.00"
			"orbit_pivot"     "-2.41 -0.06 10.37"
			"item_rotate"		"y[-20 20] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "34.76 11.79 34.92"
			"shadow_light_orient"        "36.74 -159.33 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
			
		}
	}

	"katowice2015_trophy"
	{
		"rule"
		{
			"model_partial" "/inventory_items/katowice2015_trophy"
		}
		"config"
		{
			"camera_offset"   "51.45 -0.92 10.44"
			"camera_orient"   "2.91 178.76 0.00"
			"orbit_pivot"     "-1.56 0.22 7.74"
			"item_rotate"		"y[-20 20] x[-5 5]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "34.76 11.79 34.92"
			"shadow_light_orient"        "36.74 -159.33 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}



	"breakout_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/breakout_"
		}
		"config"
		{
			"camera_offset"   "0.10 0.00 20.83"
			"camera_orient"   "90.00 -179.86 0.00"
			"orbit_pivot"     "0.10 0.00 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-40.75 2.86 -3.67"
			"shadow_light_orient"        "-11.53 -5.78 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"phoniex_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/phoenix_"
		}
		"config"
		{
			"camera_offset"   "0.10 0.00 20.83"
			"camera_orient"   "90.00 -179.86 0.00"
			"orbit_pivot"     "0.10 0.00 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-14.58 8.39 14.59"
			"shadow_light_orient"        "37.29 -25.03 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"payback_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/payback_"
		}
		"config"
		{
			"camera_offset"   "0.10 -0.10 20.93"
			"camera_orient"   "90.00 -179.63 0.00"
			"orbit_pivot"     "0.10 -0.10 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-14.58 8.39 14.59"
			"shadow_light_orient"        "37.29 -25.03 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"bloodhound_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/bloodhound_"
		}
		"config"
		{
			"camera_offset"   "0.20 -0.10 22.23"
			"camera_orient"   "90.00 179.91 0.00"
			"orbit_pivot"     "0.20 -0.10 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-27.17 11.95 10.63"
			"shadow_light_orient"        "11.62 -23.88 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"hydra_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/operation_8"
		}
		"config"
		{
			"camera_offset"   "-19.99 -0.00 0.04"
			"camera_orient"   "180.00 180.00 0.00"
			"orbit_pivot"     "-0.50 0.00 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-40.75 2.86 -3.67"
			"shadow_light_orient"        "-11.53 -5.78 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"wildfire_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/operation_7"
		}
		"config"
		{
			"camera_offset"   "4.70 -0.09 21.33"
			"camera_orient"   "90.00 178.54 0.00"
			"orbit_pivot"     "4.70 -0.09 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-38.61 -7.62 24.94"
			"shadow_light_orient"        "33.62 9.80 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"bravo_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/bravo"
		}
		"config"
		{
			"camera_offset"   "0.10 0.00 21.13"
			"camera_orient"   "90.00 -179.86 0.00"
			"orbit_pivot"     "0.10 0.00 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-0.73 1.51 22.55"
			"shadow_light_orient"        "87.48 -52.95 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"map_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/maptoken"
		}
		"config"
		{
			"camera_offset"   "0.30 0.00 23.33"
			"camera_orient"   "90.00 -179.86 0.00"
			"orbit_pivot"     "0.30 0.00 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-14.58 8.39 14.59"
			"shadow_light_orient"        "37.29 -25.03 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"pin_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/collectible_pin"
		}
		"config"
		{
			"camera_offset"   "0.70 -0.00 21.23"
			"camera_orient"   "90.00 -179.86 0.00"
			"orbit_pivot"     "0.70 -0.00 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "-14.58 8.39 14.59"
			"shadow_light_orient"        "37.29 -25.03 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}

	"fiveyear_coin"
	{
		"rule"
		{
			"model_partial" "inventory_items/5_year_coin"
		}
		"config"
		{
			"camera_offset"   "0.10 0.00 22.63"
			"camera_orient"   "90.00 179.45 0.00"
			"orbit_pivot"     "0.10 0.00 0.04"
			"item_rotate"		"y[-5 5] x[-15 15]"
			"light_directional_clearall" "1"
			"light_directional_add"      "rgb{0.23 0.23 0.23} dir[-0.01 0.02 1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.70 0.79 0.85} dir[0.48 -0.52 -0.71] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.54 0.57 0.60} dir[-0.10 -0.20 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"light_directional_add"      "rgb{0.16 0.16 0.16} dir[0.00 0.00 -1.00] rot[0.0 0.0 0.0] flicker[0.00 0.00 0.00 0.00]"
			"shadow_light_offset"        "5.64 -23.81 30.04"
			"shadow_light_orient"        "49.43 107.67 0.00"
			"shadow_light_brightness"    "1.38"
			"shadow_light_color"         "[1.00 1.00 1.00]"
			"shadow_light_rotation"      "[0.00 0.00 0.00]"
			"shadow_light_flicker"       "[0.00 0.00 0.00 0.00]"
			"light_ambient"              "[0.03 0.03 0.03]"
		}
	}
}
