"use strict";
/// <reference path="../csgo.d.ts" />
var g_PromotedSettingsVersion = 1;
var g_PromotedSettings = [
    {
        id: "BuyMenuDonationKey",
        loc_name: "#SFUI_Settings_BuyWheelDonateKey",
        loc_desc: "#SFUI_Settings_BuyWheelDonateKey_Info",
        section: "GameSettings",
        start_date: new Date('December 17, 2020'),
        end_date: new Date('April 31, 2021'),
    },
    {
        id: "SettingsChatWheel",
        loc_name: "#settings_ui_chatwheel_section",
        loc_desc: "#Chatwheel_description",
        section: "KeybdMouseSettings",
        start_date: new Date('November 25, 2020'),
        end_date: new Date('April 30, 2021'),
    },
    {
        id: "SettingsCommunicationSettings",
        loc_name: "#SFUI_Settings_FilterText_Title",
        loc_desc: "#SFUI_Settings_FilterText_Title_Tooltip",
        section: "GameSettings",
        start_date: new Date('June 11, 2020'),
        end_date: new Date('June 30, 2020')
    },
    {
        id: "MainMenuMovieSceneSelector",
        loc_name: "#GameUI_MainMenuMovieScene",
        loc_desc: "#GameUI_MainMenuMovieScene_Tooltip",
        section: "VideoSettings",
        subsection: "SimpleVideoSettingsRadio",
        start_date: new Date('May 26, 2020'),
        end_date: new Date('June 15, 2020')
    },
    {
        id: "XhairShowObserverCrosshair",
        loc_name: "#GameUI_ShowObserverCrosshair",
        loc_desc: "#GameUI_ShowObserverCrosshair_Tooltip",
        section: "GameSettings",
        start_date: new Date('April 15, 2020'),
        end_date: new Date('May 1, 2020')
    },
    {
        id: "SettingsCrosshair",
        loc_name: "#settings_crosshair",
        loc_desc: "#settings_crosshair_info",
        section: "GameSettings",
        start_date: new Date('February 24, 2019'),
        end_date: new Date('March 28, 2020')
    },
    {
        id: "ClutchKey",
        loc_name: "#GameUI_Clutch_Key",
        loc_desc: "#GameUI_Clutch_Key_Tooltip",
        section: "KeybdMouseSettings",
        start_date: new Date('September 21, 2019'),
        end_date: new Date('January 30, 2020')
    },
    {
        id: "id-friendlyfirecrosshair",
        loc_name: "#GameUI_FriendlyWarning",
        loc_desc: "#GameUI_FriendlyWarning_desc",
        section: "GameSettings",
        start_date: new Date('October 7, 2019'),
        end_date: new Date('February 30, 2020')
    },
    {
        id: "SettingsCommunicationSettings",
        loc_name: "#settings_comm_binds_section",
        loc_desc: "#settings_comm_binds_info",
        section: "GameSettings",
        start_date: new Date('September 13, 2019'),
        end_date: new Date('January 30, 2020')
    },
    {
        id: "RadialWepMenuBinder",
        loc_name: "#SFUI_RadialWeaponMenu",
        loc_desc: "#SFUI_RadialWeaponMenu_Desc",
        section: "KeybdMouseSettings",
        start_date: new Date('September 18, 2019'),
        end_date: new Date('January 30, 2020')
    },
    {
        id: "XhairRecoil",
        loc_name: "#GameUI_CrosshairRecoil",
        loc_desc: "#GameUI_CrosshairRecoil_Desc",
        section: "GameSettings",
        start_date: new Date('August 21, 2023'),
        end_date: new Date('January 30, 2024')
    },
    {
        id: "ZoomButtonHold",
        loc_name: "#ZoomButtonHold",
        loc_desc: "#ZoomButtonHold_Desc",
        section: "KeybdMouseSettings",
        start_date: new Date('August 21, 2023'),
        end_date: new Date('January 30, 2024')
    },
    {
        id: "FiddleWithSilencers",
        loc_name: "#Cstrike_Fiddle_With_Silencers",
        loc_desc: "#Cstrike_Fiddle_With_Silencers_Desc",
        section: "GameSettings",
        start_date: new Date('August 21, 2023'),
        end_date: new Date('January 30, 2024')
    },
    {
        id: "AllowAnimatedAvatars",
        loc_name: "#Settings_AllowAnimatedAvatars_Title",
        loc_desc: "#Settings_AllowAnimatedAvatars_Title_Tooltip",
        section: "GameSettings",
        start_date: new Date('September 12, 2023'),
        end_date: new Date('January 30, 2024')
    },
    {
        id: "ReplaceAvatarsWithPlayerCount",
        loc_name: "#SFUI_Settings_MiniScoreboardPlayerCount",
        loc_desc: "#SFUI_Settings_MiniScoreboardPlayerCount_Tooltip",
        section: "GameSettings",
        start_date: new Date('October 11, 2023'),
        end_date: new Date('January 30, 2024')
    },
    {
        id: "NetworkProblemAutoShow",
        loc_name: "#SFUI_Settings_Network_ProblemAutoShow",
        loc_desc: "#SFUI_Settings_Network_ProblemAutoShow_Info",
        section: "GameSettings",
        start_date: new Date('October 11, 2023'),
        end_date: new Date('February 28, 2024')
    },
]
    .reverse();
var PromotedSettingsUtil = (function () {
    function _GetUnacknowledgedPromotedSettings() {
        const settingsInfo = GameInterfaceAPI.GetSettingString("cl_promoted_settings_acknowledged").split(':');
        const version = parseInt(settingsInfo.shift());
        const arrNewSettings = [];
        if (0) {
            const timeLastViewed = new Date(parseInt(settingsInfo.shift()));
            for (const setting of g_PromotedSettings) {
                const now = new Date();
                if (setting.start_date > timeLastViewed && setting.start_date <= now)
                    arrNewSettings.push(setting);
            }
        }
        else {
            const now = new Date();
            return g_PromotedSettings.filter(setting => setting.start_date <= now && setting.end_date > now);
        }
        return arrNewSettings;
    }
    const hPromotedSettingsViewedEvt = $.RegisterForUnhandledEvent("MainMenu_PromotedSettingsViewed", function (id) {
        GameInterfaceAPI.SetSettingString("cl_promoted_settings_acknowledged", "" + g_PromotedSettingsVersion + ":" + Date.now());
        $.UnregisterForUnhandledEvent("MainMenu_PromotedSettingsViewed", hPromotedSettingsViewedEvt);
    });
    return {
        GetUnacknowledgedPromotedSettings: _GetUnacknowledgedPromotedSettings
    };
}());
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicHJvbW90ZWRfc2V0dGluZ3MuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vcHJvbW90ZWRfc2V0dGluZ3MudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQUdyQyxJQUFJLHlCQUF5QixHQUFHLENBQUMsQ0FBQztBQWFsQyxJQUFJLGtCQUFrQixHQUF3QjtJQWlCN0M7UUFDQyxFQUFFLEVBQUUsb0JBQW9CO1FBQ3hCLFFBQVEsRUFBRSxrQ0FBa0M7UUFDNUMsUUFBUSxFQUFFLHVDQUF1QztRQUNqRCxPQUFPLEVBQUUsY0FBYztRQUN2QixVQUFVLEVBQUUsSUFBSSxJQUFJLENBQUUsbUJBQW1CLENBQUU7UUFDM0MsUUFBUSxFQUFFLElBQUksSUFBSSxDQUFFLGdCQUFnQixDQUFFO0tBQ3RDO0lBQ0Q7UUFDQyxFQUFFLEVBQUUsbUJBQW1CO1FBQ3ZCLFFBQVEsRUFBRSxnQ0FBZ0M7UUFDMUMsUUFBUSxFQUFFLHdCQUF3QjtRQUNsQyxPQUFPLEVBQUUsb0JBQW9CO1FBQzdCLFVBQVUsRUFBRSxJQUFJLElBQUksQ0FBRSxtQkFBbUIsQ0FBRTtRQUMzQyxRQUFRLEVBQUUsSUFBSSxJQUFJLENBQUUsZ0JBQWdCLENBQUU7S0FDdEM7SUFDRDtRQUNDLEVBQUUsRUFBRSwrQkFBK0I7UUFHbkMsUUFBUSxFQUFFLGlDQUFpQztRQUMzQyxRQUFRLEVBQUUseUNBQXlDO1FBQ25ELE9BQU8sRUFBRSxjQUFjO1FBQ3ZCLFVBQVUsRUFBRSxJQUFJLElBQUksQ0FBRSxlQUFlLENBQUU7UUFDdkMsUUFBUSxFQUFFLElBQUksSUFBSSxDQUFFLGVBQWUsQ0FBRTtLQUNyQztJQUNEO1FBQ0MsRUFBRSxFQUFFLDRCQUE0QjtRQUNoQyxRQUFRLEVBQUUsNEJBQTRCO1FBQ3RDLFFBQVEsRUFBRSxvQ0FBb0M7UUFDOUMsT0FBTyxFQUFFLGVBQWU7UUFDeEIsVUFBVSxFQUFFLDBCQUEwQjtRQUN0QyxVQUFVLEVBQUUsSUFBSSxJQUFJLENBQUUsY0FBYyxDQUFFO1FBQ3RDLFFBQVEsRUFBRSxJQUFJLElBQUksQ0FBRSxlQUFlLENBQUU7S0FDckM7SUFDRDtRQUNDLEVBQUUsRUFBRSw0QkFBNEI7UUFDaEMsUUFBUSxFQUFFLCtCQUErQjtRQUN6QyxRQUFRLEVBQUUsdUNBQXVDO1FBQ2pELE9BQU8sRUFBRSxjQUFjO1FBQ3ZCLFVBQVUsRUFBRSxJQUFJLElBQUksQ0FBRSxnQkFBZ0IsQ0FBRTtRQUN4QyxRQUFRLEVBQUUsSUFBSSxJQUFJLENBQUUsYUFBYSxDQUFFO0tBQ25DO0lBQ0Q7UUFDQyxFQUFFLEVBQUUsbUJBQW1CO1FBQ3ZCLFFBQVEsRUFBRSxxQkFBcUI7UUFDL0IsUUFBUSxFQUFFLDBCQUEwQjtRQUNwQyxPQUFPLEVBQUUsY0FBYztRQUN2QixVQUFVLEVBQUUsSUFBSSxJQUFJLENBQUUsbUJBQW1CLENBQUU7UUFDM0MsUUFBUSxFQUFFLElBQUksSUFBSSxDQUFFLGdCQUFnQixDQUFFO0tBQ3RDO0lBQ0Q7UUFDQyxFQUFFLEVBQUUsV0FBVztRQUNmLFFBQVEsRUFBRSxvQkFBb0I7UUFDOUIsUUFBUSxFQUFFLDRCQUE0QjtRQUN0QyxPQUFPLEVBQUUsb0JBQW9CO1FBQzdCLFVBQVUsRUFBRSxJQUFJLElBQUksQ0FBRSxvQkFBb0IsQ0FBRTtRQUM1QyxRQUFRLEVBQUUsSUFBSSxJQUFJLENBQUUsa0JBQWtCLENBQUU7S0FDeEM7SUFDRDtRQUNDLEVBQUUsRUFBRSwwQkFBMEI7UUFDOUIsUUFBUSxFQUFFLHlCQUF5QjtRQUNuQyxRQUFRLEVBQUUsOEJBQThCO1FBQ3hDLE9BQU8sRUFBRSxjQUFjO1FBQ3ZCLFVBQVUsRUFBRSxJQUFJLElBQUksQ0FBRSxpQkFBaUIsQ0FBRTtRQUN6QyxRQUFRLEVBQUUsSUFBSSxJQUFJLENBQUUsbUJBQW1CLENBQUU7S0FDekM7SUFDRDtRQUNDLEVBQUUsRUFBRSwrQkFBK0I7UUFDbkMsUUFBUSxFQUFFLDhCQUE4QjtRQUN4QyxRQUFRLEVBQUUsMkJBQTJCO1FBQ3JDLE9BQU8sRUFBRSxjQUFjO1FBQ3ZCLFVBQVUsRUFBRSxJQUFJLElBQUksQ0FBRSxvQkFBb0IsQ0FBRTtRQUM1QyxRQUFRLEVBQUUsSUFBSSxJQUFJLENBQUUsa0JBQWtCLENBQUU7S0FDeEM7SUFDRDtRQUNDLEVBQUUsRUFBRSxxQkFBcUI7UUFDekIsUUFBUSxFQUFFLHdCQUF3QjtRQUNsQyxRQUFRLEVBQUUsNkJBQTZCO1FBQ3ZDLE9BQU8sRUFBRSxvQkFBb0I7UUFDN0IsVUFBVSxFQUFFLElBQUksSUFBSSxDQUFFLG9CQUFvQixDQUFFO1FBQzVDLFFBQVEsRUFBRSxJQUFJLElBQUksQ0FBRSxrQkFBa0IsQ0FBRTtLQUN4QztJQUNEO1FBQ0MsRUFBRSxFQUFFLGFBQWE7UUFDakIsUUFBUSxFQUFFLHlCQUF5QjtRQUNuQyxRQUFRLEVBQUUsOEJBQThCO1FBQ3hDLE9BQU8sRUFBRSxjQUFjO1FBQ3ZCLFVBQVUsRUFBRSxJQUFJLElBQUksQ0FBRSxpQkFBaUIsQ0FBRTtRQUN6QyxRQUFRLEVBQUUsSUFBSSxJQUFJLENBQUUsa0JBQWtCLENBQUU7S0FDeEM7SUFDRDtRQUNDLEVBQUUsRUFBRSxnQkFBZ0I7UUFDcEIsUUFBUSxFQUFFLGlCQUFpQjtRQUMzQixRQUFRLEVBQUUsc0JBQXNCO1FBQ2hDLE9BQU8sRUFBRSxvQkFBb0I7UUFDN0IsVUFBVSxFQUFFLElBQUksSUFBSSxDQUFFLGlCQUFpQixDQUFFO1FBQ3pDLFFBQVEsRUFBRSxJQUFJLElBQUksQ0FBRSxrQkFBa0IsQ0FBRTtLQUN4QztJQUNEO1FBQ0MsRUFBRSxFQUFFLHFCQUFxQjtRQUN6QixRQUFRLEVBQUUsZ0NBQWdDO1FBQzFDLFFBQVEsRUFBRSxxQ0FBcUM7UUFDL0MsT0FBTyxFQUFFLGNBQWM7UUFDdkIsVUFBVSxFQUFFLElBQUksSUFBSSxDQUFFLGlCQUFpQixDQUFFO1FBQ3pDLFFBQVEsRUFBRSxJQUFJLElBQUksQ0FBRSxrQkFBa0IsQ0FBRTtLQUN4QztJQUNEO1FBQ0MsRUFBRSxFQUFFLHNCQUFzQjtRQUMxQixRQUFRLEVBQUUsc0NBQXNDO1FBQ2hELFFBQVEsRUFBRSw4Q0FBOEM7UUFDeEQsT0FBTyxFQUFFLGNBQWM7UUFDdkIsVUFBVSxFQUFFLElBQUksSUFBSSxDQUFFLG9CQUFvQixDQUFFO1FBQzVDLFFBQVEsRUFBRSxJQUFJLElBQUksQ0FBRSxrQkFBa0IsQ0FBRTtLQUN4QztJQUNEO1FBQ0MsRUFBRSxFQUFFLCtCQUErQjtRQUNuQyxRQUFRLEVBQUUsMENBQTBDO1FBQ3BELFFBQVEsRUFBRSxrREFBa0Q7UUFDNUQsT0FBTyxFQUFFLGNBQWM7UUFDdkIsVUFBVSxFQUFFLElBQUksSUFBSSxDQUFFLGtCQUFrQixDQUFFO1FBQzFDLFFBQVEsRUFBRSxJQUFJLElBQUksQ0FBRSxrQkFBa0IsQ0FBRTtLQUN4QztJQUNEO1FBQ0MsRUFBRSxFQUFFLHdCQUF3QjtRQUM1QixRQUFRLEVBQUUsd0NBQXdDO1FBQ2xELFFBQVEsRUFBRSw2Q0FBNkM7UUFDdkQsT0FBTyxFQUFFLGNBQWM7UUFDdkIsVUFBVSxFQUFFLElBQUksSUFBSSxDQUFFLGtCQUFrQixDQUFFO1FBQzFDLFFBQVEsRUFBRSxJQUFJLElBQUksQ0FBRSxtQkFBbUIsQ0FBRTtLQUN6QztDQUNEO0tBQ0EsT0FBTyxFQUFFLENBQUM7QUFFWCxJQUFJLG9CQUFvQixHQUFHLENBQUU7SUFFNUIsU0FBUyxrQ0FBa0M7UUFFMUMsTUFBTSxZQUFZLEdBQUcsZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUsbUNBQW1DLENBQUUsQ0FBQyxLQUFLLENBQUUsR0FBRyxDQUFFLENBQUM7UUFDM0csTUFBTSxPQUFPLEdBQUcsUUFBUSxDQUFFLFlBQVksQ0FBQyxLQUFLLEVBQUcsQ0FBRSxDQUFDO1FBQ2xELE1BQU0sY0FBYyxHQUF3QixFQUFFLENBQUM7UUFFL0MsSUFBSyxDQUFDLEVBQ047WUFFQyxNQUFNLGNBQWMsR0FBRyxJQUFJLElBQUksQ0FBRSxRQUFRLENBQUUsWUFBWSxDQUFDLEtBQUssRUFBRyxDQUFFLENBQUUsQ0FBQztZQUNyRSxLQUFNLE1BQU0sT0FBTyxJQUFJLGtCQUFrQixFQUN6QztnQkFDQyxNQUFNLEdBQUcsR0FBRyxJQUFJLElBQUksRUFBRSxDQUFDO2dCQUN2QixJQUFLLE9BQU8sQ0FBQyxVQUFVLEdBQUcsY0FBYyxJQUFJLE9BQU8sQ0FBQyxVQUFVLElBQUksR0FBRztvQkFDcEUsY0FBYyxDQUFDLElBQUksQ0FBRSxPQUFPLENBQUUsQ0FBQzthQUNoQztTQUNEO2FBRUQ7WUFHQyxNQUFNLEdBQUcsR0FBRyxJQUFJLElBQUksRUFBRSxDQUFDO1lBQ3ZCLE9BQU8sa0JBQWtCLENBQUMsTUFBTSxDQUFFLE9BQU8sQ0FBQyxFQUFFLENBQUMsT0FBTyxDQUFDLFVBQVUsSUFBSSxHQUFHLElBQUksT0FBTyxDQUFDLFFBQVEsR0FBRyxHQUFHLENBQUUsQ0FBQztTQUNuRztRQUNELE9BQU8sY0FBYyxDQUFDO0lBQ3ZCLENBQUM7SUFHRCxNQUFNLDBCQUEwQixHQUFHLENBQUMsQ0FBQyx5QkFBeUIsQ0FBRSxpQ0FBaUMsRUFBRSxVQUFXLEVBQUU7UUFHL0csZ0JBQWdCLENBQUMsZ0JBQWdCLENBQUUsbUNBQW1DLEVBQUUsRUFBRSxHQUFHLHlCQUF5QixHQUFHLEdBQUcsR0FBRyxJQUFJLENBQUMsR0FBRyxFQUFFLENBQUUsQ0FBQztRQUM1SCxDQUFDLENBQUMsMkJBQTJCLENBQUUsaUNBQWlDLEVBQUUsMEJBQTBCLENBQUUsQ0FBQztJQUNoRyxDQUFDLENBQUUsQ0FBQztJQUVKLE9BQU87UUFDTixpQ0FBaUMsRUFBRSxrQ0FBa0M7S0FDckUsQ0FBQztBQUNILENBQUMsRUFBRSxDQUFFLENBQUMifQ==