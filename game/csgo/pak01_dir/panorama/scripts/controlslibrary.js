"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/iteminfo.ts" />
var controlsLibActiveTab = null;
function ControlsLibNavigateToTab(tab, msg) {
    if (controlsLibActiveTab) {
        controlsLibActiveTab.RemoveClass('Active');
    }
    controlsLibActiveTab = $('#' + tab);
    if (controlsLibActiveTab) {
        controlsLibActiveTab.AddClass('Active');
    }
}
function CloseControlsLib() {
    $.GetContextPanel().DeleteAsync(.3);
    var controlsLibPanel = $.GetContextPanel();
    controlsLibPanel.RemoveClass("Active");
}
function OpenControlsLib() {
    var controlsLibPanel = $.GetContextPanel();
    controlsLibPanel.AddClass("Active");
}
var jsPopupCallbackHandle = null;
var jsPopupLoadingBarCallbackHandle = null;
var popupLoadingBarLevel = 0;
function ClearPopupsText() {
    $('#ControlsLibPopupsText').text = '--';
}
function OnControlsLibPopupEvent(msg) {
    $('#ControlsLibPopupsText').text = msg;
}
function OnPopupCustomLayoutParamsPressed() {
    ClearPopupsText();
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_custom_layout_test.xml', 'popupvalue=123456&callback=' + jsPopupCallbackHandle);
}
function OnPopupCustomLayoutImagePressed() {
    ClearPopupsText();
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_custom_layout_test_image.xml', 'message=Example of popup with an image&image=file://{images}/control_icons/home_icon.vtf&callback=' + jsPopupCallbackHandle);
}
function OnPopupCustomLayoutImageSpinnerPressed() {
    ClearPopupsText();
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_custom_layout_test_image.xml', 'message=Example of popup with an image and a spinner&image=file://{images}/control_icons/home_icon.vtf&spinner=1&callback=' + jsPopupCallbackHandle);
}
function OnPopupCustomLayoutImageLoadingPressed() {
    ClearPopupsText();
    popupLoadingBarLevel = 0;
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_custom_layout_test_image.xml', 'message=Example of popup with an image and a loading bar&image=file://{images}/control_icons/home_icon.vtf&callback=' + jsPopupCallbackHandle + '&loadingBarCallback=' + jsPopupLoadingBarCallbackHandle);
}
function OnPopupCustomLayoutMatchAccept() {
    ClearPopupsText();
    popupLoadingBarLevel = 0;
    var popup = UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_accept_match.xml', 'map_and_isreconnect=de_dust2,false&ping=155&location=China, Tianjin');
    $.DispatchEvent("ShowAcceptPopup", popup);
}
function OnPopupCustomLayoutWeaponUpdate() {
    ClearPopupsText();
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_weapon_update.xml', "23");
}
function OnPopupCustomLayoutPremierPickBan() {
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_premier_pick_ban.xml', "none");
}
function OnPopupCustomLayoutOpFull() {
    ClearPopupsText();
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_operation_launch.xml', 'none');
}
function OnPopupCustomLayoutSurvivalEndOfMatch() {
    var elPanel = UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/survival/survival_endofmatch.xml', 'usefakedata=true');
}
function OnPopupCustomLayoutXpGrant() {
    UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/popups/popup_acknowledge_xpgrant.xml', 'none');
}
function OnPopupCustomLayoutOperationHub(startPage) {
    var nActiveSeason = GameTypesAPI.GetActiveSeasionIndexValue();
    if (nActiveSeason < 0)
        return;
    var elPanel = UiToolkitAPI.ShowCustomLayoutPopupParameters('', 'file://{resources}/layout/operation/operation_main.xml', 'none');
    elPanel.SetAttributeInt("season_access", nActiveSeason);
    if (startPage)
        elPanel.SetAttributeInt("start_page", startPage);
}
function OnPopupCustomLayoutLoadingScreen() {
    ClearPopupsText();
    UiToolkitAPI.ShowCustomLayoutPopup('teams', 'file://{resources}/layout/teamselectmenu.xml');
}
function OnControlsLibPopupLoadingBarEvent() {
    popupLoadingBarLevel += 0.05;
    if (popupLoadingBarLevel > 1.0) {
        popupLoadingBarLevel = 1.0;
    }
}
var jsContextMenuCallbackHandle = null;
function ClearContextMenuText() {
    $('#ControlsLibContextMenuText').text = '--';
}
function OnControlsLibContextMenuEvent(msg) {
    $('#ControlsLibContextMenuText').text = msg;
}
function OnSimpleContextMenu() {
    ClearContextMenuText();
    var items = [];
    items.push({ label: 'Item 1', jsCallback: function () { OnControlsLibContextMenuEvent('Item1'); } });
    items.push({ label: 'Item 2', jsCallback: function () { OnControlsLibContextMenuEvent('Item2'); } });
    items.push({ label: 'Item 3', jsCallback: function () { OnControlsLibContextMenuEvent('Item3'); } });
    UiToolkitAPI.ShowSimpleContextMenu('', 'ControlLibSimpleContextMenu', items);
}
function OnContextMenuCustomLayoutParamsPressed() {
    ClearContextMenuText();
    UiToolkitAPI.ShowCustomLayoutContextMenuParameters('', '', 'file://{resources}/layout/context_menus/context_menu_custom_layout_test.xml', 'test=123456&callback=' + jsContextMenuCallbackHandle);
}
var g_VideoNumTrailers = 2;
var g_VideoCurrentTrailer = 0;
function VideoPlayNextTrailer() {
    g_VideoCurrentTrailer = (g_VideoCurrentTrailer + 1) % g_VideoNumTrailers;
    var videoPlayer = $('#VideoTrailerPlayer');
    videoPlayer.SetMovie("file://{resources}/videos/trailer_" + g_VideoCurrentTrailer + ".webm");
    videoPlayer.SetTitle("Trailer " + g_VideoCurrentTrailer);
    videoPlayer.Play();
}
var g_sceneanimsList = [
    'cu_ct_pose01',
    'cu_ct_pose02',
    'cu_ct_pose03',
    'cu_ct_pose04',
    'cu_t_pose01',
    'cu_t_pose02',
    'cu_t_pose03',
    'cu_t_pose04',
];
var g_sceneanimindex = 0;
var g_maxsceneitemcontext = 5;
var g_sceneitemcontext = 0;
function InitScenePanel() {
    g_sceneanimindex = 0;
    var charT = LoadoutAPI.GetItemID('ct', 'customplayer');
    var model = ItemInfo.GetModelPlayer(charT);
    var playerPanel = $("#Player1");
    playerPanel.SetSceneAngles(0, 0, 0, false);
    playerPanel.SetPlayerModel(model);
    playerPanel.PlaySequence(g_sceneanimsList[g_sceneanimindex], true);
    playerPanel.SetCameraPreset(6, false);
}
function SceneNextAnimSequence() {
    g_sceneanimindex++;
    if (g_sceneanimindex >= g_sceneanimsList.length) {
        g_sceneanimindex = 0;
    }
    var playerPanel = $("#Player1");
    playerPanel.PlaySequence(g_sceneanimsList[g_sceneanimindex], true);
}
function ScenePrevAnimSequence() {
    g_sceneanimindex--;
    if (g_sceneanimindex < 0) {
        g_sceneanimindex = g_sceneanimsList.length - 1;
    }
    var playerPanel = $("#Player1");
    playerPanel.PlaySequence(g_sceneanimsList[g_sceneanimindex], true);
}
function GenerateInventoryImages() {
    $("#Player1").GenerateInventoryImages();
}
var g_DialogVarCount = 0;
function UpdateParentDialogVariablesFromTextEntry(panelName) {
    var varStr = $("#ParentDialogVarTextEntry").text;
    $("#DialogVarParentPanel").SetDialogVariable('testvar', varStr);
}
function UpdateChildDialogVariablesFromTextEntry(panelName) {
    var varStr = $("#ChildDialogVarTextEntry").text;
    $("#DialogVarChildPanel").SetDialogVariable('testvar', varStr);
}
function InitDialogVariables() {
    $("#ControlsLibDiagVars").SetDialogVariableInt("count", g_DialogVarCount);
    $("#ControlsLibDiagVars").SetDialogVariable("s1", "Test1");
    $("#ControlsLibDiagVars").SetDialogVariable("s2", "Test2");
    $("#ControlsLibDiagVars").SetDialogVariable("cam_key", "%jump%");
    $("#ControlsLibDiagVars").SetDialogVariable("np_key", "%attack%");
    $("#ControlsLibDiagVars").SetDialogVariable("sp_key", "%radio%");
    $("#DiagVarLabel").text = $.Localize("\tDynamic Label Count: {d:r:count}", $("#ControlsLibDiagVars"));
    $.Schedule(1.0, UpdateDialogVariables);
    $("#ParentDialogVarTextEntry").RaiseChangeEvents(true);
    $("#ChildDialogVarTextEntry").RaiseChangeEvents(true);
    $.RegisterEventHandler('TextEntryChanged', $("#ParentDialogVarTextEntry"), UpdateParentDialogVariablesFromTextEntry);
    $.RegisterEventHandler('TextEntryChanged', $("#ChildDialogVarTextEntry"), UpdateChildDialogVariablesFromTextEntry);
}
function UpdateDialogVariables() {
    g_DialogVarCount++;
    $("#ControlsLibDiagVars").SetDialogVariableInt("count", g_DialogVarCount);
    $.Schedule(1.0, UpdateDialogVariables);
}
function InitCaseTest() {
    $("#CaseTest").SetDialogVariable("casetest", "iİıI");
}
function OnImageFailLoad() {
    $("#ControlsLibPanelImageFallback").SetImage("file://{images}/icons/knife.psd");
}
function InitPanels() {
    var parent = $.FindChildInContext("#ControlsLibPanelsDynParent");
    $.CreatePanel('Label', parent, '', { text: 'Label, with text property, created dynamically from js.' });
    $.CreatePanel('Label', parent, '', { class: 'fontSize-l fontWeight-Bold', style: 'color:#558927;', text: 'Label, with text and class properties, created dynamically from js.' });
    $.CreatePanel('TextButton', parent, '', { class: 'PopupButton', text: "Output to console", onactivate: "$.Msg('Panel tab - Button pressed !!!')" });
    $.CreatePanel('ControlLibTestPanel', $.FindChildInContext('#ControlsLibPanelsJS'), '', { MyCustomProp: 'Created dynamically from javascript', CreatedFromJS: 1 });
    $.RegisterEventHandler('ImageFailedLoad', $("#ControlsLibPanelImageFallback"), OnImageFailLoad);
    $("#ControlsLibPanelImageFallback").SetImage("file://{images}/unknown2.vtf");
    $("#ImageApngtest").SetImage("file://{resources}/videos/test/apngtestnoext");
}
function TransitionBlurPanel() {
    $("#MyBlendBlurFitParent").RemoveClass("TheBlurAnimOut");
    $("#MyBlendBlurFitParent").RemoveClass("TheBlurAnimIn");
    $("#MyBlendBlurFitParent").AddClass("TheBlurAnimIn");
}
function TransitionBlurPanel2() {
    $("#MyBlendBlurFitParent").RemoveClass("TheBlurAnimIn");
    $("#MyBlendBlurFitParent").RemoveClass("TheBlurAnimOut");
    $("#MyBlendBlurFitParent").AddClass("TheBlurAnimOut");
}
function CreateSvgFromJs() {
    $.CreatePanel('Image', $('#svgButton'), '', {
        src: "file://{images}/icons/ui/smile.svg",
        texturewidth: 100,
        textureheight: 100
    });
}
function GetRssFeed() {
    BlogAPI.RequestRSSFeed();
}
function OnRssFeedReceived(feed) {
    var RSSFeedPanel = $("#RSSFeed");
    if (RSSFeedPanel == null) {
        return;
    }
    RSSFeedPanel.RemoveAndDeleteChildren();
    for (const item of feed.items) {
        var itemPanel = $.CreatePanel('Panel', RSSFeedPanel, '', { acceptsinput: true });
        itemPanel.AddClass('RSSFeed__Item');
        $.CreatePanel('Label', itemPanel, '', { text: item.title, html: true, class: 'RSSFeed__ItemTitle' });
        if (item.imageUrl.length !== 0) {
            $.CreatePanel('Image', itemPanel, '', { src: item.imageUrl, class: 'RSSFeed__ItemImage', scaling: 'stretch-to-fit-preserve-aspect' });
        }
        $.CreatePanel('Label', itemPanel, '', { text: item.description, html: true, class: 'RSSFeed__ItemDesc' });
        $.CreatePanel('Label', itemPanel, '', { text: item.date, html: true, class: 'RSSFeed__ItemDate' });
        itemPanel.SetPanelEvent("onactivate", SteamOverlayAPI.OpenURL.bind(SteamOverlayAPI, item.link));
    }
}
function JSReadyReset() {
    var elParent = $('#ControlsLibBugsReadyParent');
    var elBtnAddChild = $('#ControlsLibBugsReadyButtonAddChild');
    var elBtnAddBgImg = $('#ControlsLibBugsReadyButtonAddBgImg');
    elParent.RemoveAndDeleteChildren();
    elParent.SetReadyForDisplay(false);
    elBtnAddChild.enabled = true;
    elBtnAddBgImg.enabled = false;
}
function JSReadyAddChild() {
    var elParent = $('#ControlsLibBugsReadyParent');
    var elBtnAddChild = $('#ControlsLibBugsReadyButtonAddChild');
    var elBtnAddBgImg = $('#ControlsLibBugsReadyButtonAddBgImg');
    $.CreatePanel('Panel', elParent, 'ControlsLibBugsReadyChild', { class: 'ControlLibBugs__ReadyChild' });
    elBtnAddChild.enabled = false;
    elBtnAddBgImg.enabled = true;
}
function JSReadyAddBgImg() {
    var elBtnAddChild = $('#ControlsLibBugsReadyButtonAddChild');
    var elBtnAddBgImg = $('#ControlsLibBugsReadyButtonAddBgImg');
    var elParent = $('#ControlsLibBugsReadyParent');
    var elChild = $('#ControlsLibBugsReadyChild');
    elBtnAddChild.enabled = false;
    elBtnAddBgImg.enabled = false;
    elChild.AddClass('ControlLibBugs__ReadyChild--Ready');
    elParent.SetReadyForDisplay(true);
}
function JSTestTransition() {
    var Delay = 0.2;
    function _reveal(panelId) {
        $(panelId).AddClass('TestTransition');
    }
    $.Schedule(Delay, () => _reveal("#RepaintBugGrandchild"));
    $.Schedule(Delay * 2.0, () => _reveal("#RepaintBugChild"));
}
function JSResetTransition() {
    $('#RepaintBugChild').RemoveClass('TestTransition');
    $('#RepaintBugGrandchild').RemoveClass('TestTransition');
}
function JSControlsPageStartParticles() {
    for (const curPanel of $('#ControlsLibParticles').FindChildrenWithClassTraverse('TestParticlePanel')) {
        curPanel.StartParticles();
    }
}
function JSControlsPageStopPlayEndCapParticles() {
    for (const curPanel of $('#ControlsLibParticles').FindChildrenWithClassTraverse('TestParticlePanel')) {
        curPanel.StopParticlesWithEndcaps();
    }
}
function JSControlsPageSetControlPointParticles(cp, xpos, ypos, zpos) {
    for (const curPanel of $('#ControlsLibParticles').FindChildrenWithClassTraverse('TestParticlePanel')) {
        curPanel.SetControlPoint(cp, 0, 1 + ypos, zpos);
        curPanel.SetControlPoint(cp, xpos, ypos, zpos);
    }
}
function ShowHideWinPanel(bshow) {
    let elPanel = $.GetContextPanel().FindChildInLayoutFile('ZooWinPanel');
    elPanel.SetHasClass('winpanel-basic-round-result-visible', bshow);
    elPanel.SetHasClass('WinPanelRoot--Win', bshow);
    elPanel.SetHasClass('winpanel-mvp--show', bshow);
    elPanel.SetHasClass('MVP__MusicKit--show', bshow);
    elPanel.SetHasClass('winpanel-funfacts--show', bshow);
    elPanel.SetDialogVariable('winpanel-funfact', $.Localize('#GameUI_Stat_LastMatch_MaxPlayers'));
    elPanel.SetDialogVariable('winpanel-title', $.Localize('#winpanel_ct_win'));
    let elAvatar = elPanel.FindChildInLayoutFile('MVPAvatar');
    elAvatar.PopulateFromSteamID(MyPersonaAPI.GetXuid());
    let musicKitId = LoadoutAPI.GetItemID('noteam', 'musickit');
    let elKitName = elPanel.FindChildInLayoutFile('MVPMusicKitName');
    elKitName.text = InventoryAPI.GetItemName(musicKitId);
    let elKitLabel = elPanel.FindChildInLayoutFile('MVPMusicKitStatTrak');
    elKitLabel.text = '1000';
}
function CtrlLib_RandomColorString() {
    return "rgba("
        + Math.random() * 255 + ","
        + Math.random() * 255 + ","
        + Math.random() * 255 + ","
        + Number(0.3 + Math.random() * 0.6)
        + ")";
}
function CtrlLib_CreateSpiderGraph() {
    const spiderGraph = $('#SpiderGraph');
    spiderGraph.ClearJS('rgba(0,0,0,0)');
    const elGuidelines = $('#SpiderGraphNumGuidelines');
    const numGuidelines = Number(elGuidelines.text);
    const options = {
        bkg_color: "#44444444",
        spoke_length_scale: 1.0,
        guideline_count: numGuidelines,
        deadzone_percent: .2
    };
    spiderGraph.SetGraphOptions(options);
    const elSpokes = $('#SpiderGraphSpokes');
    const spokesCount = Number(elSpokes.text);
    spiderGraph.DrawGraphBackground(spokesCount);
    const elNumPolys = $('#SpiderGraphNumPolys');
    const polyCount = Number(elNumPolys.text);
    for (let p = 0; p < polyCount; p++) {
        let values = Array.from({ length: spokesCount }, () => Math.random());
        const options = {
            line_color: CtrlLib_RandomColorString(),
            fill_color_inner: CtrlLib_RandomColorString(),
            fill_color_outer: CtrlLib_RandomColorString(),
        };
        spiderGraph.DrawGraphPoly(values, options);
    }
    for (let s = 0; s < spokesCount; s++) {
        let vPos = spiderGraph.GraphPositionToUIPosition(s, 1.0);
    }
}
(function () {
    OpenControlsLib();
    ControlsLibNavigateToTab('ControlLibStyleGuide', 'init');
    const spiderGraph = $('#SpiderGraph');
    if (spiderGraph) {
        $.RegisterEventHandler("CanvasReady", spiderGraph, CtrlLib_CreateSpiderGraph);
        if (spiderGraph.BCanvasReady()) {
            CtrlLib_CreateSpiderGraph();
        }
    }
    var elTime = $("#TimeZoo");
    if (elTime) {
        elTime.SetDialogVariableTime("time", 1605560584);
    }
    jsPopupCallbackHandle = UiToolkitAPI.RegisterJSCallback(OnControlsLibPopupEvent);
    jsContextMenuCallbackHandle = UiToolkitAPI.RegisterJSCallback(OnControlsLibContextMenuEvent);
    jsPopupLoadingBarCallbackHandle = UiToolkitAPI.RegisterJSCallback(OnControlsLibPopupLoadingBarEvent);
    $.RegisterForUnhandledEvent("PanoramaComponent_Blog_RSSFeedReceived", OnRssFeedReceived);
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY29udHJvbHNsaWJyYXJ5LmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvY29udHJvbHNsaWJyYXJ5LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQyxrQ0FBa0M7QUFDbkMsMkNBQTJDO0FBTTNDLElBQUksb0JBQW9CLEdBQW1CLElBQUksQ0FBQztBQUVoRCxTQUFTLHdCQUF3QixDQUFHLEdBQVcsRUFBRSxHQUFXO0lBSXhELElBQUssb0JBQW9CLEVBQ3pCO1FBQ0ksb0JBQW9CLENBQUMsV0FBVyxDQUFFLFFBQVEsQ0FBRSxDQUFDO0tBQ2hEO0lBRUQsb0JBQW9CLEdBQUcsQ0FBQyxDQUFFLEdBQUcsR0FBRyxHQUFHLENBQUUsQ0FBQztJQUV0QyxJQUFLLG9CQUFvQixFQUN6QjtRQUNJLG9CQUFvQixDQUFDLFFBQVEsQ0FBRSxRQUFRLENBQUUsQ0FBQztLQUM3QztBQUVMLENBQUM7QUFFRCxTQUFTLGdCQUFnQjtJQUdyQixDQUFDLENBQUMsZUFBZSxFQUFFLENBQUMsV0FBVyxDQUFFLEVBQUUsQ0FBRSxDQUFDO0lBRXRDLElBQUksZ0JBQWdCLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDO0lBQzNDLGdCQUFnQixDQUFDLFdBQVcsQ0FBRSxRQUFRLENBQUUsQ0FBQztBQUM3QyxDQUFDO0FBRUQsU0FBUyxlQUFlO0lBRXBCLElBQUksZ0JBQWdCLEdBQUcsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDO0lBQzNDLGdCQUFnQixDQUFDLFFBQVEsQ0FBRSxRQUFRLENBQUUsQ0FBQztBQUMxQyxDQUFDO0FBS0QsSUFBSSxxQkFBcUIsR0FBa0IsSUFBSSxDQUFDO0FBQ2hELElBQUksK0JBQStCLEdBQWtCLElBQUksQ0FBQztBQUMxRCxJQUFJLG9CQUFvQixHQUFHLENBQUMsQ0FBQztBQUU3QixTQUFTLGVBQWU7SUFFbEIsQ0FBQyxDQUFFLHdCQUF3QixDQUFlLENBQUMs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