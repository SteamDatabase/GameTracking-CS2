--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
-- Purpose:
--
--=============================================================================

function UniqueString(string) 
    string = string or ""
    return DoUniqueString(tostring(string))
end



function ScriptAssert(exp, msg) 
    if not msg then 
        msg = ""
    end
    
    DoScriptAssert(exp, msg)
end



function EntFire(self, target, action, value, delay, activator) 
    delay = delay or 0.0
    if not value then 
        value = ""
    end
    
    local caller = nil
    if vlua.contains(self, "thisEntity") then 
        caller = self.thisEntity
        if not activator then 
            activator = self.thisEntity
        end
    end
    
    DoEntFire(tostring(target), tostring(action), tostring(value), delay, activator, caller)
end



function EntFireByHandle(self, target, action, value, delay, activator) 
    delay = delay or 0.0
    if not value then 
        value = ""
    end
    
    local caller = self
    if not activator then 
        activator = self
    end
    
    DoEntFireByInstanceHandle(target, action, value, delay, activator, caller)
end


function __ReplaceClosures(script, scope) 
    if not scope then 
        scope = getfenv(0)
    end
    
    local tempParent = {getroottable = function () 
        return nil
    end
}
    local temp = {runscript = script}
    setmetatable(temp, tempParent)
    
    temp:runscript()
    for key, val in pairs(temp) do
        if type(val) == "function" and key ~= "runscript" then 
            print("   Replacing " .. key)
            scope[key] = val
        end
    end
end


__OutputsPattern = "^On.*Output$"


function ConnectOutputs(table) 
    local nCharsToStrip = 6
    for key, val in pairs(table) do
        if type(val) == "function" and string.match(__OutputsPattern, key) then 
            -- print(key.slice( 0, nCharsToStrip ) );
            table.thisEntity:ConnectOutput(vlua.slice(key, 1, #key - nCharsToStrip), key)
        end
    end
end



-----------------------------------------------------------
-- Text dump this scope's contents to the console.
-----------------------------------------------------------
function __DumpScope( depth, table, isPublicScriptScope )
	local indent = function( count )
		local result = ""
		for i = 1 , count , 1 do
			result = result .. "   "
		end
		return result;
	end
	DeepPrintTable( table, indent( depth ), isPublicScriptScope )
end


-----------------------------------------------------------
-- A function to re-lookup a function by name every time.
-----------------------------------------------------------
function Dynamic_Wrap( mt, name ) 
	if Convars:GetBool( 'developer' ) then          
        assert( mt ~= nil )
        --assert( mt[name] ~= nil )
		local function w(...)
			if not mt[name] then
				error( string.format( "Attempt to call %s which is undefined", name ) )
			end
			return mt[name](...)
		end
		return w
	else
		return mt[name]
	end
end



-----------------------------------------------------------
-- Collect functions of the form OnGameEvent_XXX and store them in a table.
-----------------------------------------------------------
function __RegisterGameEventListeners(scope) 
    local prefix = "OnGameEvent_"
    for key, value in pairs(scope) do
        if type(value) == "function" then 
            if type(key) == "string" and vlua.find(key, prefix, 0) == 1 then
                local eventName = vlua.slice(key, #prefix + 1)
                if #eventName > 0 then 
                    ListenToGameEvent(eventName, Dynamic_Wrap(scope, key), scope)
                end
            end
        end
    end
end



-------------------------------------------------------------------------------
-- Debug watches & trace
-------------------------------------------------------------------------------

ScriptDebugFirstLine = 6
ScriptDebugTextLines = 20
ScriptDebugTextTime = 10.0
ScriptDebugWatchFistLine = 26
NDEBUG_PERSIST_TILL_NEXT_SERVER = 0.01023
ScriptDebugDefaultWatchColor = 
{
    0,
    192,
    0
}


-------------------------------------------------------------------------------

-- Text is stored as an array of [ time, string, [ r, g, b ] ]
ScriptDebugText = {}

ScriptDebugTextIndent = 0

ScriptDebugTextFilters = {}


ScriptDebugInDebugDraw = false


ScriptDebugDrawWatchesEnabled = true

ScriptDebugDrawTextEnabled = true


-- A watch is [ { key, function, color = [ r, g, b ], lastValue, lastChangeText } ]
ScriptDebugWatches = {}


ScriptDebugTraces = {}

ScriptDebugTraceAllOn = false


-------------------------------------------------------------------------------

function ScriptDebugDraw() 
    ScriptDebugInDebugDraw = true
    
    if ScriptDebugDrawTextEnabled or ScriptDebugDrawWatchesEnabled then 
        ScriptDebugTextDraw(ScriptDebugFirstLine)
    end
    
    if ScriptDebugDrawWatchesEnabled then 
        ScriptDebugDrawWatches(ScriptDebugWatchFistLine)
    end
    
    ScriptDebugInDebugDraw = false
end


-------------------------------------------------------------------------------

function ScriptDebugDrawWatches(line) 
    local curWatchKey
    local curWatchColor
    local curWatchString
    local changed
    
    for i = 1, #ScriptDebugWatches, 1 do
        curWatchKey = ScriptDebugWatches[i].key
        curWatchColor = ScriptDebugWatches[i].color
        
        if type(curWatchKey) == "function" then 
            curWatchString = ""
        else 
            curWatchString = curWatchKey .. ": "
        end

        local success, watchResult = pcall(ScriptDebugWatches[i].func)
        if not success then
            curWatchString = curWatchString + "Watch failed - " + tostring(watchResult)
        else
            changed = false
            if watchResult ~= nil then 
                if watchResult ~= ScriptDebugWatches[i].lastValue then 
                    if ScriptDebugWatches[i].lastValue ~= nil then 
                        ScriptDebugWatches[i].lastChangeText = " (was " .. ScriptDebugWatches[i].lastValue .. " @ " .. Time() .. ")"
                        changed = true
                    end
                    ScriptDebugWatches[i].lastValue = watchResult
                end
                
                curWatchString = curWatchString + tostring(watchResult) + ScriptDebugWatches[i].lastChangeText
                if changed then 
                    ScriptDebugTextPrint(curWatchString, 
                    {
                        0,
                        255,
                        0
                    }, true)
                end
            else 
                curWatchString = curWatchString .. "<<null>>"
            end
        end
        
        DebugDrawScreenTextLine(0.5, 0.0, line, curWatchString, curWatchColor[1], curWatchColor[2], curWatchColor[3], 255, NDEBUG_PERSIST_TILL_NEXT_SERVER)
        line = line + 1
    end
    
    return line
end


-------------------------------------------------------------------------------

function ScriptDebugAddWatch(watch) 
    local watchType = type(watch)
    
    if watchType == "function" then 
        watch =
        {
            key = watch,
            func = watch,
            color = ScriptDebugDefaultWatchColor,
            lastValue = nil,
            lastChangeText = ""
        }

    elseif watchType == "string" then
        local closure closure = loadstring("return " .. watch, "")
        watch =
        {
            key = watch,
            func = closure,
            color = ScriptDebugDefaultWatchColor,
            lastValue = nil,
            lastChangeText = ""
        }

    else 
        error("Illegal type passed to ScriptDebugAddWatch: " .. watchType)
    end
    

    local function FindExisting(watch) 
        for key, val in ipairs(ScriptDebugWatches) do
            if val.key == watch.key then 
                return key
            end
        end
        return -1
    end
    
    local iExisting = FindExisting(watch)
    if iExisting == -1 then 
        table.insert(ScriptDebugWatches, watch)
    else 
        -- just update the color
        ScriptDebugWatches[iExisting].color = watch.color
    end
end


-------------------------------------------------------------------------------

function ScriptDebugAddWatches(watchArray) 
    if type(watchArray) == "table" then 
        for i = 1, #watchArray, 1 do
            ScriptDebugAddWatch(watchArray[i])
        end
    else 
        error("ScriptDebugAddWatches() expected an array!")
    end
end


-------------------------------------------------------------------------------

function ScriptDebugRemoveWatch(watch) 
    for i = #ScriptDebugWatches, 1, -1 do
        if ScriptDebugWatches[i].key == watch then 
            table.remove(ScriptDebugWatches, i)
        end
    end
end


-------------------------------------------------------------------------------

function ScriptDebugRemoveWatches(watchArray) 
    if type(watchArray) == "table" then 
        for i = 1, #watchArray, 1 do
            ScriptDebugRemoveWatch(watchArray[i])
        end
    else 
        error("ScriptDebugAddWatches() expected an array!")
    end
end


-------------------------------------------------------------------------------

function ScriptDebugAddWatchPattern(name) 
    if name == "" then 
        Msg("Cannot find an empty string")
        return
    end
    

    local function OnKey(keyPath, key, value) 
        if vlua.find(keyPath, "Documentation.") ~= 0 then 
            ScriptDebugAddWatch(keyPath)
        end
    end
    
    ScriptDebugIterateKeys(name, OnKey)
end


-------------------------------------------------------------------------------

function ScriptDebugRemoveWatchPattern(name) 
    if name == "" then 
        Msg("Cannot find an empty string")
        return
    end
    

    local function OnKey(keyPath, key, value) 
        ScriptDebugRemoveWatch(keyPath)
    end
    
    ScriptDebugIterateKeys(name, OnKey)
end


-------------------------------------------------------------------------------

function ScriptDebugClearWatches() 
    vlua.clear(ScriptDebugWatches)
end


-------------------------------------------------------------------------------

function ScriptDebugTraceAll(bValue) 
	if bValue == nil then bValue = true end
    ScriptDebugTraceAllOn = bValue
end


function ScriptDebugAddTrace(traceTarget) 
    local type = type(traceTarget)
    if type == "string" or type == "table" or type == "UNKNOWN" then 
        ScriptDebugTraces[traceTarget] = true
    end
end


function ScriptDebugRemoveTrace(traceTarget) 
    if vlua.contains(ScriptDebugTraces, traceTarget) then 
        vlua.delete(ScriptDebugTraces, traceTarget)
    end
end


function ScriptDebugClearTraces() 
    ScriptDebugTraceAllOn = false
    vlua.clear(ScriptDebugTraces)
end


function ScriptDebugTextTrace(text, color) 
    color = color or 
    {
        255,
        255,
        255
    }
    local bPrint = ScriptDebugTraceAllOn
    
    if not bPrint and #ScriptDebugTraces > 0 then
        -- TODO: this needs work to get semantics desired on Lua
        local debuginfo = debug.getinfo(2)
        if debuginfo ~= 0 then
            if vlua.contains(ScriptDebugTraces, debuginfo.name) or vlua.contains(ScriptDebugTraces, stackinfo.source) or vlua.contains(ScriptDebugTraces, debug.getlocal(2, "self")) then
                bPrint = true
            end
        end
    end
    
    if bPrint then 
        ScriptDebugTextPrint(text, color)
    end
end


-------------------------------------------------------------------------------

function ScriptDebugTextPrint(text, color, isWatch) 
    color = color or 
    {
        255,
        255,
        255
    }
    isWatch = isWatch or false
    for key, _ in pairs(ScriptDebugTextFilters) do
        if vlua.find(text, key) ~= nil then 
            return
        end
    end
    
    local timeString = string.format("(%0.2f) ", Time())
    
    if ScriptDebugDrawTextEnabled or (isWatch and ScriptDebugDrawWatchesEnabled) then 
        local indentString = ""
        for i = 1, ScriptDebugTextIndent, 1 do
            indentString = indentString .. "   "
        end
        
        -- Screen overlay
        local debugString = timeString + indentString + tostring(text)
        table.insert(ScriptDebugText, 
        {
            Time(),
            tostring(debugString),
            color
        })
        if #ScriptDebugText > ScriptDebugTextLines then 
            table.remove(ScriptDebugText, 1)
        end
    end
    
    -- Console
    print(text .. " " .. timeString)
end


-------------------------------------------------------------------------------

function ScriptDebugTextDraw(line) 
    local i
    local alpha
    local curtime = Time()
    local age
    for i = 1, #ScriptDebugText, 1 do
        age = curtime - ScriptDebugText[i][1]
        if age < -1.0 then 
            -- Started a new server
            vlua.clear(ScriptDebugText)
            break
        end
        
        if age < ScriptDebugTextTime then 
            if age >= ScriptDebugTextTime - 1.0 then 
                alpha = tonumber((255.0 * (ScriptDebugTextTime - age)))
                assert(alpha >= 0)
            else 
                alpha = 255
            end
            
            DebugDrawScreenTextLine(0.5, 0.0, line, ScriptDebugText[i][2], ScriptDebugText[i][3][1], ScriptDebugText[i][3][2], ScriptDebugText[i][3][3], alpha, NDEBUG_PERSIST_TILL_NEXT_SERVER)
            line = line + 1
        end
    end
    
    return line + ScriptDebugTextLines - i
end


-------------------------------------------------------------------------------

function ScriptDebugAddTextFilter(filter) 
    ScriptDebugTextFilters[filter] = true
end


-------------------------------------------------------------------------------

function ScriptDebugRemoveTextFilter(filter) 
    if vlua.contains(ScriptDebugTextFilters, filter) then 
        vlua.delete(ScriptDebugTextFilters, filter)
    end
end


-------------------------------------------------------------------------------

function ScriptDebugHook(type, file, line, funcname) 
    if ScriptDebugInDebugDraw then 
        return
    end
    
    if (type == 'c' or type == 'r') and file ~= "unnamed" and file ~= "" and file ~= "game_debug.nut" and funcname ~= nil then 
        local functionString = funcname .. "() [ " .. file .. "(" .. line .. ") ]"
        
        for key, _ in pairs(ScriptDebugTextFilters) do
            if vlua.find(file, key) ~= nil or vlua.find(functionString, key) ~= nil then 
                return
            end
        end
        
        if type == 'c' then 
            local indentString = ""
            for i = 1, ScriptDebugTextIndent, 1 do
                indentString = indentString .. "   "
            end
            
            -- Screen overlay
            local timeString = string.format("(%0.2f) ", Time())
            local debugString = timeString + indentString + functionString
            ScriptDebugTextPrint(functionString)
            ScriptDebugTextIndent = ScriptDebugTextIndent + 1
            
            -- Console
            print("{")
            print_indent = print_indent + 1
        else 
            ScriptDebugTextIndent = ScriptDebugTextIndent - 1
            print_indent = print_indent - 1
            print("}")
            
            if ScriptDebugTextIndent == 0 then 
                ScriptDebugExpandWatches()
            end
        end
    end
end


-------------------------------------------------------------------------------

function __VScriptServerDebugHook(type, file, line, funcname) 
    ScriptDebugHook(type, file, line, funcname) -- route to support debug script reloading during development
end


function BeginScriptDebug() 
    setdebughook(__VScriptServerDebugHook)
end


function EndScriptDebug() 
    setdebughook(nil)
end


-------------------------------------------------------------------------------
-- Script spawn filter registration system
-------------------------------------------------------------------------------
g_SpawnGroupEntityFilters = {}


function RegisterSpawnGroupEntityFilter(filtername, filterfunc) 
    if vlua.contains(g_SpawnGroupEntityFilters, filtername) then 
        print("Warning: Duplicate spawn group entity filter name encountered \"" .. filtername .. "\"!")
        return
    end
    
    g_SpawnGroupEntityFilters[filtername] = filterfunc
    
    -- Call into C and register a filter proxy
    RegisterSpawnGroupFilterProxy(filtername)
end


function RemoveSpawnGroupEntityFilter(filtername) 
    if vlua.contains(g_SpawnGroupEntityFilters, filtername) then 
        vlua.delete(g_SpawnGroupEntityFilters, filtername)
    end
    
    RemoveSpawnGroupFilterProxy(filtername)
end


function FilterSpawnGroupEntities(self, filtername, spawntables) 
    return (vlua.contains(g_SpawnGroupEntityFilters, filtername)) and g_SpawnGroupEntityFilters[filtername](spawntables) or spawntables
end


function ClearSpawnGroupEntityFilters() 
    for filtername, _ in pairs(g_SpawnGroupEntityFilters) do
        RemoveSpawnGroupFilterProxy(filtername)
    end
    vlua.clear(g_SpawnGroupEntityFilters)
end


function GetSpawnGroupEntityFilterFunc(filtername) 
    return (vlua.contains(g_SpawnGroupEntityFilters, filtername)) and g_SpawnGroupEntityFilters[filtername] or nil
end


function DumpSpawnGroupEntityFilters() 
    print("Script Filters")
    DeepPrintTable(g_SpawnGroupEntityFilters)
end


-------------------------------------------------------------------------------
local BaseEntityClass = CBaseEntity or C_BaseEntity or {}
function BaseEntityClass:SetThink( fnname, ... )
    local contextName = nil
    local initialDelay = 0
    local that = nil

    for i = 1, select( "#", ... ) do
        local arg = select( i, ... )
        if type( arg ) == "number" then
            initialDelay = tonumber( arg )
        elseif type( arg ) == "string" then
            contextName = tostring( arg )
        else
            that = arg
        end
    end

    local thinkFn = nil
    -- Allow function arguments to just pass right through.
    if type( fnname ) == "function" then
        thinkFn = fnname
    elseif that == nil then
        -- Free function. Look it up in the scope of the caller and wrap it for reloading if we're in developer mode
        local scope = getfenv( 2 )
        if scope[fnname] == nil then
            error( string.format( "Unable to find think function %s.", fnname ) )
        end
        if Convars:GetBool( 'developer' ) then
            thinkFn = function( ... ) return scope[fnname]( ... ) end
        else
            thinkFn = scope[fnname]
        end
        if contextName == nil then
            contextName = fnname
        end
    else
        -- Member function. Bind it - this takes care of reloading as well.
        if that[fnname] == nil then
            error( string.format( "Unable to find think member function %s.", fnname ) )
        end
        thinkFn = function( ... ) return that[fnname]( that, ... ) end
        if contextName == nil then
            contextName = fnname
        end
    end
    if self.SetContextThink == nil then
        error( "Please port SetContextThink client side or do not run all per-instance vscripts on the client!" )
    end
    return self:SetContextThink( contextName, thinkFn, initialDelay)
end

function BaseEntityClass:StopThink( contextName )
    self:SetContextThink( contextName, nil, 0 )
end

function BaseEntityClass:IsInstance( classOrClassName )
    local classObj = classOrClassName
    if type( classObj ) == "string" then
        classObj = _G[ classObj ]
    end
    if type( classObj ) ~= "table" then
        error( string.format( "%s is not a valid class name or reference.", classOrClassName ) )
    end

    local o = self
    while o ~= nil do
        if o == classObj then
            return true
        end
        o = (getmetatable( o ) or {}).__index
    end
    return false
end
