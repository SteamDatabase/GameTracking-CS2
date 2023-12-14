function ServerSettings()

SendToServerConsole ("bot_quota 16")
SendToServerConsole ("bot_stop 1")
SendToServerConsole ("bot_knives_only")  -- nonfunctional 
SendToServerConsole ("bot_join_after_player 1")
SendToServerConsole ("bot_join_team T")
SendToServerConsole ("bot_difficulty 0")


SendToServerConsole ("sv_infinite_ammo 1")


SendToServerConsole ("mp_freezetime 0")
SendToServerConsole ("mp_warmuptime 1")
SendToServerConsole ("mp_humanteam CT")

SendToServerConsole ("mp_respawn_on_death_ct 1")
SendToServerConsole ("mp_respawn_on_death_t 1")
SendToServerConsole ("mp_respawn_immunitytime -1")
SendToServerConsole ("mp_free_armor 0")
SendToServerConsole ("mp_death_drop_gun 0")



SendToServerConsole ("mp_limitteams 0")
SendToServerConsole ("mp_autoteambalance 0")
SendToServerConsole ("mp_join_grace_time 10")
SendToServerConsole ("mp_autokick 0")

SendToServerConsole ("mp_ignore_round_win_conditions 1")
SendToServerConsole ("mp_default_team_winner_no_objective 1")

SendToServerConsole ("mp_roundtime_hostage 60")
SendToServerConsole ("mp_roundtime_defuse 60")
SendToServerConsole ("mp_roundtime 60")
SendToServerConsole ("mp_maxrounds 999")



SendToServerConsole ("mp_buy_anywhere 1")
SendToServerConsole ("mp_buytime 9999999")

SendToServerConsole ("mp_warmup_online_enabled 0")

SendToServerConsole ("mp_playercashawards 0")



Msg("server settings set")

end

-- spawn spread
-- 1 = narrow
-- 2 = default (45 degree)
-- 3 = wide
spread_amount = 2

function SpreadUpdate()

if spread_amount == 3 then spread_amount = 1 else spread_amount = spread_amount + 1 end 

print(spread_amount)

end

function ResetVelocity(player)

--print ( player.activator:entindex() )

player.activator:SetVelocity(Vector (0,0,0))

end

function SetSizeWide()

Msg("setting 90 degree sides")
EntFire( "thisEntity", "spawns.group*", "SetEnabled", 0, 0 ) --set all side spawns as enabled

end

function SetSizeDefault()

Msg("setting 45 degree sides")

end

function SetSizeNarrow()

Msg("setting 0 degree sides")
EntFire( "thisEntity", "spawns.group*", "SetDisabled", 0, 0 ) --set all side spawns as disabled

end