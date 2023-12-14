"use strict";
/// <reference path="../itemtile_store.ts" />
var StoreLinkedItems;
(function (StoreLinkedItems) {
    function Init() {
        const itemId = $.GetContextPanel().GetAttributeString("itemids", "");
        const isNotReleased = $.GetContextPanel().GetAttributeString("is-not-released", "") !== "true" ? false : true;
        const aItemIds = itemId.split(',');
        let elItem = null;
        for (var i = 0; i < aItemIds.length; i++) {
            elItem = $.CreatePanel("Button", $.GetContextPanel().FindChildInLayoutFile('id-store-linked-items-images'), aItemIds[i]);
            elItem.BLoadLayout('file://{resources}/layout/itemtile_store.xml', false, false);
            let oItemData = {
                id: aItemIds[i],
                isNotReleased: isNotReleased,
                isDisabled: isNotReleased
            };
            ItemTileStore.Init(elItem, oItemData);
        }
        _ShowWarningText();
    }
    StoreLinkedItems.Init = Init;
    function _ShowWarningText() {
        var warningText = $.GetContextPanel().GetAttributeString("linkedWarning", "");
        if (warningText) {
            $.GetContextPanel().SetHasClass('hidewarning', false);
            $.GetContextPanel().SetDialogVariable('warning', $.Localize(warningText));
        }
        else {
            $.GetContextPanel().SetHasClass('hidewarning', true);
        }
    }
})(StoreLinkedItems || (StoreLinkedItems = {}));
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY29udGV4dF9tZW51X3N0b3JlX2xpbmtlZF9pdGVtcy5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL2NvbnRlbnQvY3Nnby9wYW5vcmFtYS9zY3JpcHRzL2NvbnRleHRfbWVudXMvY29udGV4dF9tZW51X3N0b3JlX2xpbmtlZF9pdGVtcy50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsNkNBQTZDO0FBRTdDLElBQVUsZ0JBQWdCLENBMkN6QjtBQTNDRCxXQUFVLGdCQUFnQjtJQUd6QixTQUFnQixJQUFJO1FBRW5CLE1BQU0sTUFBTSxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxrQkFBa0IsQ0FBRSxTQUFTLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFDdkUsTUFBTSxhQUFhLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLGtCQUFrQixDQUFFLGlCQUFpQixFQUFFLEVBQUUsQ0FBRSxLQUFLLE1BQU0sQ0FBQyxDQUFDLENBQUMsS0FBSyxDQUFDLENBQUMsQ0FBQyxJQUFJLENBQUM7UUFDaEgsTUFBTSxRQUFRLEdBQUcsTUFBTSxDQUFDLEtBQUssQ0FBQyxHQUFHLENBQUMsQ0FBQztRQUduQyxJQUFJLE1BQU0sR0FBRyxJQUFJLENBQUM7UUFFbEIsS0FBSyxJQUFJLENBQUMsR0FBRyxDQUFDLEVBQUUsQ0FBQyxHQUFHLFFBQVEsQ0FBQyxNQUFNLEVBQUUsQ0FBQyxFQUFFLEVBQ3hDO1lBQ0MsTUFBTSxHQUFHLENBQUMsQ0FBQyxXQUFXLENBQUUsUUFBUSxFQUFFLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxxQkFBcUIsQ0FBRSw4QkFBOEIsQ0FBRSxFQUFFLFFBQVEsQ0FBRSxDQUFDLENBQUUsQ0FBYyxDQUFDO1lBQzNJLE1BQU0sQ0FBQyxXQUFXLENBQUUsOENBQThDLEVBQUUsS0FBSyxFQUFFLEtBQUssQ0FBRSxDQUFDO1lBRW5GLElBQUksU0FBUyxHQUFlO2dCQUMzQixFQUFFLEVBQUUsUUFBUSxDQUFFLENBQUMsQ0FBRTtnQkFDakIsYUFBYSxFQUFFLGFBQWE7Z0JBQzVCLFVBQVUsRUFBRSxhQUFhO2FBQ3pCLENBQUE7WUFDRCxhQUFhLENBQUMsSUFBSSxDQUFFLE1BQU0sRUFBRSxTQUFTLENBQUUsQ0FBQztTQUN4QztRQUVELGdCQUFnQixFQUFFLENBQUM7SUFDcEIsQ0FBQztJQXZCZSxxQkFBSSxPQXVCbkIsQ0FBQTtJQUVELFNBQVMsZ0JBQWdCO1FBRXhCLElBQUksV0FBVyxHQUFHLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxrQkFBa0IsQ0FBRSxlQUFlLEVBQUUsRUFBRSxDQUFFLENBQUM7UUFFaEYsSUFBSyxXQUFXLEVBQ2hCO1lBQ0MsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLFdBQVcsQ0FBRSxhQUFhLEVBQUUsS0FBSyxDQUFFLENBQUM7WUFDeEQsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDLGlCQUFpQixDQUFFLFNBQVMsRUFBRSxDQUFDLENBQUMsUUFBUSxDQUFFLFdBQVcsQ0FBRSxDQUFDLENBQUM7U0FDN0U7YUFFRDtZQUNDLENBQUMsQ0FBQyxlQUFlLEVBQUUsQ0FBQyxXQUFXLENBQUUsYUFBYSxFQUFFLElBQUksQ0FBRSxDQUFDO1NBQ3ZEO0lBQ0YsQ0FBQztBQUVGLENBQUMsRUEzQ1MsZ0JBQWdCLEtBQWhCLGdCQUFnQixRQTJDekIifQ==