"use strict";
/// <reference path="csgo.d.ts" />
var HonorIcon;
(function (HonorIcon) {
    function ColorConvert(tier) {
        let rarityColors = [
            ["default", 176, 195, 217, 0, 0, -.8, "particles/ui/ui_exp_streak_t0.vpcf"],
            ["common", 176, 195, 217, 0, 0, -.8, "particles/ui/ui_exp_streak_t1.vpcf"],
            ["uncommon", 94, 152, 217, 0, .2, -.5, "particles/ui/ui_exp_streak_t2.vpcf"],
            ["rare", 75, 105, 255, 0, .35, -.2, "particles/ui/ui_exp_streak_t3.vpcf"],
            ["mythical", 136, 71, 255, 0, .3, .1, "particles/ui/ui_exp_streak_t4.vpcf"],
            ["legendary", 211, 44, 230, 0, .35, .2, "particles/ui/ui_exp_streak_t5.vpcf"],
            ["ancient", 235, 75, 75, 0, .5, .2, "particles/ui/ui_exp_streak_t6.vpcf"],
            ["unusual", 235, 75, 75, 0, .5, 1, "particles/ui/ui_exp_streak_t7.vpcf"],
        ];
        if (!tier)
            tier = 0;
        else if (tier < 0)
            tier = 0;
        else if (tier >= rarityColors.length)
            tier = rarityColors.length - 1;
        let R = rarityColors[tier][1];
        let G = rarityColors[tier][2];
        let B = rarityColors[tier][3];
        let H = rarityColors[tier][4];
        let S = rarityColors[tier][5];
        let V = rarityColors[tier][6];
        let ParticleEffect = rarityColors[tier][7];
        return { R, G, B, H, S, V, ParticleEffect };
    }
    HonorIcon.ColorConvert = ColorConvert;
    function SetOptionsEventHandler(elPanel, do_fx, xptrail_value, prime_value) {
        const options = {
            honor_icon_frame_panel: elPanel,
            do_fx: do_fx,
            xptrail_value: xptrail_value,
            prime_value: prime_value,
        };
        SetOptions(options);
    }
    $.RegisterEventHandler("HonorIcon_SetOptions", $.GetContextPanel(), SetOptionsEventHandler);
    function SetOptions(options) {
        const honor_icon_frame_panel = options.honor_icon_frame_panel;
        if (!honor_icon_frame_panel || !honor_icon_frame_panel.IsValid())
            return;
        _SetHonorImage(options);
    }
    HonorIcon.SetOptions = SetOptions;
    function _SetHonorImage(options) {
        const honor_icon_frame_panel = options.honor_icon_frame_panel;
        const do_fx = options.hasOwnProperty('do_fx') ? options.do_fx : false;
        const force_icon = options.hasOwnProperty('force_icon') ? options.force_icon : '';
        const fallback_to_prime = options.hasOwnProperty('prime_value');
        const debug_xuid = options.hasOwnProperty('debug_xuid') ? options.debug_xuid : '';
        const xptrail_value = options.xptrail_value;
        const prime_value = options.hasOwnProperty('prime_value') ? options.prime_value : false;
        const bForcePrime = (force_icon === 'prime');
        const bForceXpTrail = (force_icon === 'xptrail');
        const bShowXpTrail = !bForcePrime && ((xptrail_value > 0) || bForceXpTrail);
        const bShowPrime = bForcePrime || (fallback_to_prime && prime_value);
        if (bShowXpTrail) {
            honor_icon_frame_panel.SwitchClass('icon-to-show', 'show-honor');
            honor_icon_frame_panel.SetDialogVariableInt('xptrail-streak', xptrail_value);
        }
        else if (bShowPrime) {
            honor_icon_frame_panel.SwitchClass('icon-to-show', 'show-prime');
        }
        else {
            honor_icon_frame_panel.SwitchClass('icon-to-show', 'show-none');
        }
        const elPFXRing = honor_icon_frame_panel.FindChildTraverse('JsHonorParticlesRing');
        const elPFX = honor_icon_frame_panel.FindChildTraverse('JsHonorParticles');
        if (bShowXpTrail) {
            let tierXpColor = ColorConvert(xptrail_value);
            if (!do_fx) {
                if (xptrail_value > 0) {
                    elPFX.SetParticleNameAndRefresh("particles/ui/ui_exp_streak.vpcf");
                    elPFX.SetControlPoint(16, tierXpColor.R, tierXpColor.G, tierXpColor.B);
                    elPFX.SetControlPoint(17, tierXpColor.H, tierXpColor.S, tierXpColor.V);
                }
                else {
                    elPFX.StopParticlesImmediately(true);
                    elPFXRing.StopParticlesImmediately(true);
                }
            }
            else {
                elPFX.SetParticleNameAndRefresh(tierXpColor.ParticleEffect);
                elPFX.SetControlPoint(16, tierXpColor.R, tierXpColor.G, tierXpColor.B);
                elPFX.SetControlPoint(17, tierXpColor.H, tierXpColor.S, tierXpColor.V);
                elPFXRing.StartParticles();
                elPFXRing.SetControlPoint(16, tierXpColor.R, tierXpColor.G, tierXpColor.B);
                elPFXRing.SetControlPoint(17, tierXpColor.H, tierXpColor.S, tierXpColor.V);
            }
        }
    }
})(HonorIcon || (HonorIcon = {}));
