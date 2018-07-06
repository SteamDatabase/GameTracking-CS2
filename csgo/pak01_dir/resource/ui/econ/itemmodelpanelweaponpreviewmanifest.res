"Resource/UI/Econ/ItemModelPanelWeaponPreviewManifest.res"
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
	//		"light_directional_add" 		"rgb[255 255 230] dir[0.45 -0.75 -0.6]"							// Adds a directional light with color and direction
	//		"light_directional_add" 		"rgb[255 25 25] attach[red_light_attachment]"					// Attaches a directional light to an attachment point
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
	//		"mergemdls_clearall"			"1"																// Whether to clear all accumulated merge mdls that get merged to pedestal (default = 0)
	//		"mergemdl_add"					"models/weapons/v_models/pedestals/red_velvet_pillow.mdl"		// Which additional model to bonemerge to the pedestal
	//		"weaponmergemdls_clearall"		"1"																// Whether to clear all accumulated merge mdls that get merged to the weapon (default = 0)
	//		"weaponmergemdl_add"			"models/weapons/v_models/pedestals/stattrack_electronics.mdl"	// Which additional model to bonemerge to the weapon
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
			"root_mdl"					"models/weapons/pedestal_default.mdl"		// Which pedestal model to load, weapon model is merged to the pedestal
			"root_anim"					"ACT_IDLE_INSPECT_PISTOL_START"				// Which activity to play on the pedestal
			"root_anim_loop"				"ACT_IDLE_INSPECT_PISTOL_LOOP"				// Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"					"ACT_IDLE_INSPECT"						// Which activity to play on the weapon
			"weapon_anim_loop"			"ACT_IDLE_INSPECT"						// Which activity to play on the weapon after the initial weapon animation finishes
			"root_camera"					"cam_inspect"								// Which attachment specifies camera location
			"root_camera_fov"				"54.0"									// Camera will use the specified FOV
			"light_ambient"				"[0.06 0.06 0.06]"							// Set the ambient lighting
			"light_directional_add" 		"rgb[190 190 196] dir[0 -0.3 -1]"			// Adds a directional light with color and direction
			"light_directional_add" 		"rgb[72 111 141] dir[0 -0.2 1]"			// Adds a directional light with color and direction
			"light_directional_add" 		"rgb[138 145 153] dir[-0.1 -0.2 -1]"			// Adds a directional light with color and direction
			"light_directional_add" 		"rgb[40 40 40] attach[cam_inspect]"		// Adds a directional light from the eye
			"shadow_light"				"cam_inspect_light"						// Which attachment specifies light to render shadows from
			"shadow_light_znear"			"4.0"									// Shadow light near Z
			"shadow_light_zfar"			"512.0"									// Shadow light far Z
			"shadow_light_hfov"			"54.0"									// Shadow light horizontal FOV
			"shadow_light_vfov"			"54.0"									// Shadow light vertical FOV
			"shadow_light_atten_quadratic"	"0.0"									// Shadow light quadratic attenuation
			"shadow_light_atten_linear"	"512.0"									// Shadow light linear attenuation
			"shadow_light_atten_constant"	"0.0"									// Shadow light constant attenuation
			"shadow_light_atten_farz"		"512.0"									// Shadow light far Z attenuation
			"shadow_light_brightness"		"2.0"									// Shadow light color brightness multiplier
			"shadow_light_color"			"[1 1 1]"								// Shadow light color
			"shadow_light_texture"			"effects/flashlight_inspect"					// Shadow light texture cookie
			"camera_offset"		"0 0 0"
			"camera_orient"		"0 0 0"
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
			"light_directional_clearall" 	"1"
			"light_ambient"				"[.12 .12 .12]"
			"light_directional_add" 		"rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
			"root_mdl"					"models/weapons/pedestal_sticker.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
			"mergemdl_add"			"models/weapons/ct_arms_fbi.mdl"
		}
	}
	
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
			"light_directional_add" 		"rgb[15 34 62] dir[0 -1 -0.2]"
			"root_mdl"					"models/sprays/pedestal_sprays.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
			"shadow_light"				"cam_inspect_light"						// Which attachment specifies light to render shadows from
			"shadow_light_znear"			"4.0"									// Shadow light near Z
			"shadow_light_zfar"			"512.0"									// Shadow light far Z
			"shadow_light_hfov"			"54.0"									// Shadow light horizontal FOV
			"shadow_light_vfov"			"54.0"									// Shadow light vertical FOV
			"shadow_light_atten_quadratic"	"0.0"									// Shadow light quadratic attenuation
			"shadow_light_atten_linear"	"512.0"									// Shadow light linear attenuation
			"shadow_light_atten_constant"	"0.0"									// Shadow light constant attenuation
			"shadow_light_atten_farz"		"512.0"									// Shadow light far Z attenuation
			"shadow_light_brightness"		"2.0"									// Shadow light color brightness multiplier
			"shadow_light_color"			"[1.2 1.16 .93]"								// Shadow light color
			"shadow_light_texture"			"effects/flashlight_inspect"					// Shadow light texture cookie
		}
	}
	
	"stickerpreview_lightfarz"
	{
		"rule"
		{
			"sticker_preview" "1"
		}
		"config"
		{
			"shadow_light_atten_farz" "1024.0"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"12.289999 -0.480000 -1.330000"
			"camera_orient"		"14.569998 -10.030001 0.000000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"13.779999 0.980000 -1.940000"
			"camera_orient"		"14.569998 -10.030001 0.000000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"14.430000 0.700000 2.020000"
			"camera_orient"		"24.089996 -20.990000 5.230000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"-1.800000 2.770000 6.180000"
			"camera_orient"		"25.379997 -11.620002 -17.600004"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"8.410001 2.130000 2.670000"
			"camera_orient"		"23.919992 -17.560001 -4.540000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"14.600000 6.930000 2.330000"
			"camera_orient"		"23.729996 -25.799994 -5.370000"
		}
	}
	
	"stickerpreview_shotgun_shared"
	{
		"rule"
		{
			"type" "Shotgun"
			"sticker_preview" "1"
		}
		"config"
		{
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"root_camera_fov"	"35.0"
			"shadow_light_hfov"	"35.0"
			"shadow_light_vfov"	"35.0"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"5.020000 9.770000 2.850000"
			"camera_orient"		"14.169997 -12.379998 -0.580000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"10.910001 -1.300000 6.600000"
			"camera_orient"		"58.949993 -8.090001 6.900000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"8.500000 3.310000 -0.370000"
			"camera_orient"		"6.650000 0.000000 0.000000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"2.850000 0.630000 -3.030000"
			"camera_orient"		"0.710000 0.430000 7.530000"
		}
	} 
	
	"stickerpreview_rifle_shared"
	{
		"rule"
		{
			"type" "Rifle"
			"sticker_preview" "1"
		}
		"config"
		{
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"root_camera_fov"	"45.0"
			"shadow_light_hfov"	"45.0"
			"shadow_light_vfov"	"45.0"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"10.580000 5.850000 0.470000"
			"camera_orient"		"13.020002 -18.909996 0.340000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"5.510000 2.370000 2.340000"
			"camera_orient"		"19.559999 -17.809999 4.980000"
		}
	}
	
	"stickerpreview_sg556"
	{
		"rule"
		{
			"model" "v_rif_sg556"
			"sticker_preview" "1"
		}
		"config"
		{
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"4.780000 8.219999 2.590000"
			"camera_orient"		"25.109997 -22.239998 -11.710000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"0.810000 -0.880001 3.240000"
			"camera_orient"		"21.279997 -2.789992 -1.840000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"-0.110000 1.549999 4.230000"
			"camera_orient"		"20.109997 -9.839992 -17.140001"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"4.390000 3.799999 1.690000"
			"camera_orient"		"20.649996 -17.899990 -5.709998"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"7.909999 4.010000 2.050000"
			"camera_orient"		"16.320002 -3.600000 0.000000"
		}
	}
	
	
	"stickerpreview_smg_shared"
	{
		"rule"
		{
			"type" "SubMachinegun"
			"sticker_preview" "1"
		}
		"config"
		{
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"root_camera_fov"	"40.0"
			"shadow_light_hfov"	"40.0"
			"shadow_light_vfov"	"40.0"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"12.639999 -0.350000 1.810000"
			"camera_orient"		"19.639999 -8.320000 4.480000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"2.670000 -1.390000 3.370000"
			"camera_orient"		"16.259998 -9.210000 3.780000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"4.800000 -1.230000 1.530000"
			"camera_orient"		"11.019999 -19.520002 3.080000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"3.050000 7.390000 1.850000"
			"camera_orient"		"18.949999 -22.470003 -25.670002"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"12.450000 -4.510000 1.990000"
			"camera_orient"		"18.179996 -22.449995 5.880000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_prepare"
			"weapon_anim_loop"	"lookat01_loop"
			"camera_offset"		"3.290000 0.330000 -3.150000"
			"camera_orient"		"0.190000 -11.480000 6.240000"
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
			"root_mdl"			"models/weapons/pedestal_firstperson.mdl"
			"weaponmergemdl_add" "models/weapons/ct_arms_sas.mdl"
			"weapon_anim"		"lookat01_sticker"
			"weapon_anim_loop"	"lookat01_sticker_loop"
			"camera_offset"		"3.290000 0.330000 -3.150000"
			"camera_orient"		"0.190000 -11.480000 6.240000"
		}
	}
	
	"stickerpreview_pistol_shared"
	{
		"rule"
		{
			"type" "Pistol"
			"sticker_preview" "1"
		}
		"config"
		{
			"root_mdl_stickerpreview"			"models/weapons/pedestal_default.mdl"
			"arms_stickerpreview"				"none"
			"root_camera_fov"	"37.0"
			"shadow_light_hfov"	"37.0"
			"shadow_light_vfov"	"37.0"
			"camera_offset"		"-2 0 0"
		}
	}
	
	"stickerpreview_elite"
	{
		"rule"
		{
			"model" "v_pist_elite"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"	"0 0 0"
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
			"camera_offset"	"0 0 0"
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
			"camera_offset"	"-1 0 -1"
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
			"camera_offset"	"0 1 -0.3"
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
			"camera_offset"	"-1 -1 1"
		}
	}
	
	"stickerpreview_glock"
	{
		"rule"
		{
			"model" "v_pist_glock18"
			"sticker_preview" "1"
		}
		"config"
		{
			"camera_offset"	"-0.7 -1 -1.2"
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
	
	"SMGs"
	{
		"rule"
		{
			"type" "SubMachinegun"
		}
		"config"
		{
			"root_anim"			"ACT_IDLE_INSPECT_SMG_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_SMG_LOOP"
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
			"root_anim"			"ACT_IDLE_INSPECT_RIFLE_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_RIFLE_LOOP"
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
			"root_anim"			"ACT_IDLE_INSPECT_HEAVY_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_HEAVY_LOOP"
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
			"root_anim"			"ACT_IDLE_INSPECT_RIFLE_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_RIFLE_LOOP"
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
			"root_anim"			"ACT_IDLE_INSPECT_HEAVY_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_HEAVY_LOOP"
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
			"root_anim"			"ACT_IDLE_INSPECT_HEAVY_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_HEAVY_LOOP"
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
			"root_anim"			"ACT_IDLE_INSPECT_HEAVY_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_HEAVY_LOOP"
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
			"root_anim"			"ACT_IDLE_INSPECT_M4S_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_M4S_LOOP"
		}
	}
	
	"mac10"
	{
		"rule"
		{
			"model" "v_smg_mac10"
			"sticker_preview" "0"
		}
		"config"
		{
			"weapon_anim"			"ACT_IDLE_INSPECT"
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
			"root_mdl"			"models/weapons/pedestal_knives.mdl"
			"root_anim"			"ACT_IDLE_INSPECT_KNIFE_START"
			"root_anim_loop"		"ACT_IDLE_INSPECT_KNIFE_LOOP"
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
			"mergemdl_add"			"models/weapons/stattrack_advert.mdl"			// Merge the advert to the pedestal
			"weaponmergemdl_add"		"models/weapons/stattrack_weaponpreview.mdl"		// Merge the actual indicator to the gun
		}
	}
	
	"StatTrak_pistols"
	{
		"rule"
		{
			"stattrak" "1"
			"type" "Pistol"
		}
		"config"
		{
			"mergemdls_clearall"			"1"
			"mergemdl_add"			"models/weapons/stattrack_advert_small.mdl"			// Merge the advert to the pedestal
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
			"mergemdl_add"			"models/weapons/stattrack_advert_small.mdl"			// Merge the advert to the pedestal
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
	
	"LowAdvertfamas"
	{
		"rule"
			{
				"stattrak" "1"
				"model" "v_rif_famas"
			}
		"config"
			{
				"mergemdls_clearall"		"1"
				"mergemdl_add"			"models/weapons/stattrack_advert_small_lower.mdl"
			}
	}
	"LowAdvertg3sg1"
	{
		"rule"
			{
				"stattrak" "1"
				"model" "v_snip_g3sg1"
			}
		"config"
			{
				"mergemdls_clearall"		"1"
				"mergemdl_add"			"models/weapons/stattrack_advert_small_lower.mdl"
			}
	}
	"LowAdvertgalilar"
	{
		"rule"
			{
				"stattrak" "1"
				"model" "v_rif_galilar"
			}
		"config"
			{
				"mergemdls_clearall"		"1"
				"mergemdl_add"			"models/weapons/stattrack_advert_small_lower.mdl"
			}
	}
	"LowAdvertscar20"
	{
		"rule"
			{
				"stattrak" "1"
				"model" "v_snip_scar20"
			}
		"config"
			{
				"mergemdls_clearall"		"1"
				"mergemdl_add"			"models/weapons/stattrack_advert_small_lower.mdl"
			}
	}
	"LowAdvertnova"
	{
		"rule"
			{
				"stattrak" "1"
				"model" "v_shot_nova"
			}
		"config"
			{
				"mergemdls_clearall"		"1"
				"mergemdl_add"			"models/weapons/stattrack_advert_small_lower.mdl"
			}
	}
	"LowAdvertssg08"
	{
		"rule"
			{
				"stattrak" "1"
				"model" "v_snip_ssg08"
			}
		"config"
			{
				"mergemdls_clearall"		"1"
				"mergemdl_add"			"models/weapons/stattrack_advert_small_lower.mdl"
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
			"light_ambient"				"[.02 .02 .02]"
			"light_directional_add" 		"rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
			"root_mdl"					"models/weapons/pedestal_badges.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
		}
	}
	
	"kat_2015"
	{
		"rule"
		{
			"type" "other"
			"model_partial" "kat_2015"
		}
		"config"
		{
			"root_mdl"					"models/weapons/pedestal_badges_nocase.mdl"
		}
	}
	
	"katowice2015"
	{
		"rule"
		{
			"type" "other"
			"model_partial" "katowice2015"
		}
		"config"
		{
			"root_mdl"					"models/weapons/pedestal_badges_nocase.mdl"
		}
	}
	
	"cologne_trophy"
	{
		"rule"
		{
			"type" "other"
			"model_partial" "cologne_trophy"
		}
		"config"
		{
			"root_mdl"					"models/weapons/pedestal_badges_nocase.mdl"
		}
	}
	
	"cologne_prediction"
	{
		"rule"
		{
			"type" "other"
			"model_partial" "cologne_prediction"
		}
		"config"
		{
			"root_mdl"					"models/weapons/pedestal_badges_nocase.mdl"
		}
	}	
	
	"trophy_majors"
	{
		"rule"
		{
			"type" "other"
			"model_partial" "trophy_majors"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"shadow_light_color"			"[10.0 10.0 10.0]"
			"light_ambient"				"[0.0 0.0 0.0]"
			"light_directional_add" 		"rgb[90 90 90] attach[cam_inspect_light]"
			"light_directional_add" 		"rgb[4 8 10] dir[1 0.25 -1]"
			"light_directional_add" 		"rgb[4 8 10] dir[-1 -0.75 -1]"
			
			"root_mdl"					"models/inventory_items/pedestal_trophy.mdl"
			"root_anim"					"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"			"ACT_IDLE_INSPECT_LOOP"
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
			"root_mdl"					"models/weapons/pedestal_music_kits.mdl"
		}
	}
	
	"workshop"
	{
		"rule"
		{
			"workshop" "1"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"light_ambient"				"[.02 .02 .02]"
			"light_directional_add" 		"rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
			"root_mdl"					"models/weapons/pedestal_workshop.mdl"
			"mergemdls_clearall"			"1"
		}
	}
	
}
