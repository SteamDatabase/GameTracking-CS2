"Resource/UI/Econ/ItemModelPanelWorkshopWeaponPreview.res"
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
			"root_mdl"						"models/weapons/pedestal_default.mdl"		// Which pedestal model to load, weapon model is merged to the pedestal
			"root_anim"						"ACT_IDLE_INSPECT_PISTOL_START"				// Which activity to play on the pedestal
			"root_anim_loop"				"ACT_IDLE_INSPECT_PISTOL_LOOP"				// Which activity to play on the pedestal after the initial pedestal animation finishes
			"weapon_anim"					"ACT_IDLE_INSPECT"						// Which activity to play on the weapon
			"weapon_anim_loop"				"ACT_IDLE_INSPECT"						// Which activity to play on the weapon after the initial weapon animation finishes
			"root_camera"					"cam_inspect"								// Which attachment specifies camera location
			"root_camera_fov"				"54.0"									// Camera will use the specified FOV
			"light_ambient"					"[0.06 0.06 0.06]"							// Set the ambient lighting
			"light_directional_add" 		"rgb[190 190 196] dir[0 -0.3 -1]"			// Adds a directional light with color and direction
			"light_directional_add" 		"rgb[72 111 141] dir[0 -0.2 1]"			// Adds a directional light with color and direction
			"light_directional_add" 		"rgb[138 145 153] dir[-0.1 -0.2 -1]"			// Adds a directional light with color and direction
			"light_directional_add" 		"rgb[40 40 40] attach[cam_inspect]"		// Adds a directional light from the eye
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
			"weaponmergemdls_clearall"		"1"
			"mergemdl_add"			"models/weapons/stattrack_advert_small.mdl"			// Merge the advert to the pedestal
		}
	}
	
	"StatTrak_knives_UidNameTag"
	{
		"rule"
		{
			"nametag" "1"
			"type" "Knife"
		}
		"config"
		{
			"weaponmergemdl_add"		"models/weapons/uid_xsmall_weaponpreview.mdl"
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
			"light_ambient"					"[.02 .02 .02]"
			"light_directional_add" 		"rgb[50 50 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[120 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
			"root_mdl"						"models/weapons/pedestal_badges.mdl"
			"root_anim"						"ACT_IDLE_INSPECT_START"		
			"root_anim_loop"				"ACT_IDLE_INSPECT_LOOP"
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
			"light_ambient"					"[.02 .02 .02]"
			"light_directional_add" 		"rgb[60 60 60] dir[0 -1 -0.2]"
			"light_directional_add" 		"rgb[100 100 100] dir[0 -0.2 -1]"
			"light_directional_add" 		"rgb[100 100 100] attach[cam_inspect]"
			"light_directional_add" 		"rgb[18 18 20] dir[0 0 1]"
			"root_mdl"						"models/weapons/pedestal_workshop.mdl"
			"mergemdls_clearall"			"1"
		}
	}
	
	"workshop_greenscreen"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
		}
		"config"
		{
			"light_directional_clearall" 	"1"
			"light_directional_add" 		"rgb[40 40 40] dir[0 0 -0.5]"
			"light_directional_add" 		"rgb[25 25 25] dir[-0.2 1 1]"
			"light_directional_add" 		"rgb[20 20 20] dir[1 -0.2 -1]"
			"light_directional_add" 		"rgb[80 80 80] dir[0 0 1]"
			"root_mdl"						"models/weapons/pedestal_workshop_greenscreen.mdl"
			"mergemdls_clearall"			"1"
		}
	}

	"workshop_greenscreen_pistols"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"type"		"Pistol"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_near"
		}
	}

	"workshop_greenscreen_smgs"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"type"		"SubMachinegun"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_near"
		}
	}

	"workshop_greenscreen_sniperrifles"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"type"		"SniperRifle"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_far"
		}
	}

	"workshop_greenscreen_machineguns"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"type"		"Machinegun"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_far"
		}
	}

	"workshop_greenscreen_sawedoff"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"model"	"v_shot_sawedoff"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_near"
		}
	}

	"workshop_greenscreen_mag7"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"model"	"v_shot_mag7"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_near"
		}
	}
	
	"workshop_greenscreen_ump45"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"model"	"v_smg_ump45"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_near"
		}
	}
	
	"workshop_greenscreen_bizon"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"model"	"v_smg_bizon"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_near"
		}
	}
	
	"workshop_greenscreen_knives"
	{
		"rule"
		{
			"workshop_greenscreen"	"1"
			"type"		"Knife"
		}
		"config"
		{
			"shadow_light"	"cam_inspect_light_knife"
			"shadow_light_brightness" "2.0"
			"shadow_light_brightness" "0.0"
			"light_directional_clearall" 	"1"
			"light_directional_add" 		"rgb[255 255 255] dir[0 -.2 -0.5]"
			"light_directional_add" 		"rgb[255 255 255] dir[.5 .2 0.75]"
		}	
	}

	"workshop_arms"
	{
		"rule"
		{
			"workshop_arms" "1"
		}
		"config"
		{
			"root_mdl"						"models/weapons/pedestal_workshop_firstperson.mdl"
			"weapon_anim"					"ACT_VM_IDLE"
			"weapon_anim_loop"				"ACT_VM_IDLE"
			"root_anim"						"ACT_IDLE"
			"root_anim_loop"				"ACT_IDLE"
			"root_camera_fov"				"54.0"
		}
	}

	"workshop_arms_team_any"
	{
		"rule"
		{
			"workshop_arms" "1"
			"team"			"Any"
		}
		"config"
		{
			"weaponmergemdl_add"			"models/weapons/ct_arms_fbi.mdl"
		}
	}

	"workshop_arms_team_ct"
	{
		"rule"
		{
			"workshop_arms" "1"
			"team"			"CT"
		}
		"config"
		{
			"weaponmergemdl_add"			"models/weapons/ct_arms_sas.mdl"
		}
	}
	
	"workshop_arms_team_t"
	{
		"rule"
		{
			"workshop_arms" "1"
			"team"			"T"
		}
		"config"
		{
			"weaponmergemdl_add"			"models/weapons/t_arms_workbench_leet.mdl"
		}
	}
}
