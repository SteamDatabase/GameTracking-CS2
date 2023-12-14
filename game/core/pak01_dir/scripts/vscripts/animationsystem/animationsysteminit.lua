--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
-- Script that is run when the animationsystem vscript system starts
--
--=============================================================================

---------------------------------------------------------------------
-- print out an error message and the call stack 
---------------------------------------------------------------------
function Log_Error( sError )
    errorMessage = "!!!ERROR!!!: " .. sError 
    print ( debug.traceback( errorMessage, 2 )  )
end
