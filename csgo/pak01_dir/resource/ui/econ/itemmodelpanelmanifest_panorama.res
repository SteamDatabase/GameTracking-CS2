"Resource/UI/Econ/ItemModelPanelManifest_panorama.res"
{
	// The rules are processed in the order specified and
	// will build up the configuration if "rule" section matches.
	//
	// Example rule:
	// "v_smg_p90_smart"
	// {
	//	"rule"
	//	{
	//		"model" "v_smg_p90"	// Specific weapon model name
	//		"type" "SubMachinegun"	// Types: Knife, Pistol, SubMachinegun, Shotgun, Machinegun, Rifle, SniperRifle
	//		"quality" "3"		// Unusual
	//		"rarity" "3"		// rarity 3 or higher
	//		"stattrak" "1"		// Requires StatTrak(TM) module
	//	}
	//	"config"
	//	{
	//		"root_mdl"						"models/weapons/pedestal_default.mdl"							// Which pedestal model to load, weapon model is merged to the pedestal
	//		"root_anim"						"ACT_IDLE_INSPECT"												// Which activity to play on the pedestal
	//		"root_anim_loop"				"ACT_IDLE_INSPECT"												// Which activity to play on the pedestal after the initial pedestal animation finishes
	//		"root_camera"					"cam_inspect"													// Which attachment specifies camera location
	//		"root_camera_fov"				"54.0"															// Camera will use the specified FOV
	//		"weapon_anim"					"ACT_IDLE_INSPECT"												// Which activity to play on the weapon
	//		"weapon_anim_loop"				"ACT_IDLE_INSPECT"												// Which activity to play on the weapon after the initial weapon animation finishes
	//		"light_ambient"					"[0.11 0.11 0.12]"												// Set the ambient lighting
	//		"light_directional_clearall" 	"1"																// Whether to clear all accumulated directional lights so far (default = 0)
	//		"light_directional_add" 		"rgb[255 255 230] dir[0.45 -0.75 -0.6] 							// Adds a directional light with color (square brackets in range 0..255, curly brackets floating point (hdr), direction, 
	//										 rot[0.5 2.3 0] flicker[2.0 0.2 0.4 0.7]" 						// optional - rotation (degrees per second) and pulse/flicker (pulses per second, pulse amount, flicker rate, flicker amount)
	//		"light_directional_add" 		"rgb[255 25 25] flicker[] attach[red_light_attachment]"			// Attaches a directional light to an attachment point
	//		"shadow_light"					"cam_inspect_light"												// Which attachment specifies light to render shadows from
	//		"shadow_light_znear"			"4.0"															// Shadow light near Z
	//		"shadow_light_zfar"				"512.0"															// Shadow light far Z
	//		"shadow_light_hfov"				"54.0"															// Shadow light horizontal FOV
	//		"shadow_light_vfov"				"54.0"															// Shadow light vertical FOV
	//		"shadow_light_atten_quadratic"	"0.0"															// Shadow light quadratic attenuation
	//		"shadow_light_atten_linear"		"512.0"															// Shadow light linear attenuation
	//		"shadow_light_atten_constant"	"0.0"															// Shadow light constant attenuation
	//		"shadow_light_atten_farz"		"512.0"															// Shadow light far Z attenuation
	//		"shadow_light_color"			"[0.9 0.8 0.7]"													// Shadow light color
	//		"shadow_light_brightness"		"1.0"															// Shadow light color brightness multiplier
	//		"shadow_light_texture"			"effects/flashlight001"											// Shadow light texture cookie
	// 		"shadow_light_rotation"			"0.1 3.0 0.0"													// as per rot[] for directional lights, rotates shadow light (if not attached)
	//		"shadow_light_flicker"			"5.0 0.1 0.5 1.0"												// as per flicker[] for directional lights
	//		"camera_offset"					"0 0 0"															// offset for camera position from attachment, or actual position if no attachment present
	//		"camera_orient"					"0 0 0"															// offset for camera orientation from attachement, or actual orientation if no attachment present
	//		"camera_preset_add"   			"pos[0.0 0.0 0.0] pivot[0.0 0.0 0.0] orient[0.0 0.0 0.0]"		// camera preset/pose, add many of these to choose different views
	//      "orbit_pivot"					"0 0 0"															// scene will rotate around this point in orbit cam mode
	//		"shadow_light_offset"			"0 0 0"															// offset for shadow light from attachment, or actual position if no attachment present
	//		"shadow_light_orient"			"0 0 0"															// offset for shadow light orientation from attachement, or actual orientation if no attachment present
	//		"mergemdls_clearall"			"1"																// Whether to clear all accumulated merge mdls that get merged to pedestal (default = 0)
	//		"mergemdl_add"					"models/weapons/v_models/pedestals/red_velvet_pillow.mdl"		// Which additional model to bonemerge to the pedestal
	//		"weaponmergemdls_clearall"		"1"																// Whether to clear all accumulated merge mdls that get merged to the weapon (default = 0)
	//		"weaponmergemdl_add"			"models/weapons/v_models/pedestals/stattrack_electronics.mdl"	// Which additional model to bonemerge to the weapon
	//		"item_rotate"					"z[-180 180]"													// which axes (and in which order), and bounds for item rotation
	//	}
	// }

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
			"light_ambient"				    "[0.06 0.06 0.06]"						// Set the ambient lighting
			"light_directional_add" 	    "rgb[190 190 196] dir[0 -0.3 -1] rot[0 0 0] flicker[0 0 0 0]"	    // Adds a directional light with color and direction
			"light_directional_add" 	    "rgb[72 111 141] dir[0 -0.2 1] rot[0 0 0] flicker[0 0 0 0]"		    // Adds a directional light with color and direction
			"light_directional_add" 	    "rgb[138 145 153] dir[-0.1 -0.2 -1] rot[0 0 0] flicker[0 0 0 0]"	// Adds a directional light with color and direction
			"light_directional_add" 	    "rgb[40 40 40] flicker[0 0 0 0] attach[cam_inspect]"				// Adds a directional light from the eye
			"shadow_light"				    "cam_inspect_light"						// Which attachment specifies light to render shadows from
			"shadow_light_znear"	    	"4.0"									// Shadow light near Z
			"shadow_light_zfar"			    "2048.0"									// Shadow light far Z
			"shadow_light_hfov"			    "20.0"									// Shadow light horizontal FOV
			"shadow_light_vfov"			    "20.0"									// Shadow light vertical FOV
			"shadow_light_atten_quadratic"	"0.0"								    // Shadow light quadratic attenuation
			"shadow_light_atten_linear"	    "2048.0"								    // Shadow light linear attenuation
			"shadow_light_atten_constant"	"0.0"								    // Shadow light constant attenuation
			"shadow_light_atten_farz"		"2048.0"								    // Shadow light far Z attenuation
			"shadow_light_brightness"		"2.0"							    	// Shadow light color brightness multiplier
			"shadow_light_color"			"[1 1 1]"					    		// Shadow light color
			"shadow_light_texture"			"effects/flashlight_inspect"	    	// Shadow light texture cookie
			"shadow_light_rotation"		    "0 0 0"								    // shadow light rotation in each axis - seconds per 360 degree revolution
			"shadow_light_flicker"		    "0 0 0"					                // shadow light flicker, turbulence function - "amplitude(0..1) frequency(seconds) numOctaves(0..4)"
			"camera_offset"				    "0 0 0"
			"camera_orient"				    "0 0 0"
	        "orbit_pivot"					"0 0 0"
			"shadow_light_offset"		    "0 0 0"
			"shadow_light_orient"		    "0 0 0"
			"item_rotate"				    "x[-180 180] z[-180 180] y[-180 180]"
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
			"light_ambient"				    "[.12 .12 .12]"
			"light_directional_add" 	    "rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 	    "rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 	    "rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 	    "rgb[18 18 20] dir[0 0 1]"
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

	
	"playerCT"
	{
		"rule"
		{
			"model_partial" "custom_player/legacy/ctm"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"light_ambient"				"[.012 .012 .012]"
			"light_directional_add" 	"rgb[10 10 10] dir[-1 0 -0.2]"
			//"light_directional_add" 	"rgb[7 6 4] dir[0 -0.3 -1]"
			"light_directional_add" 	"rgb{3.0 5.0 12.0} dir[1 0.5 0.0]" 		// test rot[0 0 0] flicker[0 1.2 .2 2]"
			"light_directional_add" 	"rgb{0.5 0.3 0.0} dir[-1 0.5 0.0]"
			"light_directional_add" 	"rgb[20 20 30] dir[0 0 1]"
			"shadow_light_brightness"	"2.0"									// Shadow light color brightness multiplier
			"shadow_light_color"		"[2 2 2]"								
			"weapon_anim"				"default"		
			"weapon_anim_loop"			"default"
			"root_camera_fov"			"49.0"									// Camera will use the specified FOV
			"camera_offset"				"97.71 -16.18 25.02"
			"camera_orient"				"-8.46 170.6 0"
			"shadow_light_offset"		"74.98 -23.20 144.64"
			"shadow_light_orient"		"53.19 162.81 0"
			//"shadow_light_rotation"		"0 0 0"
			//"shadow_light_flicker"		"2 0 1 1"
			"item_rotate"				"y[-360 360]"
		}
	}

	"playerT"
	{
		"rule"
		{
			"model_partial" "custom_player/legacy/tm"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"light_ambient"				"[.012 .012 .012]"
			"light_directional_add" 	"rgb[10 10 10] dir[-1 0 -0.2]"
			"light_directional_add" 	"rgb{3.0 5.0 12.0} dir[1 0.5 0.0]" 		// test rot[0 0 0] flicker[0 1.2 .2 2]"
			"light_directional_add" 	"rgb{0.5 0.3 0.0} dir[-1 0.5 0.0]"
			"light_directional_add" 	"rgb[20 20 30] dir[0 0 1]"
			"shadow_light_brightness"	"2.0"									// Shadow light color brightness multiplier
			"shadow_light_color"		"[2 2 2]"								
			"weapon_anim"				"default"		
			"weapon_anim_loop"			"default"
			"root_camera_fov"			"49.0"									// Camera will use the specified FOV
			"camera_offset"				"97.71 -16.18 25.02"
			"camera_orient"				"-8.46 170.6 0"
			"shadow_light_offset"		"74.98 -23.20 144.64"
			"shadow_light_orient"		"53.19 162.81 0"
			"item_rotate"				"y[-360 360]"
		}
	}

	"Pistols"
	{
		"rule"
		{
			"type" "Pistol"
		}
		"config"
		{
//			"camera_offset"				    "15 7 15"
//			"camera_orient"				    "54 -117 0.00"
			"camera_offset"				    "28.94 5.27 -5.37"
			"camera_orient"				    "-9.39 -141.18 0.00"
			"camera_preset_add"   "pos[18.85 2.78 -6.84] pivot[17.80 -3.70 -3.01] orient[-30.25 -99.24 0.00]"
			"camera_preset_add"   "pos[15.66 -0.31 -5.29] pivot[17.44 -3.88 -3.01] orient[-29.79 -63.49 0.00]"
			"camera_preset_add"   "pos[13.38 -5.02 -0.54] pivot[16.96 -2.87 -2.21] orient[21.78 30.94 0.00]"
			"camera_preset_add"   "pos[10.43 -0.94 -9.50] pivot[16.54 -4.18 -4.40] orient[-36.43 -27.96 0.00]"
			"camera_preset_add"   "pos[18.04 -1.45 -6.63] pivot[17.52 -4.36 -4.40] orient[-37.12 -100.16 0.00]"
			"camera_preset_add"   "pos[23.19 -1.97 -3.64] pivot[18.38 -4.13 -2.48] orient[-12.37 -155.85 0.00]"
			"camera_preset_add"   "pos[26.90 -3.54 -2.24] pivot[17.90 -3.49 -2.42] orient[1.15 179.68 0.00]"
			"camera_preset_add"   "pos[25.29 -1.14 -2.13] pivot[21.96 -5.39 -2.28] orient[1.61 -128.12 0.00]"
			"camera_preset_add"   "pos[25.26 -3.84 8.44] pivot[19.41 -3.99 -3.16] orient[63.26 -178.54 0.00]"
			"orbit_pivot"					"17.80 -3.70 -3.01"
			"shadow_light_offset"		    "24.21 4.02 13.94"
			"shadow_light_orient"		    "59.36 -129.72 0.0"
			"item_rotate"				    "y[-20 20] x[-5 5]"
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
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-20 30]"
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
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
		}
	}
	
	"SniperRifles"
	{
		"rule"
		{
			"type" "SniperRifle"
		}
		"config"
		{
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
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
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
		}
	}
	
	"Machineguns"
	{
		"rule"
		{
			"type" "Machinegun"
		}
		"config"
		{
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
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
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
		}
	}
	
	"sig"
	{
		"rule"
		{
			"model" "v_rif_sg556"
		}
		"config"
		{
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
		}
	}
	
	"m4_s"
	{
		"rule"
		{
			"model" "v_rif_m4a1_s"
		}
		"config"
		{
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
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
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
		}
	}
	
	"tac21"
	{
		"rule"
		{
			"model" "v_snip_tac21"
		}
		"config"
		{
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
		}
	}
	
	"Knives"
	{
		"rule"
		{
			"type" "Knife"
		}
		"config"
		{
			"camera_offset"				    "20.76 9.11 3.20"
			"camera_orient"				    "0.92 -134.53 0.00"
			"shadow_light_offset"		    "21.50 7.18 17.60"
			"shadow_light_orient"		    "50.42 -143.47 0"
			"item_rotate"				    "y[-5 5] x[-10 20]"
		}
	}

	"coin"
	{
		"rule"
		{
			"type" "other"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"light_ambient"					"[.02 .02 .02]"
			"light_directional_add" 		"rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
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
}