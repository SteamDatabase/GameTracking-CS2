"use strict";
/// <reference path="csgo.d.ts" />
/// <reference path="common/formattext.ts" />
/// <reference path="mock_adapter.ts" />
/// <reference path="rank_skillgroup_particles.ts" />
/// <reference path="endofmatch.ts" />
var EOM_Skillgroup;
(function (EOM_Skillgroup) {
    var _m_pauseBeforeEnd = 1.5;
    var _m_cP = $.GetContextPanel();
    function _msg(msg) {
    }
    _m_cP.Data().m_retries = 0;
    function _DisplayMe() {
        if (!_m_cP || !_m_cP.IsValid())
            return false;
        _Reset();
        if (!MockAdapter.bSkillgroupDataReady(_m_cP)) {
            return false;
        }
        if (MyPersonaAPI.GetElevatedState() !== 'elevated') {
            return false;
        }
        let oSkillgroupData = MockAdapter.SkillgroupDataJSO(_m_cP);
        let localPlayerUpdate = oSkillgroupData[MockAdapter.GetLocalPlayerXuid()];
        if (!localPlayerUpdate)
            return false;
        const rating_mismatch = localPlayerUpdate.new_rank - localPlayerUpdate.old_rank != localPlayerUpdate.rank_change &&
            localPlayerUpdate.old_rank != 0;
        let oData = {
            current_rating: localPlayerUpdate.new_rank,
            num_wins: localPlayerUpdate.num_wins,
            old_rating: rating_mismatch ? 0 : localPlayerUpdate.old_rank,
            old_rating_info: '',
            old_rating_desc: '',
            old_image: '',
            new_rating: localPlayerUpdate.new_rank,
            new_rating_info: '',
            new_rating_desc: '',
            new_image: '',
            rating_change: localPlayerUpdate.rank_change,
            rating_mismatch: rating_mismatch,
            mode: localPlayerUpdate.rank_type,
            model: ''
        };
        let current_rating = Math.max(Number(oData.new_rating), Number(oData.old_rating));
        let winsNeededForRank = SessionUtil.GetNumWinsNeededForRank(oData.mode);
        let matchesNeeded = winsNeededForRank - oData.num_wins;
        _m_cP.SetDialogVariable('rating_type', $.Localize('#SFUI_GameMode' + oData.mode));
        if (current_rating < 1 && matchesNeeded <= 0) {
            switch (oData.mode) {
                case 'Wingman':
                case 'Competitive':
                    let modePrefix = (oData.mode === 'Wingman') ? 'wingman' : 'skillgroup';
                    oData.old_rating_info = $.Localize('#eom-skillgroup-expired', _m_cP);
                    oData.old_image = 'file://{images}/icons/skillgroups/' + modePrefix + '_expired.svg';
                    break;
                case 'Premier':
                    oData.old_rating_info = $.Localize('#eom-skillgroup-expired', _m_cP);
                    break;
            }
        }
        else if (current_rating < 1) {
            _m_cP.SetDialogVariableInt('winsneeded', matchesNeeded);
            switch (oData.mode) {
                case 'Wingman':
                case 'Competitive':
                    let modePrefix = (oData.mode === 'Wingman') ? 'wingman' : 'skillgroup';
                    oData.old_rating_info = $.Localize('#eom-skillgroup-needed-wins', _m_cP);
                    oData.old_image = 'file://{images}/icons/skillgroups/' + modePrefix + '0.svg';
                    break;
                case 'Premier':
                    break;
            }
        }
        else if (current_rating >= 1) {
            switch (oData.mode) {
                case 'Wingman':
                case 'Competitive':
                    let modePrefix = (oData.mode === 'Wingman') ? 'wingman' : 'skillgroup';
                    oData.old_image = 'file://{images}/icons/skillgroups/' + modePrefix + oData.old_rating + '.svg';
                    oData.old_rating_info = $.Localize('#RankName_' + oData.old_rating);
                    oData.old_rating_desc = $.Localize('#eom-skillgroup-name', _m_cP);
                    if (oData.old_rating < oData.new_rating) {
                        oData.new_image = 'file://{images}/icons/skillgroups/' + modePrefix + oData.new_rating + '.svg';
                        oData.new_rating_info = $.Localize('#RankName_' + oData.new_rating);
                        oData.new_rating_desc = $.Localize('#eom-skillgroup-name', _m_cP);
                        _m_pauseBeforeEnd = 3.0;
                        _LoadAndShowNewRankReveal(oData);
                    }
                    break;
                case 'Premier':
                    if (oData.old_rating !== oData.new_rating) {
                        _m_pauseBeforeEnd = 5.0;
                        _LoadAndShowNewRankReveal(oData);
                    }
                    break;
            }
            _m_cP.SetHasClass('rating-mismatch', oData.rating_mismatch);
        }
        if (oData.mode === 'Premier') {
            _FilloutPremierRankData(oData);
            _m_cP.FindChildInLayoutFile('id-eom-skillgroup-premier-bg').SwitchClass('tier', RatingEmblem.GetTierColorClass(_m_cP.FindChildInLayoutFile('jsRatingEmblem')));
        }
        else {
            _FilloutRankData(oData);
        }
        _m_cP.FindChildInLayoutFile('id-eom-skillgroup-bg').SetHasClass('hide', oData.mode === 'Premier');
        _m_cP.FindChildInLayoutFile('id-eom-skillgroup-premier-bg').SetHasClass('hide', oData.mode !== 'Premier');
        _m_cP.AddClass('eom-skillgroup-show');
        return true;
    }
    ;
    function _LoadAndShowNewRankReveal(oData) {
        $.Schedule(1, _RevealNewIcon.bind(undefined, oData));
    }
    function _RevealNewIcon(oData) {
        if (!_m_cP || !_m_cP.IsValid())
            return;
        if (oData.mode === 'Competitive' || oData.mode === 'Wingman') {
            _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem--new__image').SetImage(oData.new_image);
            _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem').AddClass("uprank-anim");
            _m_cP.SetDialogVariable('rank-info', oData.new_rating_info);
            let elParticleFlare = _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem--new__pfx--above');
            let aParticleSettings = GetSkillGroupSettings(oData.new_rating, oData.mode);
            elParticleFlare.SetParticleNameAndRefresh(aParticleSettings.particleName);
            elParticleFlare.SetControlPoint(aParticleSettings.cpNumber, aParticleSettings.cpValue[0], aParticleSettings.cpValue[1], 1);
            elParticleFlare.StartParticles();
            let elParticleAmb = _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem--new__pfx--below');
            let aParticleAmbSettings = GetSkillGroupAmbientSettings(oData.new_rating, oData.mode);
            elParticleAmb.SetParticleNameAndRefresh(aParticleAmbSettings.particleName);
            elParticleAmb.SetControlPoint(aParticleAmbSettings.cpNumber, aParticleAmbSettings.cpValue[0], aParticleAmbSettings.cpValue[1], 1);
            elParticleAmb.StartParticles();
            $.DispatchEvent('CSGOPlaySoundEffect', 'UIPanorama.XP.NewSkillGroup', 'MOUSE');
        }
        else if (oData.mode === 'Premier') {
            let options = {
                root_panel: _m_cP.FindChildInLayoutFile('jsRatingEmblem'),
                xuid: MockAdapter.GetLocalPlayerXuid(),
                leaderboard_details: { score: oData.new_rating, matchesWon: oData.num_wins },
                do_fx: false,
                presentation: 'digital',
                eom_digipanel_class_override: GetEmblemStyleOverride(oData.new_rating),
                full_details: true,
            };
            let winLossStyle = GetWinLossStyle(oData);
            _m_cP.FindChildInLayoutFile('jsRatingEmblem').SwitchClass('winloss', winLossStyle + '-anim');
            PremierRankText(oData);
            SpeedLinesAnim(winLossStyle);
            RatingEmblemAnim(oData, options, winLossStyle);
        }
    }
    function _Reset() {
        let elDesc = _m_cP.FindChildInLayoutFile("id-eom-skillgroup__current_wins_desc");
        elDesc.text = '';
        _m_cP.SetDialogVariable('total-wins', '');
        _m_cP.SetDialogVariable('rank-info', '');
        let elRankDesc = _m_cP.FindChildInLayoutFile("id-eom-skillgroup__current__title");
        elRankDesc.AddClass('hidden');
        elRankDesc.text = '';
        let elImage = _m_cP.FindChildInLayoutFile("id-eom-skillgroup-emblem--current__image");
        elImage.AddClass('hidden');
        elImage.SetImage('');
        _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem--new__image').SetImage('');
        _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem').RemoveClass("uprank-anim");
        _m_cP.RemoveClass('eom-skillgroup-show');
        let elParticleFlare = _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem--new__pfx--above');
        elParticleFlare.StopParticlesImmediately(true);
        let elParticleAmb = _m_cP.FindChildInLayoutFile('id-eom-skillgroup-emblem--new__pfx--below');
        elParticleAmb.StopParticlesImmediately(true);
        _m_cP.RemoveClass('rating-mismatch');
    }
    function _FilloutRankData(oData) {
        SetWinDescString(oData, _m_cP.FindChildInLayoutFile("id-eom-skillgroup__current_wins_desc"));
        _m_cP.SetDialogVariable('total-wins', oData.num_wins.toString());
        _m_cP.SetDialogVariable('rank-info', oData.old_rating_info);
        let elRankDesc = _m_cP.FindChildInLayoutFile("id-eom-skillgroup__current__title");
        if (oData.old_rating_desc) {
            elRankDesc.RemoveClass('hidden');
            elRankDesc.text = oData.old_rating_desc;
        }
        if (oData.mode === 'Competitive' || oData.mode === 'Wingman') {
            let elImage = _m_cP.FindChildInLayoutFile("id-eom-skillgroup-emblem--current__image");
            elImage.RemoveClass('hidden');
            elImage.SetImage(oData.old_image);
            let elParticleFlare = _m_cP.FindChildInLayoutFile('id-eom-skillgroup--current__pfx--above');
            let aParticleSettings = GetSkillGroupSettings(oData.old_rating, oData.mode);
            elParticleFlare.SetParticleNameAndRefresh(aParticleSettings.particleName);
            elParticleFlare.SetControlPoint(aParticleSettings.cpNumber, aParticleSettings.cpValue[0], aParticleSettings.cpValue[1], 0);
            elParticleFlare.StartParticles();
            let elParticleAmb = _m_cP.FindChildInLayoutFile('id-eom-skillgroup--current__pfx--below');
            let aParticleAmbSettings = GetSkillGroupAmbientSettings(oData.old_rating, oData.mode);
            elParticleAmb.SetParticleNameAndRefresh(aParticleAmbSettings.particleName);
            elParticleAmb.SetControlPoint(aParticleAmbSettings.cpNumber, aParticleAmbSettings.cpValue[0], aParticleAmbSettings.cpValue[1], 0);
            elParticleAmb.StartParticles();
        }
    }
    function GetEmblemStyleOverride(new_rating) {
        return new_rating < 1000 ? 'digitpanel-container-3-digit-offset' : new_rating < 10000 ? 'digitpanel-container-4-digit-offset' : '';
    }
    function _FilloutPremierRankData(oData) {
        let options = {
            root_panel: _m_cP.FindChildInLayoutFile('jsRatingEmblem'),
            xuid: MockAdapter.GetLocalPlayerXuid(),
            leaderboard_details: { score: oData.old_rating, matchesWon: oData.num_wins },
            do_fx: false,
            rating_type: oData.mode,
            presentation: 'digital',
            eom_digipanel_class_override: GetEmblemStyleOverride(oData.old_rating),
            full_details: true,
        };
        if (oData.rating_change === 0) {
            RatingEmblem.SetXuid(options);
            let winLossStyle = GetWinLossStyle(oData);
            _m_cP.FindChildInLayoutFile('jsRatingEmblem').SwitchClass('winloss', winLossStyle + '-anim');
            PremierRankText(oData);
            SpeedLinesAnim(winLossStyle);
            RatingEmblemAnim(oData, options, winLossStyle);
            return;
        }
        RatingEmblem.SetXuid(options);
    }
    function PremierRankText(oData) {
        SetWinDescString(oData, _m_cP.FindChildInLayoutFile("id-eom-skillgroup-premier-wins-desc"));
        _m_cP.SetDialogVariable('total-wins', oData.num_wins.toString());
        let desc;
        let nPoints;
        if (oData.new_rating > 0 && oData.old_rating < 1) {
            desc = $.Localize('#cs_rating_rating_established');
            nPoints = 0;
        }
        else {
            desc = RatingEmblem.GetEomDescText(_m_cP.FindChildInLayoutFile('jsRatingEmblem'));
            nPoints = Math.abs(oData.rating_change);
        }
        if (oData.rating_mismatch) {
            _m_cP.SetDialogVariable('premier-desc', $.Localize('#cs_rating_mismatch'));
        }
        else if (desc && desc !== '') {
            _m_cP.SetDialogVariable('premier-desc', desc);
        }
        _m_cP.FindChildInLayoutFile('id-eom-skillgroup-premier-desc').SetHasClass('hide', desc === '' || !desc);
        let sPointsString = '';
        sPointsString = oData.new_rating >= oData.old_rating ? "#eom-premier-points-gained" : "#eom-premier-points-lost";
        _m_cP.SetDialogVariableInt('premier_points', nPoints);
        _m_cP.FindChildInLayoutFile('id-eom-skillgroup-premier-points').text = $.Localize(sPointsString, _m_cP);
    }
    function GetWinLossStyle(oData) {
        let winLossStyle = ((oData.new_rating === 0) || (oData.new_rating > 0 && oData.old_rating < 1) || !oData.rating_change) ?
            'no-points' : oData.rating_change < 0 ?
            'lost-points' : oData.rating_change > 0 ?
            'gain-points' : '';
        return winLossStyle;
    }
    function SpeedLinesAnim(winLossStyle) {
        $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Premier.EOM.SlideIn', 'MOUSE');
        $.Schedule(.25, () => {
            if (!_m_cP || !_m_cP.IsValid())
                return;
            let speedLines = _m_cP.FindChildInLayoutFile('id-eom-premier-speed-lines');
            if (speedLines && speedLines.IsValid()) {
                speedLines.SetMovie("file://{resources}/videos/speed_lines.webm");
                speedLines.SwitchClass('winloss', winLossStyle);
                speedLines.SetControls('none');
                speedLines.Play();
            }
        });
    }
    function RatingEmblemAnim(oData, options, winLossStyle) {
        PlayPremierRankSound(winLossStyle);
        $.Schedule(.75, () => {
            if (!elPanel || !elPanel.IsValid() || !options.root_panel || !options.root_panel.IsValid())
                return;
            RatingEmblem.SetXuid(options);
            PremierRankText(oData);
            elPanel.SwitchClass('tier', RatingEmblem.GetTierColorClass(_m_cP.FindChildInLayoutFile('jsRatingEmblem')));
        });
        let elPanel = _m_cP.FindChildInLayoutFile('id-eom-skillgroup-premier-bg');
        elPanel.SwitchClass('winloss', winLossStyle);
    }
    function PlayPremierRankSound(winLossStyle) {
        if (winLossStyle === 'no-points') {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Premier.EOM.RankNeutral', 'MOUSE');
        }
        else if (winLossStyle === 'lost-points') {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Premier.EOM.RankDown', 'MOUSE');
        }
        else {
            $.DispatchEvent('CSGOPlaySoundEffect', 'UI.Premier.EOM.RankUp', 'MOUSE');
        }
    }
    function SetWinDescString(oData, elLabel) {
        elLabel.SetDialogVariableInt("matcheswon", oData.num_wins);
        elLabel.text = $.Localize('#eom-skillgroup-win', elLabel);
    }
    function Start() {
        if (_DisplayMe()) {
            EndOfMatch.SwitchToPanel('eom-skillgroup');
            EndOfMatch.StartDisplayTimer(_m_pauseBeforeEnd);
            $.Schedule(_m_pauseBeforeEnd, _End);
        }
        else {
            _End();
            return;
        }
    }
    EOM_Skillgroup.Start = Start;
    function _End() {
        EndOfMatch.ShowNextPanel();
    }
    function Shutdown() {
    }
    EOM_Skillgroup.Shutdown = Shutdown;
    function name() {
        return 'eom-skillgroup';
    }
    EOM_Skillgroup.name = name;
})(EOM_Skillgroup || (EOM_Skillgroup = {}));
(function () {
    EndOfMatch.RegisterPanelObject({
        name: 'eom-skillgroup',
        Start: EOM_Skillgroup.Start,
        Shutdown: EOM_Skillgroup.Shutdown
    });
})();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZW5kb2ZtYXRjaC1za2lsbGdyb3VwLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vLi4vY29udGVudC9jc2dvL3Bhbm9yYW1hL3NjcmlwdHMvZW5kb2ZtYXRjaC1za2lsbGdyb3VwLnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxrQ0FBa0M7QUFDbEMsNkNBQTZDO0FBQzdDLHdDQUF3QztBQUN4QyxxREFBcUQ7QUFDckQsc0NBQXNDO0FBa0N0QyxJQUFVLGNBQWMsQ0EyZHZCO0FBM2RELFdBQVUsY0FBYztJQUV2QixJQUFJLGlCQUFpQixHQUFHLEdBQUcsQ0FBQztJQUM1QixJQUFJLEtBQUssR0FBbUMsQ0FBQyxDQUFDLGVBQWUsRUFBRSxDQUFDO0lBSWhFLFNBQVMsSUFBSSxDQUFHLEdBQVc7SUFHM0IsQ0FBQztJQUVELEtBQUssQ0FBQyxJQUFJLEVBQUUsQ0FBQyxTQUFTLEdBQUcsQ0FBQyxDQUFDO0lBRTNCLFNBQVMsVUFBVTtRQVFsQixJQUFLLENBQUMsS0FBSyxJQUFJLENBQUMsS0FBSyxDQUFDLE9BQU8sRUFBRTtZQUM5QixPQUFPLEtBQUssQ0FBQztRQUVkLE1BQU0sRUFBRSxDQUFDO1FBRVQsSUFBSyxDQUFDLFdBQVcsQ0FBQyxvQkFBb0IsQ0FBRSxLQUFLLENBQUUsRUFDL0M7WUFDQyxPQUFPLEtBQUssQ0FBQztTQUNiO1FBRUQsSUFBSSxZQUFZLENBQUMsZ0JBQWdCLEVBQUUsS0FBSyxVQUFVLEVBQ2xEO1lBQ0MsT0FBTyxLQUFLLENBQUM7U0FDYjtRQUVELElBQUksZUFBZSxHQUFHLFdBQVcsQ0FBQyxpQkFBaUIsQ0FBRSxLQUFLLENBQUUsQ0FBQztRQUM3RCxJQUFJLGlCQUFpQixHQUFHLGVBQWUsQ0FBRSxXQUFXLENBQUMsa0JBQWtCLEVBQUUsQ0FBRSxDQUFDO1FBRTVFLElBQUssQ0FBQyxpQkFBaUI7WUFDdEIsT0FBTyxLQUFLLENBQUM7UUFFZCxNQUFNLGVBQWUsR0FBRyxpQkFBaUIsQ0FBQyxRQUFR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