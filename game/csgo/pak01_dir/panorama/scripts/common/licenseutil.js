"use strict";
/// <reference path="../csgo.d.ts" />
var LicenseUtil = (function () {
    const _GetCurrentLicenseRestrictions = function () {
        let szButtonText = "#Store_Get_License";
        let szMessageText = "#SFUI_LoginLicenseAssist_NoOnlineLicense";
        switch (MyPersonaAPI.GetLicenseType()) {
            case "free_pw_needlink":
                szButtonText = "#Store_Link_Accounts";
                szMessageText = "#SFUI_LoginLicenseAssist_PW_NeedToLinkAccounts";
                break;
            case "free_pw_needupgrade":
                szMessageText = "#SFUI_LoginLicenseAssist_HasLicense_PW";
                break;
            case "free_pw":
                szMessageText = "#SFUI_LoginLicenseAssist_NoOnlineLicense_PW";
                break;
            case "free_sc":
                szMessageText = "#SFUI_LoginLicenseAssist_NoOnlineLicense_SC";
                szButtonText = "#Store_Register_License";
                break;
            case "purchased":
                return false;
        }
        return {
            license_msg: szMessageText,
            license_act: szButtonText
        };
    };
    const _BuyLicenseForRestrictions = function (restrictions) {
        if (restrictions && restrictions.license_act === "#Store_Register_License") {
            UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_license_register.xml', 'message=Store_Register_License' +
                '&' + 'spinner=1');
        }
        else {
            MyPersonaAPI.ActionBuyLicense();
        }
    };
    const _ShowLicenseRestrictions = function (restrictions) {
        if (restrictions !== false) {
            UiToolkitAPI.ShowGenericPopupYesNo($.Localize(restrictions.license_act), $.Localize(restrictions.license_msg), '', _BuyLicenseForRestrictions.bind(null, restrictions), function () { });
        }
    };
    return {
        GetCurrentLicenseRestrictions: _GetCurrentLicenseRestrictions,
        BuyLicenseForRestrictions: _BuyLicenseForRestrictions,
        ShowLicenseRestrictions: _ShowLicenseRestrictions
    };
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibGljZW5zZXV0aWwuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9jb250ZW50L2NzZ28vcGFub3JhbWEvc2NyaXB0cy9jb21tb24vbGljZW5zZXV0aWwudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLHFDQUFxQztBQVVyQyxJQUFJLFdBQVcsR0FBRyxDQUFFO0lBRW5CLE1BQU0sOEJBQThCLEdBQUc7UUFFdEMsSUFBSSxZQUFZLEdBQUcsb0JBQW9CLENBQUM7UUFDeEMsSUFBSSxhQUFhLEdBQUcsMENBQTBDLENBQUM7UUFDL0QsUUFBUyxZQUFZLENBQUMsY0FBYyxFQUFFLEVBQ3RDO1lBQ0EsS0FBSyxrQkFBa0I7Z0JBQ3RCLFlBQVksR0FBRyxzQkFBc0IsQ0FBQztnQkFDdEMsYUFBYSxHQUFHLGdEQUFnRCxDQUFDO2dCQUNqRSxNQUFNO1lBQ1AsS0FBSyxxQkFBcUI7Z0JBQ3pCLGFBQWEsR0FBRyx3Q0FBd0MsQ0FBQztnQkFDekQsTUFBTTtZQUNQLEtBQUssU0FBUztnQkFDYixhQUFhLEdBQUcsNkNBQTZDLENBQUM7Z0JBQzlELE1BQU07WUFDUCxLQUFLLFNBQVM7Z0JBQ2IsYUFBYSxHQUFHLDZDQUE2QyxDQUFDO2dCQUM5RCxZQUFZLEdBQUcseUJBQXlCLENBQUM7Z0JBQ3pDLE1BQU07WUFDUCxLQUFLLFdBQVc7Z0JBQ2YsT0FBTyxLQUFLLENBQUM7U0FDYjtRQUVELE9BQU87WUFDTixXQUFXLEVBQUcsYUFBYTtZQUMzQixXQUFXLEVBQUcsWUFBWTtTQUMxQixDQUFDO0lBQ0gsQ0FBQyxDQUFBO0lBRUQsTUFBTSwwQkFBMEIsR0FBRyxVQUFVLFlBQTJDO1FBRXZGLElBQUssWUFBWSxJQUFJLFlBQVksQ0FBQyxXQUFXLEtBQUsseUJBQXlCLEVBQUc7WUFDN0UsWUFBWSxDQUFDLCtCQUErQixDQUMzQyxFQUFFLEVBQ0YsNkRBQTZELEVBQzdELGdDQUFnQztnQkFDaEMsR0FBRyxHQUFHLFdBQVcsQ0FDakIsQ0FBQztTQUNGO2FBQU07WUFDTixZQUFZLENBQUMsZ0JBQWdCLEVBQUUsQ0FBQztTQUNoQztJQUNGLENBQUMsQ0FBQTtJQUVELE1BQU0sd0JBQXdCLEdBQUcsVUFBVSxZQUEyQztRQUVyRixJQUFLLFlBQVksS0FBSyxLQUFLLEVBQzNCO1lBRUMsWUFBWSxDQUFDLHFCQUFxQixDQUNqQyxDQUFDLENBQUMsUUFBUSxDQUFFLFlBQVksQ0FBQyxXQUFXLENBQUUsRUFDdEMsQ0FBQyxDQUFDLFFBQVEsQ0FBRSxZQUFZLENBQUMsV0FBVyxDQUFFLEVBQ3RDLEVBQUUsRUFDRiwwQkFBMEIsQ0FBQyxJQUFJLENBQUUsSUFBSSxFQUFFLFlBQVksQ0FBRSxFQUNyRCxjQUFZLENBQUMsQ0FDYixDQUFDO1NBQ0Y7SUFDRixDQUFDLENBQUE7SUFFRCxPQUFNO1FBQ0wsNkJBQTZCLEVBQUcsOEJBQThCO1FBQzlELHlCQUF5QixFQUFHLDBCQUEwQjtRQUN0RCx1QkFBdUIsRUFBRyx3QkFBd0I7S0FDbEQsQ0FBQztBQUNILENBQUMsQ0FBQyxFQUFFLENBQUMifQ==