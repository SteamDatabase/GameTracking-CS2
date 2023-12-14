--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
-- Script that is run when the modelprocessing vscript system starts
--
--=============================================================================


-------------------------------------------------------------------------------
-- returns a string like "foo.nut:53"
-- with the source file and line number of its caller.
-- returns the empty string if it couldn't get the source file and line number of its caller.
-------------------------------------------------------------------------------
function _sourceline() 
    local v = debug.getinfo( 2 )
    if v then 
        return tostring( v.source ) .. ":" .. tostring( v.currentline ) .. " "
    else 
        return ""
    end
end


-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
--print( "<<< modelprocessing script system - Initializing script VM..." .. _sourceline() )

require "utils.library"

--print( ">>> modelprocessing script system ...done" )
