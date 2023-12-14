function ServerSettings()


SendToServerConsole ("sv_accelerate 10")
SendToServerConsole ("sv_airaccelerate 800")
SendToServerConsole ("mp_warmup_pausetimer 1")

Msg("server settings set")

end

function ResetVelocity(player)

--print ( player.activator:entindex() )

player.activator:SetVelocity(Vector (0,0,0))

end