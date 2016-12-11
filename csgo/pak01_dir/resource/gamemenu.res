"GameMenu"
{
	"1"
	{
		"label" "#GameUI_GameMenu_ResumeGame"
		"command" "ResumeGame"
		"OnlyInGame" "1"
	}
	"SwitchTeams"
	{
		"label" "#GameUI_GameMenu_SwitchTeams"
		"command" "SwitchTeams"
		"OnlyInGame" "1"
	}
	"2"
	{
		"label" "#GameUI_GameMenu_Disconnect"
		"command" "Disconnect"
		"OnlyInGame" "1"
	}
	"3" [$WIN32]
	{
		"label" "#GameUI_GameMenu_PlayerList"
		"command" "OpenPlayerListDialog"
		"OnlyInGame" "1"
	}
	"4"
	{
		"label" ""
		"command" ""
		"OnlyInGame" "1"
	}
//	"5" [$X360]
//	{
//		"label" "#GameUI_PlayOnlineQuickMatch"
//		"command" "OpenCreateMultiplayerQuickMatch"
//	}
//	"6" [$X360]
//	{
//		"label" "#GameUI_PlayOnlineCustomMatch"
//		"command" "OpenCreateMultiplayerGameDialog"
//	}
//	"7"
//	{
//		"label" "#GameUI_PlaySinglePlayer"
//		"command" "OpenCreateSinglePlayerGameDialog"
//		"MainMenuOnly" "1"
//	}
	"8" [$WIN32]
	{
		"label" "#GameUI_GameMenu_FindServers"
		"command" "OpenServerBrowser"
	}
	"9" [$WIN32]
	{
		"label" "#GameUI_GameMenu_CreateServer"
		"command" "OpenCreateMultiplayerGameDialog"
	}
	"10" [$WIN32]
	{
		"label" ""
		"command" ""
		"MainMenuOnly" "1"
	}
//	"11"
//	{
//		"label" "#GameUI_GameMenu_Achievements"
//		"command" "OpenCSAchievementsDialog"
//		"MainMenuOnly" "1"
//	}
//	"12"
//	{
//		"label" "#GameUI_ReportBug"
//		"command" "engine bug"
//	}
//	"13"
//	{
//		"label" "#GameUI_LaunchBenchmark"
//		"command" "OpenBenchmarkDialog"
//	}
	"14"
	{
		"label" "#GameUI_GameMenu_Options"
		"command" "OpenOptionsDialog"
		"PCOnly" "1"
	}
//	"15" [$X360]
//	{
//		"label" "#GameUI_GameMenu_Settings"
//		"command" "OpenSettingsDialog"
//	}
//	"16" [$X360]
//	{
//		"label" "#GameUI_Controls"
//		"command" "OpenControllerDialog"
//	}
	"17"
	{
		"label" "#GameUI_GameMenu_Quit"
		"command" "Quit"
	}
}

