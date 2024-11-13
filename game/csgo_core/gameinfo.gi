"GameInfo"
{
	game 		"CSGO Core"
	title 		"CSGO Core"
	
	type		multiplayer_only
	nomodels 1
	nohimodel 1
	l4dcrosshair 1
	nodegraph 0
	perfwizard 0
	tonemapping 1 // Show tonemapping ui in tools mode
	configconflictresolutiondialog 0
	GameData	"csgo.fgd"

	hidden_maps
	{
		"test_speakers"			1
		"test_hardware"			1
	}
	FileSystem
	{
		SteamAppId				710			// This will mount all the GCFs we need (240=CS:S, 220=HL2).

		//
		// The code that loads this file automatically does a few things here:
		//
		// 1. For each "Game" search path, it adds a "GameBin" path, in <dir>\bin
		// 2. For each "Game" search path, it adds another "Game" path in front of it with _<langage> at the end.
		//    For example: c:\hl2\cstrike on a french machine would get a c:\hl2\cstrike_french path added to it.
		// 3. If no "Mod" key, for the first "Game" search path, it adds a search path called "MOD".
		// 4. If no "Write" key, for the first "Game" search path, it adds a search path called "DEFAULT_WRITE_PATH".
		//

		//
		// Search paths are relative to the exe directory\..\
		//
		SearchPaths
		{
			Game				csgo_core
			Game				core
		}
	}

	MaterialSystem2
	{
		RenderModes
		{
			"game" "Default"
			"game" "CsgoForward"
			"game" "Depth"
			"game" "ProjectionDepth"
			"game" "Decals"
			"game" "Forward"
			"game" "GBuffer" // For Particle Shadows
			"game" "FirstpersonLegsPrepass"

			"dev" "ToolsShadingComplexity"
			"dev" "ToolsVis" // Visualization modes for all shaders (lighting only, normal maps only, etc.)
			"dev" "ToolsWireframe" // This should use the ToolsVis mode above instead of being its own mode
			"tools" "ToolsUtil" // Meant to be used to render tools sceneobjects that are mod-independent, like the origin grid
		}

		ToolsShadingComplexity
		{
			"TargetRenderMode" "CsgoForward"
		}

		ShaderIDColors
		{
			"generic.vfx" "255 255 255"

			"csgo_simple.vfx" "128 128 128"
			"csgo_complex.vfx" "64 32 128"
			"csgo_vertexlitgeneric.vfx" "240 0 0"
			"csgo_unlitgeneric.vfx" "240 32 192"
			"csgo_lightmappedgeneric.vfx" "128 0 0"

			"csgo_character.vfx" "0 0 255"
			"csgo_static_overlay.vfx" "0 255 255"
			"csgo_projected_decals.vfx" "0 128 128"
			"csgo_environment.vfx" "128 192 64"
			"csgo_environment_blend.vfx" "64 128 0"
			"csgo_glass.vfx" "128 32 128"
			"csgo_weapon.vfx" "192 128 64"
			"csgo_water_fancy.vfx" "64 128 240"

			"cables.vfx" "128 64 64"
			"spritecard.vfx" "240 240 0"
		}

		"ErrorMaterialIsFatalError"	"1"
	}

	MaterialEditor
	{
		"DefaultShader" "csgo_simple"
		"DefaultAutoPromptForShaderOnNewMaterialCreation" "1"
	}
	
	Panorama
	{
		"AllowGlobalPanelContext" "1"
		"HtmlUserAgent" "CSGO Client"
		"AllowCustomGameUI" 0
	}

	Engine2
	{
		"HasModAppSystems" "1"
		"Capable64Bit" "1"
		"URLName" "csgo"
		"DefaultRenderSystem"					"-dx11"
		"DefaultToolsRenderSystem"				"-dx11"
		"SupportsVulkanParticleOptimizations"	"1"
		"RenderingPipeline"
		{
			"SkipPostProcessing" "0"
			"SupportsMSAA" "1"
			//"SkipGameOverlay" "1"
			"PostProcessingInMainPipeline" "1"
			"ToolsVisModes" "1"
			"OpaqueFade" "1"
			"AmbientOcclusionProxies" "1"
			"HighPrecisionLighting" "1" 

			"Tonemapping_UseLogLuminance" "1"	// for the filmic tonemapper
			// Defaults for maps without a env_tonemap_controller
			"Tonemapping_DefaultAutoExposureMin" "1.0"
			"Tonemapping_DefaultAutoExposureMax" "1.0"
			"Tonemapping_DefaultRate" "0.2"
			"Tonemapping_DefaultFilmicLinear" "1"
		}
		"SetUILanguageOnSteamDropDown" "1" // csgo language is controlled by steam, both audio and ui localization strings
		"HasLegacyGameUI" "1" // csgo uses some legacy gameui systems
		// Default MSAA sample count when run in non-VR mode
		"MSAADefaultNonVR"	"4" 
		"DefensiveConCommands"	"1"
		"PauseSinglePlayerOnGameOverlay" "1"
		"PauseOnCtrlConsole" "0" // Src2 issues a 'setpause' on holding down CTRL + toggleconsole key, disable this for CS2.
		"RestrictConsoleCloseKey" "`"	// This setting stipulates that if the binding for toggleconsole is set to anything other
										// than the default KEY_BACKQUOTE, then it only works for opening the console, not closing.
										// ESC can always be used to close the console regardless of this setting.
										// This matches csgo src1 behaviour.
	}

	NetworkSystem
	{
		BetaUniverse
		{
			"FakeLag"			"40"
			"FakeLoss"			".1"
			"FakeJitter"		"low"

			"TimeTable"
			{
				// LAN conditions at noon local time
				"120000"
				{
					"FakeLag"			"0"
					"FakeLoss"			"0"
					"FakeReorderPct"	"0"
					"FakeReorderDelay"	"0"
					"FakeJitter"		"off"
				}
				// Back to more realistic internet conditions 2:45:00 PM local time
				"144500"
				{
				}
			}
		}
	}

	Particles
	{
		"ParticlesFoggedByDefault"	"1"
		"EnableParticleShaderFeatureBranching"	"1"
		"ParticlePixelCBSlot" "4"
		"ParticleVertexCBSlot" "4"
		"ParticleTextureBaseSlot" "8"
		"EnableMixedResolution" "1"
		"ParticleTraceOffsetOnlyHit" "1"
		"PET_SupportFadingOpaqueModels" "1"
	}

	SceneSystem
	{
		"GpuLightBinner" "1"
		"GpuLightBinnerSunLightFastPath" "1"
		"GpuLightBinnerBinEnvMaps" "1"
		"GpuLightBinnerBinLPVs" "0"
		"GpuLightBinnerSupportViewModelCascade" "1"
		"DynamicShadowResolution" "1"
		"DefaultShadowTextureWidth" "4096"
		"DefaultShadowTextureHeight" "4096"
		"ShadowTextureImageFormat_D16" "1"		// would like to enable this for CS2 soon to test D16 shadows (separately from SparseShadowTrees)
		"SparseShadowTrees" "1"					// enable this to experiment with Sparse Shadow Trees as a drop in replacement for static geo shadow rendering into cascades
		"PointLightShadowsEnabled" "1"
		"Tonemapping"	"1"
		"NonTexturedGradientFog" "1"
		"CubemapFog" "1"
		"BloomEnabled" "1"
		"HDRFrameBuffer" "1"
		"DisableShadowFullSort" "1"
		"PerObjectLightingSetup" "1"
		"CharacterDecals" "1"
		"FirstpersonLegs" "1"

		"CSMCascadeResolution" "2048"
		"SunLightManagerCount" "0"
		"SunLightManagerCountTools" "0"

		"LightCookieAllocGranularity" "1"
		"LightCookieMinAllocSize" "0"

		WellKnownLightCookies
		{
			"blank" "materials/effects/lightcookies/blank.vtex"
			"flashlight" "materials/effects/lightcookies/flashlight.vtex"
			"muzzleflash" "materials/effects/lightcookies/muzzleflash.vtex"
		}

		"TransformTextureRowCount" "512"
		"TransformTextureRowCountToolsMode" "8192"
		"CMTAtlasWidth" "1024"
		"CMTAtlasHeight" "512"
		"CMTAtlasChunkSize" "128"

		"DynamicDecalsUseShrinkWrap" "1"	// enable shrinkwrap optimization for dynamic decal materials using F_FASTAPPROX

		"ComputeShaderSkinning" "1"
	}

	ToolsEnvironment
	{
		"Engine"	"Source 2"
		"ToolsDir"	"../sdktools"	// NOTE: Default Tools path. This is relative to the mod path.
		"RestrictWorkshopItemTools"	"1"
	}
	
	Hammer
	{
		fgd_files
		{
			"csgo.fgd"					"1"
			"csgo_internal.fgd"			"1"
		}
		"GameFeatureSet"				"CounterStrike"
		"DefaultTextureScale"			"0.125000"
		"DefaultSolidEntity"			"trigger_multiple"
		"DefaultPointEntity"			"info_player_start"
		"NavMarkupEntity"				"func_nav_markup"
		"RenderMode"					"ToolsVis"
		"TileMeshesEnabled"				"1"
		"TileGridSupportsBlendHeight"	"1"
		"TileGridBlendDefaultColor"		"0 255 0"
		"LoadScriptEntities"			"0"
		"UsesBakedLighting"				"1"
		"ShadowAtlasWidth"				"6144"
		"ShadowAtlasHeight"				"6144"
		"TimeSlicedShadowMapRendering"	"1"
		"TerrainTools"					"1"
		"DefaultGrassMaterial"			"materials/grass/grassquad1.vmat"
		"SteamAudioEnabled"				"1"
		"AddonMapCommand"				"map_workshop"
		"LatticeDeformerEnabled"		"1"
	}

	RenderPipelineAliases
	{
		"Tools"			"CSGO"
		"EnvMapBake"	"CSGO"
	}

	Source1Import
	{
		"importmod"			"csgo"
		"importdir"			"..\csgo_imported"

		"createStaticOverlays" 	  "1"	// if "1" create static overlays from s1 info_overlays, if "0" will treat them as s2 projected decals.
		"createPathParticleRopes" "1"   // convert s1 move_rope/keyframe_rope chained entities to path_particle_rope system in s2.
		"fixup3DSkybox" 		  "1"   // if a func_instance contains a 3d skybox vmf (contains a sky_camera entity), does the s2 fixup accordingly, 
										// otherwise the skybox will end up part of the main map and will need to be fixed up by hand 
										// (as is the common case in s1 where maps have the skybox already part of the main map).
		"removeHiddenNodes"		  "1"   // 0 => hidden nodes in vmf are imported but marked as visible=false, startenabled=false, 1 => ignore hidden nodes on import
		"loadBSPDetailData"       "1"	// 1 => Load map file .bsp for detail object system (foliage) data.
	}

	BugReporter
	{
		"AutoBugProduct" "CS:GO"
		"AutoBugComponent" "Source2"
	}

	ResourceCompiler
	{
		// Overrides of the default builders as specified in code, this controls which map builder steps
		// will be run when resource compiler is run for a map without specifiying any specific map builder
		// steps. Additionally this controls which builders are displayed in the hammer build dialog.
		DefaultMapBuilders
		{			
			"bakedlighting"	"1"	// Enable lightmapping during compile time
			"nav"		"1"	// Generate nav mesh data
			"light"		"0"	// Using per-vertex indirect lighting baked from within hammer
			"envmap"	"0"	// this is broken
			"sareverb"	"1" // Bake Steam Audio reverb
			"sapaths"	"1" // Bake Steam Audio pathing info
		}

		MeshCompiler
		{
			PerDrawCullingData      "1"
			EncodeVertexBuffer      "1"
			EncodeIndexBuffer       "1"
			UseMikkTSpace           "1"
			MeshletConeWeight       ".15"
		}

		WorldRendererBuilder
		{
			FixTJunctionEdgeCracks  		"1"
			VisibilityGuidedMeshClustering		"1"
			MinimumTrianglesPerClusteredMesh	"2048"
			MinimumVerticesPerClusteredMesh		"2048"
			MinimumVolumePerClusteredMesh		"1800"		// ~12x12x12 cube
			MaxPrecomputedVisClusterMembership	"16"
			UseAggregateInstances			"1"
			AggregateInstancingMeshlets			"1"
			UseStaticEnvMapForObjectsWithLightingOrigin	"1"
		}

// Optimisation for Hammer Mesh Physics

		PhysicsBuilder
		{
			DefaultHammerMeshSimplification		"0.0"
		}

		BakedLighting
		{
			Version 2
			DisableCullingForShadows 1
			MinSpecLightmapSize 4096
            ImportanceVolumeTransitionRegion 120            // distance we transition from high to low resolution charts 
                                                            // when a triangle is outside an importance volume
			LPVAtlas 1
			LPVOctree 0
			LightmapChannels
			{
				irradiance 1
				direct_light_shadows 1

				directional_irradiance
				{
					MaxResolution 4096
					CompressedFormat DXT1
				}

				debug_chart_color
				{
					MaxResolution 4096
					CompressedFormat DXT1
				}
			}
		}

		VisBuilder
		{
			MaxVisClusters "4096"
			PreMergeOpenSpaceDistanceThreshold "128.0"
			PreMergeOpenSpaceMaxDimension "2048.0"
			PreMergeOpenSpaceMaxRatio "8.0"
			PreMergeSmallRegionsSizeThreshold "20.0"
		}

		SteamAudio
		{
			ReverbDefaults
			{
				GridSpacing			"3.0"
				HeightAboveFloor	"1.5"
				RebakeOption		"1"						// 0: cleanup, 1: manual, 2: auto
				NumRays				"32768"
				NumBounces			"64"
				IRDuration			"1.0"
				AmbisonicsOrder		"1"
			}
			PathingDefaults
			{
				GridSpacing			"3.0"
				HeightAboveFloor	"1.5"
				RebakeOption		"1"						// 0: cleanup, 1: manual, 2: auto
				NumVisSamples		"1"
				ProbeVisRadius		"0"
				ProbeVisThreshold	"0.1"
				ProbeVisPathRange	"1000.0"
			}
		}

		TextureCompiler
		{
			//Compressor              "lz4"
			Compressor              "mermaid"
			//Compressor              "kraken" 
			CompressMipsOnDisk      "1"
			CompressMinRatio        "95"
			AllowNP2Textures		"1"
			AllowPanoramaMipGeneration	"1"
			PublicToolsDefaultMaxRes "2048"
		}
	}

	NavSystem
	{
		"NavTileSize" "128.0"
		"NavCellSize" "1.5"
		"NavCellHeight" "2.0"

		// Hull definitions live in scripts/nav_hulls.vdata
		// Preset definitions live in scripts/nav_hulls_presets.vdata
		"NavHullsPreset" "default"

		"NavRegionMinSize" "8"
		"NavRegionMergeSize" "20"
		"NavEdgeMaxLen" "1200"
		"NavEdgeMaxError" "45.0"
		"NavVertsPerPoly" "4"
		"NavDetailSampleDistance" "120.0"
		"NavDetailSampleMaxError" "2.0"
		"NavSmallAreaOnEdgeRemovalSize" "-1.0"
	}

	CustomNavBuild
	{
		ModuleName "server.dll"
		Interface  "customnavsystem001"
	}
	
	WorldRenderer
	{
		"IrradianceVolumes"		"0"
		"EnvironmentMaps"		"1"
		"EnvironmentMapBlurType"  "GGX"
		"EnvironmentMapFaceSize"	"256"
		"EnvironmentMapRenderSize"	"1024"
		"EnvironmentMapFormat"		"BC6H"
		"EnvironmentMapPreviewFormat"	"BC6H"
		//"EnvironmentMapPreviewFormat" "RGBA16161616F"
		"EnvironmentMapColorSpace"	"linear"
		"EnvironmentMapMipProcessor"	"GGXCubeMapBlur"
		// Build cubemaps into a cube array instead of individual cubemaps?
		"EnvironmentMapUseCubeArray"	"1"
		// instead of dynamically creating an atlas, we require a single array (built offline, see
		// EnvironmentMapUseCubeArray) per map and between maps cubemaps don't interact.
		//"EnvironmentMapCacheSize"		"144"
		// For tools mode we still need to use the runtime texture array
		"EnvironmentMapCacheSizeTools"	"340"
		"GrassQuadSize"		"512"
		"GrassCompressDensity" "0"
		"GrassDilateColors"	"0"
		"GrassNoHalfTexel"	"1"
		"LPVEdgeBlending"	"0"	// Don't apply the edge fade distance to LPV bounds, we don't blend LPVs in CS2 shaders
	}

	ModelDoc
	{
		"models_gamedata"			"models_gamedata.fgd"
		"features"					"cs2;modelconfig;animgraph;animgraph_compatibility_force;editorconfig;gamepreview"
		"firstpersoncamerapreview"	"1"
	}

	RenderSystem
	{
		"SwapChainSampleableDepth"					"1"
		"AllowPartialMipChainImmediateTexLoads"		"1"
		"VulkanSteamShaderCache"					"1"
		"VulkanOnly"								"1"	[ $LINUX || $OSX ] // No OpenGL or D3D9/11 fallback on Linux or OSX, only Vulkan is supported.
		"VulkanRequireSubgroupWaveOpSupport"			"1"	[ !$OSX ]
		"VulkanRequireDescriptorIndexing"			"1"	[ !$OSX ]
		"VulkanAdditionalShaderCache"				"csgo_shaders.foz"	[ $OSX ]
		//"AlwaysPreloadTexturesInGame"				"1"
		//"MaxPreloadTextureResolution"				"256"
		"GraphicsPipelineLibrary"					"1"
		"IndexBufferPoolSizeMB"						"64"
		"LowLatency"								"1"
		"MinDXLevel"								"110" // DX 11.0 is the minimum
		"MinStreamingPoolSizeMB"					"500"
		"MinStreamingPoolSizeMBTools"				"2048"
		"UseHardwareGammaRamp"						"0" // Fullscreen gamma controlled in postprocessing
	}

	Manifest
	{
		"GenerateVPKManifest" "1"
	}

	PostProcessingEditor
	{
		"supports_local_contrast"	"1"
		"filmic_linear_scale" 		"1"
	}

	SoundSystem
	{
		"SteamAudioEnabled"            "1"
		Budget_StackSimulationUS		25
		Budget_FirstStackSimulationUS	50
	}

	Licenses
	{
		//OodleTexture    "0"
		//OodleLZ         "0"
	}

	ConVars
	{
        "cl_joystick_enabled" "0"
        "panorama_joystick_enabled" "0"
	}

	Memory
	{
		"EstimatedMaxCPUMemUsageMB"	"3388"
		"EstimatedMinGPUMemUsageMB"	"1246"
	}
}
