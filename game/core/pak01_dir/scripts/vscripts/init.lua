--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
--
--=============================================================================

Msg( "Initializing script VM...\n" )


-------------------------------------------------------------------------------


-- returns a string like "foo.nut:53"
-- with the source file and line number of its caller.
-- returns the empty string if it couldn't get the source file and line number of its caller.
function _sourceline() 
    local v = debug.getinfo(2, "sl")
    if v then 
        return tostring(v.source) .. ":" .. tostring(v.currentline) .. " "
    else 
        return ""
    end
end

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
require "utils.class"
require "utils.library"
require "utils.vscriptinit"
require "core.coreinit"
require "utils.utilsinit"
require "framework.frameworkinit"
require "framework.entities.entitiesinit"
require "game.gameinit"

function DumpScriptBindings()
	function BuildFunctionSignatureString( fnName, fdesc )
		local docList = {}
		table.insert( docList, string.format( "---[[ %s  %s ]]", fnName, fdesc.desc ) )
		table.insert( docList, string.format( "-- @return %s", fdesc.returnType ) )
		local parameterList = {}
		for i = 0, #fdesc-1 do
			local prmType, prmName = unpack( fdesc[i] )
			if prmName == nil or prmName == "" then prmName = string.format( "%s_%d", prmType, i+1 ) end
			table.insert( docList, string.format( "-- @param %s %s", prmName, prmType ) )
			table.insert( parameterList, prmName )
		end
		return string.format( "%s\nfunction %s( %s ) end\n", table.concat( docList, "\n"), fnName, table.concat( parameterList, ", " ) )
	end
	function SortedKeys( tbl )
		local result = {}
		if tbl ~= nil then
			for k,_ in pairs( tbl ) do table.insert( result, k ) end
		end
		table.sort( result )
		return result
	end
	for _,fnName in ipairs( SortedKeys( FDesc ) ) do
		local fdesc = FDesc[ fnName ]
		print( BuildFunctionSignatureString( fnName, fdesc ) )
	end
	for _,enumName in ipairs( SortedKeys( EDesc ) ) do
		local edesc = EDesc[ enumName ]
		print( string.format( "\n--- Enum %s", enumName ) )
		for _,valueName in ipairs( SortedKeys( edesc ) ) do
			if edesc[valueName] ~= "" then
				print( string.format( "%s = %d -- %s", valueName, _G[valueName], edesc[valueName] ) )
			else
				print( string.format( "%s = %d", valueName, _G[valueName] ) )
			end
		end
	end
	for _,className in ipairs( SortedKeys( CDesc ) ) do
		local cdesc = CDesc[ className ]
		for _,fnName in ipairs( SortedKeys( cdesc.FDesc ) ) do
			local fdesc = cdesc.FDesc[ fnName ]
			print( BuildFunctionSignatureString( string.format( "%s:%s", className, fnName ), fdesc ) )
		end
	end
end

function ScriptFunctionHelp( scope )
	if FDesc == nil or CDesc == nil then
		print( "Script help is only available in developer mode." )
		return
	end
	function SortedKeys( tbl )
		local result = {}
		if tbl ~= nil then
			for k,_ in pairs( tbl ) do table.insert( result, k ) end
		end
		table.sort( result )
		return result
	end
	function PrintEnum( enumName, enumTable )
		print( "\n***** Enum " .. tostring( enumName ) .. " *****" )
		for _,name in ipairs( SortedKeys( enumTable ) ) do
			print ( string.format( "%s (%d) %s", tostring( name ), _G[name], tostring( enumTable[name] ) ) )
		end
	end
	function PrintBindings( tbl )
		for _,name in ipairs( SortedKeys( tbl.FDesc ) ) do
			print( tostring( tbl.FDesc[name] ) )
		end
		for _,name in ipairs( SortedKeys( tbl.EDesc ) ) do
			PrintEnum( name, tbl.EDesc[name ] )
		end
	end

	if scope and scope ~= "" then
		if scope == "dump" then
			DumpScriptBindings()
		elseif scope == "global" then
			PrintBindings( _G )
		elseif scope == "all" then
			print( "***** Global Scope *****" )
			ScriptFunctionHelp( "global" )
			for _,className in ipairs( SortedKeys( CDesc ) ) do
				print( string.format( "\n***** Class %s ******", className ) )
				ScriptFunctionHelp( className )
			end
		elseif CDesc[scope] then
			print( string.format( "**** Class %s *****", scope ) )
			PrintBindings( CDesc[ scope ] )
		elseif EDesc[scope] then
			PrintEnum( scope, EDesc[scope] )
		else
			print( "Unable to find scope: " .. scope )
		end
	else
		print( "Usage: \"script_help <scope>\" where <scope> is one of the following:\n\tall\tglobal\tdump" )
		for _,className in ipairs( SortedKeys( CDesc ) ) do
			print( "\t" .. className )
		end
		for _,enumName in ipairs( SortedKeys( EDesc ) ) do
			print( "\t" .. enumName )
		end
	end
end

function GetFunctionSignature( func, name )
	local signature = name .. "( "
	local nParams = debug.getinfo( func ).nparams
	for i = 1, nParams do
		signature = signature .. debug.getlocal( func, i )
		if i ~= nParams then
			signature = signature .. ", "
		end
	end
	signature = signature .. " )"
	return signature
end

_PublishedHelp = {}
function AddToScriptHelp( scopeTable )
	if FDesc == nil then
		return
	end

	for name, val in pairs( scopeTable ) do
		if type(val) == "function" then
			local helpstr = "scripthelp_" .. name
			if vlua.contains( scopeTable, helpstr ) and ( not vlua.contains( _PublishedHelp, helpstr ) ) then
				FDesc[name] = GetFunctionSignature( val, name ) .. "\n" .. scopeTable[helpstr]
				_PublishedHelp[helpstr] = true
			end
		end
	end
end

-- This chunk of code forces the reloading of all modules when we reload script.
if g_reloadState == nil then
	g_reloadState = {}
	for k,v in pairs( package.loaded ) do
		g_reloadState[k] = v
	end
else
	for k,v in pairs( package.loaded ) do
		if g_reloadState[k] == nil then
			package.loaded[k] = nil
		end
	end
end

-- This function lets a lua instance extend a c++ instance.
function ExtendInstance( instance, luaClass )
	-- Assume if BaseClass has already been set, we're in the script_reload case.
	if instance.BaseClass ~= nil and getmetatable( instance ).__index ~= luaClass then
		setmetatable( luaClass, { __index = instance.BaseClass } )
		setmetatable( instance, { __index = luaClass } )
		return instance
	end
	instance.BaseClass = getmetatable( instance ).__index
    setmetatable( luaClass, getmetatable( instance ) )
    setmetatable( instance, { __index = luaClass } )
    return instance
end



Msg( "...done\n" )
