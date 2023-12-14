"use strict";
/// <reference path="../csgo.d.ts" />
var PrimeButtonAction;
(function (PrimeButtonAction) {
    function SetUpPurchaseBtn(btnPurchase) {
        var sPrice = StoreAPI.GetStoreItemSalePrice(InventoryAPI.GetFauxItemIDFromDefAndPaintIndex(1353, 0), 1, '');
        btnPurchase.SetDialogVariable("price", sPrice ? sPrice : '$0');
        btnPurchase.SetPanelEvent('onactivate', function () {
            SteamOverlayAPI.OpenURL(_GetStoreUrl() + '/sub/54029');
            $.DispatchEvent('UIPopupButtonClicked', '');
        });
    }
    PrimeButtonAction.SetUpPurchaseBtn = SetUpPurchaseBtn;
    function _GetStoreUrl() {
        return 'https://store.' +
            ((SteamOverlayAPI.GetAppID() == 710) ? 'beta.' : '') +
            ((MyPersonaAPI.GetSteamType() === 'china' || MyPersonaAPI.GetLauncherType() === "perfectworld") ? 'steamchina' : 'steampowered') + '.com';
    }
})(PrimeButtonAction || (PrimeButtonAction = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicHJpbWVfYnV0dG9uX2FjdGlvbi5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2NvbW1vbi9wcmltZV9idXR0b25fYWN0aW9uLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxxQ0FBcUM7QUFFckMsSUFBVSxpQkFBaUIsQ0FzQjFCO0FBdEJELFdBQVUsaUJBQWlCO0lBRTFCLFNBQWdCLGdCQUFnQixDQUFHLFdBQXdCO1FBSzFELElBQUksTUFBTSxHQUFHLFFBQVEsQ0FBQyxxQkFBcUIsQ0FBRSxZQUFZLENBQUMsaUNBQWlDLENBQUUsSUFBSSxFQUFFLENBQUMsQ0FBRSxFQUFFLENBQUMsRUFBRSxFQUFFLENBQUUsQ0FBQztRQUNoSCxXQUFZLENBQUMsaUJBQWlCLENBQUUsT0FBTyxFQUFFLE1BQU0sQ0FBQyxDQUFDLENBQUMsTUFBTSxDQUFDLENBQUMsQ0FBQyxJQUFJLENBQUUsQ0FBQztRQUVsRSxXQUFZLENBQUMsYUFBYSxDQUFDLFlBQVksRUFBRTtZQUN4QyxlQUFlLENBQUMsT0FBTyxDQUFFLFlBQVksRUFBRSxHQUFHLFlBQVksQ0FBQyxDQUFDO1lBQ3hELENBQUMsQ0FBQyxhQUFhLENBQUMsc0JBQXNCLEVBQUUsRUFBRSxDQUFDLENBQUM7UUFDN0MsQ0FBQyxDQUFDLENBQUM7SUFDSixDQUFDO0lBWmUsa0NBQWdCLG1CQVkvQixDQUFBO0lBRUQsU0FBUyxZQUFZO1FBRXBCLE9BQU8sZ0JBQWdCO1lBQ3RCLENBQUMsQ0FBQyxlQUFlLENBQUMsUUFBUSxFQUFFLElBQUksR0FBRyxDQUFDLENBQUMsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxDQUFDLENBQUMsRUFBRSxDQUFDO1lBQ3BELENBQUMsQ0FBQyxZQUFZLENBQUMsWUFBWSxFQUFFLEtBQUssT0FBTyxJQUFJLFlBQVksQ0FBQyxlQUFlLEVBQUUsS0FBSyxjQUFjLENBQUUsQ0FBQyxDQUFDLENBQUMsWUFBWSxDQUFDLENBQUMsQ0FBQyxjQUFjLENBQUMsR0FBRyxNQUFNLENBQUM7SUFDN0ksQ0FBQztBQUNGLENBQUMsRUF0QlMsaUJBQWlCLEtBQWpCLGlCQUFpQixRQXNCMUIifQ==