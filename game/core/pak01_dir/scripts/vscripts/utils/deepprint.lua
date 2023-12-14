--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
--
--=============================================================================

--/////////////////////////////////////////////////////////////////////////////
-- Debug helpers
--
--  Things that are really for during development - you really should never call any of this
--  in final/real/workshop submitted code
--/////////////////////////////////////////////////////////////////////////////

-- if you want a table printed to console formatted like a table (dont we already have this somewhere?)
scripthelp_DeepPrintTable = "Print out a table (and subtables) to the console"

function _DeepPrintMetaTable( debugMetaTable, prefix )
	_DeepPrintTable( debugMetaTable, prefix, false, false )
	if getmetatable( debugMetaTable ) ~= nil and getmetatable( debugMetaTable ).__index ~= nil then
		_DeepPrintMetaTable( getmetatable( debugMetaTable ).__index, prefix )
	end
end

function _DeepPrintTable(debugInstance, prefix, isOuterScope, chaseMetaTables ) 
    prefix = prefix or ""
    local string_accum = ""
    if debugInstance == nil then 
		print( prefix .. "<nil>" )
		return
    end
	local terminatescope = false
	local oldPrefix = ""
    if isOuterScope then  -- special case for outer call - so we dont end up iterating strings, basically
        if type(debugInstance) == "table" then 
            print( prefix .. "{" )
			oldPrefix = prefix
            prefix = prefix .. "   "
			terminatescope = true
        else 
            print( prefix .. " = " .. (type(debugInstance) == "string" and ("\"" .. debugInstance .. "\"") or debugInstance))
        end
    end
    local debugOver = debugInstance

	-- First deal with metatables
	if chaseMetaTables == true then
		if getmetatable( debugOver ) ~= nil and getmetatable( debugOver ).__index ~= nil then
			local thisMetaTable = getmetatable( debugOver ).__index 
			if vlua.find(_deepprint_alreadyseen, thisMetaTable ) ~= nil then 
				print( string.format( "%s%-32s\t= %s (table, already seen)", prefix, "metatable", tostring( thisMetaTable ) ) )
			else
				print(prefix .. "metatable = " .. tostring( thisMetaTable ) )
				print(prefix .. "{")
				table.insert( _deepprint_alreadyseen, thisMetaTable )
				_DeepPrintMetaTable( thisMetaTable, prefix .. "   ", false )
				print(prefix .. "}")
			end
		end
	end

	-- Now deal with the elements themselves
    for idx, data_value in pairs(debugOver) do
        if type(data_value) == "table" then 
            if vlua.find(_deepprint_alreadyseen, data_value) ~= nil then 
                print( string.format( "%s%-32s\t= %s (table, already seen)", prefix, idx, tostring( data_value ) ) )
            else
                local is_array = #data_value > 0
				local test = 1
				for idx2, val2 in pairs(data_value) do
					if type( idx2 ) ~= "number" or idx2 ~= test then
						is_array = false
						break
					end
					test = test + 1
				end
				local valtype = type(data_value)
				if is_array == true then
					valtype = "array table"
				end
                print( string.format( "%s%-32s\t= %s (%s)", prefix, idx, tostring(data_value), valtype ) )
                print(prefix .. (is_array and "[" or "{"))
                table.insert(_deepprint_alreadyseen, data_value)
                _DeepPrintTable(data_value, prefix .. "   ", false, true)
                print(prefix .. (is_array and "]" or "}"))
            end
		elseif type(data_value) == "string" then 
            print( string.format( "%s%-32s\t= \"%s\" (%s)", prefix, idx, data_value, type(data_value) ) )
		else 
            print( string.format( "%s%-32s\t= %s (%s)", prefix, idx, tostring(data_value), type(data_value) ) )
        end
    end
	if terminatescope == true then
		print( oldPrefix .. "}" )
	end
end


function DeepPrintTable( debugInstance, prefix, isPublicScriptScope ) 
    prefix = prefix or ""
    _deepprint_alreadyseen = {}
    table.insert(_deepprint_alreadyseen, debugInstance)
    _DeepPrintTable(debugInstance, prefix, true, isPublicScriptScope )
end


--/////////////////////////////////////////////////////////////////////////////
-- Fancy new DeepPrint - handles instances, and avoids cycles
--
--/////////////////////////////////////////////////////////////////////////////

-- @todo: this is hideous, there must be a "right way" to do this, im dumb!
-- outside the recursion table of seen recurses so we dont cycle into our components that refer back to ourselves
_deepprint_alreadyseen = {}


-- the inner recursion for the deep print
function _DeepToString(debugInstance, prefix) 
    local string_accum = ""
    if debugInstance == nil then 
        return "Deep Print of NULL" .. "\n"
    end
    if prefix == "" then  -- special case for outer call - so we dont end up iterating strings, basically
        if type(debugInstance) == "table" or type(debugInstance) == "table" or type(debugInstance) == "UNKNOWN" or type(debugInstance) == "table" then 
            string_accum = string_accum .. (type(debugInstance) == "table" and "[" or "{") .. "\n"
            prefix = "   "
        else 
            return " = " .. (type(debugInstance) == "string" and ("\"" .. debugInstance .. "\"") or debugInstance) .. "\n"
        end
    end
    local debugOver = type(debugInstance) == "UNKNOWN" and getclass(debugInstance) or debugInstance
    for idx, val in pairs(debugOver) do
        local data_value = debugInstance[idx]
        if type(data_value) == "table" or type(data_value) == "table" or type(data_value) == "UNKNOWN" or type(data_value) == "table" then 
            if vlua.find(_deepprint_alreadyseen, data_value) ~= nil then 
                string_accum = string_accum .. prefix .. idx .. " ALREADY SEEN " .. "\n"
            else 
                local is_array = type(data_value) == "table"
                string_accum = string_accum .. prefix .. idx .. " = ( " .. type(data_value) .. " )" .. "\n"
                string_accum = string_accum .. prefix .. (is_array and "[" or "{") .. "\n"
                table.insert(_deepprint_alreadyseen, data_value)
                string_accum = string_accum .. _DeepToString(data_value, prefix .. "   ")
                string_accum = string_accum .. prefix .. (is_array and "]" or "}") .. "\n"
            end
        else 
            local string_value = data_value

            if type(data_value) == 'string' then
                string_value = '"' .. data_value .. '"'
            elseif type(data_value) == 'userdata' then
                local mtable = getmetatable(data_value)

                if mtable ~= nil and mtable['__name'] ~= nil then
                    local name = mtable['__name']
                    string_value = '(userdata: ' .. name .. ')'
                else
                    string_value = '(' .. tostring(data_value) .. ')'
                end
            else
                string_value = '(' .. tostring(data_value) .. ')'
            end

            string_accum = string_accum .. prefix .. idx .. "\t= " .. string_value  .. "\n"
        end
    end
    if prefix == "   " then 
        string_accum = string_accum .. (type(debugInstance) == "table" and "]" or "}") .. "\n" -- hack for "proving" at end - this is DUMB!
    end
    return string_accum
end


scripthelp_DeepString = "Convert a class/array/instance/table to a string"

function DeepToString(debugInstance, prefix) 
    prefix = prefix or ""
    _deepprint_alreadyseen = {}
    table.insert(_deepprint_alreadyseen, debugInstance)
    return _DeepToString(debugInstance, prefix)
end


scripthelp_DeepPrint = "Print out a class/array/instance/table to the console"

function DeepPrint(debugInstance, prefix) 
    prefix = prefix or ""
    print(DeepToString(debugInstance, prefix))
end
