import { Instance } from "serverpointentity";
let ConvDir = false;
let ConvPow = false;
function SetConveyorSpeed(name, speed, transitionDuration = 10) {
    Instance.EntFireBroadcast(name, "SetTransitionDuration", transitionDuration.toString());
    Instance.EntFireBroadcast(name, "SetSpeed", speed.toString());
}
function ConveyorReset() {
    Instance.EntFireBroadcast("conveyor_power_switch_mover", "Close");
    Instance.EntFireBroadcast("conveyor_power_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("conveyor_power_indicator", "Skin", "0");
    Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("button_stop_indicator", "Skin", "0");
    //Instance.EntFireBroadcast( "button_stop_light", "Skin", "0" );
    Instance.EntFireBroadcast("button_stop", "Lock");
    Instance.EntFireBroadcast("conveyor_control_sign", "SetSpeed", "0");
    SetConveyorSpeed("conveyor_a2_upper_mid", 0);
    SetConveyorSpeed("conveyor_a2_upper_cross_06", 0);
    SetConveyorSpeed("conveyor_a2_upper_cross_05", 0);
    SetConveyorSpeed("conveyor_a2_upper_cross_04", 0);
    SetConveyorSpeed("conveyor_a2_upper_cross_03", 0);
    SetConveyorSpeed("conveyor_a2_upper_cross_02", 0);
    SetConveyorSpeed("conveyor_a2_upper_cross_01", 0);
    SetConveyorSpeed("conveyor_a2_lower_02", 0);
    SetConveyorSpeed("conveyor_a2_lower_01", 0);
    SetConveyorSpeed("conveyor_a1_upper_mid", 0);
    SetConveyorSpeed("conveyor_a1_upper_cross_06", 0);
    SetConveyorSpeed("conveyor_a1_upper_cross_05", 0);
    SetConveyorSpeed("conveyor_a1_upper_cross_04", 0);
    SetConveyorSpeed("conveyor_a1_upper_cross_03", 0);
    SetConveyorSpeed("conveyor_a1_upper_cross_02", 0);
    SetConveyorSpeed("conveyor_a1_upper_cross_01", 0);
    SetConveyorSpeed("conveyor_a1_lower_03", 0);
    SetConveyorSpeed("conveyor_a1_lower_02", 0);
    SetConveyorSpeed("conveyor_a1_lower_01", 0);
}
function ConveyorStop() {
    Instance.EntFireBroadcast("conveyor_power_switch_mover", "Close");
    Instance.EntFireBroadcast("conveyor_power_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("conveyor_power_indicator", "Skin", "0");
    Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("button_stop_indicator", "Skin", "0");
    //Instance.EntFireBroadcast( "button_stop_light", "Skin", "0" );
    Instance.EntFireBroadcast("button_stop", "Lock");
    Instance.EntFireBroadcast("conveyor_control_sign", "SetSpeed", "0");
    SetConveyorSpeed("conveyor_a2_upper_mid", 0, 1);
    SetConveyorSpeed("conveyor_a2_upper_cross_06", 0, 1);
    SetConveyorSpeed("conveyor_a2_upper_cross_05", 0, 1);
    SetConveyorSpeed("conveyor_a2_upper_cross_04", 0, 1);
    SetConveyorSpeed("conveyor_a2_upper_cross_03", 0, 1);
    SetConveyorSpeed("conveyor_a2_upper_cross_02", 0, 1);
    SetConveyorSpeed("conveyor_a2_upper_cross_01", 0, 1);
    SetConveyorSpeed("conveyor_a2_lower_02", 0, 1);
    SetConveyorSpeed("conveyor_a2_lower_01", 0, 1);
    SetConveyorSpeed("conveyor_a1_upper_mid", 0, 1);
    SetConveyorSpeed("conveyor_a1_upper_cross_06", 0, 1);
    SetConveyorSpeed("conveyor_a1_upper_cross_05", 0, 1);
    SetConveyorSpeed("conveyor_a1_upper_cross_04", 0, 1);
    SetConveyorSpeed("conveyor_a1_upper_cross_03", 0, 1);
    SetConveyorSpeed("conveyor_a1_upper_cross_02", 0, 1);
    SetConveyorSpeed("conveyor_a1_upper_cross_01", 0, 1);
    SetConveyorSpeed("conveyor_a1_lower_03", 0, 1);
    SetConveyorSpeed("conveyor_a1_lower_02", 0, 1);
    SetConveyorSpeed("conveyor_a1_lower_01", 0, 1);
    Instance.EntFireBroadcast("snd.conveyor_winddown", "PlaySound");
}
function ConveyorPlane() {
    Instance.EntFireBroadcast("conveyor_dir_switch_mover", "Close");
    Instance.EntFireBroadcast("button_stop", "Lock");
    Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("button_stop_indicator", "Skin", "0");
    //Instance.EntFireBroadcast( "button_stop_light", "Skin", "0" );
    SetConveyorSpeed("conveyor_a2_upper_mid", -5);
    SetConveyorSpeed("conveyor_a2_upper_cross_06", -190);
    SetConveyorSpeed("conveyor_a2_upper_cross_05", -190);
    SetConveyorSpeed("conveyor_a2_upper_cross_04", -190);
    SetConveyorSpeed("conveyor_a2_upper_cross_03", -20);
    SetConveyorSpeed("conveyor_a2_upper_cross_02", -20);
    SetConveyorSpeed("conveyor_a2_upper_cross_01", -20);
    SetConveyorSpeed("conveyor_a2_lower_02", -190);
    SetConveyorSpeed("conveyor_a2_lower_01", -190);
    SetConveyorSpeed("conveyor_a1_upper_mid", -5);
    SetConveyorSpeed("conveyor_a1_upper_cross_06", -190);
    SetConveyorSpeed("conveyor_a1_upper_cross_05", -190);
    SetConveyorSpeed("conveyor_a1_upper_cross_04", -190);
    SetConveyorSpeed("conveyor_a1_upper_cross_03", -20);
    SetConveyorSpeed("conveyor_a1_upper_cross_02", -20);
    SetConveyorSpeed("conveyor_a1_upper_cross_01", -20);
    SetConveyorSpeed("conveyor_a1_lower_03", -190);
    SetConveyorSpeed("conveyor_a1_lower_02", -190);
    SetConveyorSpeed("conveyor_a1_lower_01", -190);
    Instance.EntFireBroadcast("conveyor_control_sign", "SetSpeed", "-190");
    Instance.EntFireBroadcast("conveyor_direction_button", "Lock");
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Skin", "0");
    Instance.EntFireBroadcast("button_stop", "Unlock", "", 11); // Delay working? 
    Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 0 0", 11); //Delay working?
    Instance.EntFireBroadcast("button_stop_indicator", "Skin", "1", 11);
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Color", "0 255 0", 11); //Delay working?
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Skin", "1", 11);
    Instance.EntFireBroadcast("conveyor_direction_button", "Unlock", "", 11); //Delay working?
}
function ConveyorBaggage() {
    Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("button_stop_indicator", "Skin", "0");
    //Instance.EntFireBroadcast( "button_stop_light", "Skin", "0" );
    Instance.EntFireBroadcast("button_stop", "Lock");
    Instance.EntFireBroadcast("conveyor_dir_switch_mover", "Open");
    Instance.EntFireBroadcast("relay.snd.direction_change", "Trigger");
    SetConveyorSpeed("conveyor_a2_upper_mid", 5);
    SetConveyorSpeed("conveyor_a2_upper_cross_06", 20);
    SetConveyorSpeed("conveyor_a2_upper_cross_05", 20);
    SetConveyorSpeed("conveyor_a2_upper_cross_04", 20);
    SetConveyorSpeed("conveyor_a2_upper_cross_03", 190);
    SetConveyorSpeed("conveyor_a2_upper_cross_02", 190);
    SetConveyorSpeed("conveyor_a2_upper_cross_01", 190);
    SetConveyorSpeed("conveyor_a2_lower_02", 190);
    SetConveyorSpeed("conveyor_a2_lower_01", 190);
    SetConveyorSpeed("conveyor_a1_upper_mid", 5);
    SetConveyorSpeed("conveyor_a1_upper_cross_06", 20);
    SetConveyorSpeed("conveyor_a1_upper_cross_05", 20);
    SetConveyorSpeed("conveyor_a1_upper_cross_04", 20);
    SetConveyorSpeed("conveyor_a1_upper_cross_03", 190);
    SetConveyorSpeed("conveyor_a1_upper_cross_02", 190);
    SetConveyorSpeed("conveyor_a1_upper_cross_01", 190);
    SetConveyorSpeed("conveyor_a1_lower_03", 190);
    SetConveyorSpeed("conveyor_a1_lower_02", 190);
    SetConveyorSpeed("conveyor_a1_lower_01", 190);
    Instance.EntFireBroadcast("conveyor_control_sign", "SetSpeed", "190");
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Color", "255 255 255");
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Skin", "0");
    Instance.EntFireBroadcast("conveyor_direction_button", "Lock");
    Instance.EntFireBroadcast("button_stop", "Unlock", "", 11); // Delay working? 
    Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 0 0", 11); //Delay working?
    Instance.EntFireBroadcast("button_stop_indicator", "Skin", "1", 11);
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Color", "0 255 0", 11); //Delay working?
    Instance.EntFireBroadcast("conveyor_dir_indicator", "Skin", "1", 11);
    Instance.EntFireBroadcast("conveyor_direction_button", "Unlock", "", 11); //Delay working?
}
Instance.PublicMethod("ToggleDir", () => {
    ConvDir = !ConvDir;
    if (ConvDir == false && ConvPow == true) {
        ConveyorPlane();
        Instance.EntFireBroadcast("snd.conveyor_reverse", "PlaySound");
    }
    if (ConvDir == true && ConvPow == true) {
        ConveyorBaggage();
        Instance.EntFireBroadcast("snd.conveyor_reverse", "PlaySound");
    }
    if (ConvDir == true && ConvPow == false) {
        Instance.EntFireBroadcast("conveyor_dir_switch_mover", "Open");
    }
    if (ConvDir == false && ConvPow == false) {
        Instance.EntFireBroadcast("conveyor_dir_switch_mover", "Close");
    }
});
Instance.PublicMethod("TogglePow", () => {
    ConvPow = !ConvPow;
    if (ConvPow == true && ConvDir == false) {
        Instance.EntFireBroadcast("conveyor_power_switch_mover", "Open");
        Instance.EntFireBroadcast("conveyor_power_indicator", "Color", "0 255 0");
        Instance.EntFireBroadcast("conveyor_power_indicator", "Skin", "1");
        Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 0 0");
        Instance.EntFireBroadcast("button_stop_indicator", "Skin", "1");
        Instance.EntFireBroadcast("snd.conveyor_loop", "PlaySound");
        Instance.EntFireBroadcast("snd.conveyor_windup_loop", "PlaySound");
        StopStopLightLoop();
        ConveyorPlane();
    }
    if (ConvPow == true && ConvDir == true) {
        Instance.EntFireBroadcast("conveyor_power_switch_mover", "Open");
        Instance.EntFireBroadcast("conveyor_power_indicator", "Color", "0 255 0");
        Instance.EntFireBroadcast("conveyor_power_indicator", "Skin", "1");
        Instance.EntFireBroadcast("button_stop_indicator", "Color", "255 0 0");
        Instance.EntFireBroadcast("button_stop_indicator", "Skin", "1");
        Instance.EntFireBroadcast("snd.conveyor_loop", "PlaySound");
        Instance.EntFireBroadcast("snd.conveyor_windup_loop", "PlaySound");
        StopStopLightLoop();
        ConveyorBaggage();
    }
    if (ConvPow == false) {
        Instance.EntFireBroadcast("snd.conveyor_loop", "StopSound");
        Instance.EntFireBroadcast("snd.conveyor_windup_loop", "StopSound");
        ConveyorReset();
    }
});
Instance.PublicMethod("PowOff", () => {
    if (ConvPow == true) {
        ConvPow = !ConvPow;
        ConveyorStop();
        Instance.EntFireBroadcast("snd.conveyor_winddown", "PlaySound");
        Instance.EntFireBroadcast("snd.conveyor_loop", "StopSound");
        Instance.EntFireBroadcast("snd.conveyor_windup_loop", "StopSound");
        StartStopLightLoop();
        Instance.EntFireBroadcast("button_stop", "Lock");
    }
});
let bLooping = false;
function StartStopLightLoop() {
    bLooping = true;
    Instance.EntFireBroadcast("button_stop_light_loop", "Trigger", "");
}
Instance.PublicMethod("StopLightLoop", () => {
    if (bLooping == false)
        return;
    Instance.EntFireBroadcast("button_stop_light", "Skin", "1", 0);
    Instance.EntFireBroadcast("button_stop_light", "Skin", "0", 0.15);
    Instance.EntFireBroadcast("button_stop_light", "Skin", "1", .3);
    Instance.EntFireBroadcast("button_stop_light", "Skin", "0", .45);
    Instance.EntFireBroadcast("button_stop_light_loop", "Trigger", "", 1.5);
});
function StopStopLightLoop() {
    Instance.EntFireBroadcast("button_stop_light", "Skin", "0");
    bLooping = false;
}
