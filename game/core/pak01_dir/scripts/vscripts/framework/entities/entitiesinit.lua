--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
--
--=============================================================================


-------------------------------------------------------------------------------
-- Class Mixins
-------------------------------------------------------------------------------

function InstallMixins(self, classObj, mixinTable, keysToSkip, keysToMakeUnique) 
    if vlua.contains(classObj, "Mixins") and (not getbase(classObj) or not vlua.contains(getbase(classObj), "Mixins") or classObj.Mixins ~= getbase(classObj).Mixins) then 
        local Mixins = classObj.Mixins
        for _, mixin in pairs(Mixins) do
            local mixinObj = mixinTable[mixin]
            for key, value in pairs(mixinObj) do
                if vlua.find(keysToSkip, key) == nil and key ~= "InstallMixin" then 
                    if vlua.find(keysToMakeUnique, key) == nil then 
                        if vlua.contains(classObj, key) then 
                            error("Can't handle name collisions in mixins yet: " .. key)
                        end
                        classObj[key] = value
                    else 
                        classObj[mixin .. "_" .. key] = value
                    end
                end
            end
            
            if vlua.contains(mixinObj, "InstallMixin") then 
                mixinObj:InstallMixin(classObj)
            end
        end
    end
end




-------------------------------------------------------------------------------
-- Establish the base entity namespaces
-------------------------------------------------------------------------------

EntityMixins = {}
EntityClasses = {}
EntityLinkClasses = {}
EntityClassNameOverrides = {}
EntityDesignerNameToClassname = {}
EntityFramework = {}
EntityUtils = {}


-------------------------------------------------------------------------------
-- Entity think phases, must be consistent with code
-------------------------------------------------------------------------------
PRESIM = 0
PRESENSING = 1
POSTSENSING = 2


-------------------------------------------------------------------------------
-- Entity class set up
-------------------------------------------------------------------------------

vlua.tableadd(EntityFramework, 
{
    
    -----------------------------------------------------------

    InstallClassMixinKeysToIgnore = {"Specification"},

    InstallClassMixinKeysToMakeUnique = {"Spawn"},

    InstallClassVisits = {},
    
    InputValueConverters = 
    {
        number = function (self, val) return tonumber(val) end,
        integer = function (self, val) return tonumber(val) end,
        float = function (self, val) return tonumber(val) end,
        string = function (self, val) return tostring(val) end
    }
}
)

-----------------------------------------------------------

-- @TBD: maybe this should be a function specifically called "at the right time" by C code
function EntityFramework:InstallClasses() 
    -- print( "Installing entity classes..." )
    for key, value in pairs(EntityClasses) do
        if isclass(value) then
            value.Specification = value.Specification or {}
            value.Specification.scriptclassname = key
        end
    end
    
    for key, value in pairs(EntityClasses) do
        if isclass(value) then
            EntityFramework:InstallClass(key)
        end
    end
    -- print( "...done" )
    
end


-----------------------------------------------------------

function EntityFramework:InstallClass(className) 
    if vlua.contains(self.InstallClassVisits, className) then 
        return
    end
    self.InstallClassVisits[className] = true
    
    local classObj = EntityClasses[className]
    
    if getbase(classObj) then 
        local baseClassName = getbase(classObj).Specification.scriptclassname
        self:InstallClass(baseClassName)
    end
    
    -- print( "    Installing entity class " .. className );
    if not vlua.contains(classObj, "Specification") then 
        error("Entity classes are required to have a 'Specification', even if empty. Class " .. className .. " does not have one")
    end
    
    self:InstallClass_BuildCompleteSpecification(classObj)
    InstallMixins(self, classObj, EntityMixins, self.InstallClassMixinKeysToIgnore, self.InstallClassMixinKeysToMakeUnique)
    self:InstallClass_HandleEntityIO(classObj)
    self:InstallClass_Publish(className, classObj)
end


-----------------------------------------------------------

function EntityFramework:InstallClass_MergeSpecifications(primary, secondary) 
    local sections = 
    {
        "meta",
        "inputs",
        "outputs",
        "validators"
    }
    for _, section in ipairs(sections) do
        if vlua.contains(secondary, section) then 
            if vlua.contains(primary, section) then 
                primary[section] = Merge(primary[section], secondary[section])
            else 
                primary[section] = vlua.clone(secondary[section])
            end
        end
    end
end


function EntityFramework:InstallClass_BuildCompleteSpecification(classObj) 
    
    do
        local curBase = getbase(classObj)

        while curBase ~= nil do 
            if vlua.contains(curBase, "Specification") then 
                self:InstallClass_MergeSpecifications(classObj.Specification, curBase.Specification)
                break
            end
            curBase = getbase(curBase)
        end
    end
    
    if vlua.contains(classObj, "Mixins") then 
        local Mixins = classObj.Mixins
        for _, mixin in pairs(Mixins) do
            self:InstallClass_MergeSpecifications(classObj.Specification, EntityMixins[mixin].Specification)
        end
    end
end


function EntityFramework:InstallClass_HandleEntityIO(classObj) 
    -- Install input parameter converters
    local Specification = classObj.Specification
    if vlua.contains(Specification, "inputs") then 
        for _, inputMeta in pairs(Specification.inputs) do
            if vlua.contains(inputMeta, "type") then 
                inputMeta["valueConversion"] = self.InputValueConverters[inputMeta.type]
            end
        end
    end
    
    if vlua.contains(Specification, "outputs") then 
        local outputs = Specification.outputs
        local nativeOutputs = getfenv(0).CNativeOutputs()
        Specification.nativeOutputs = nativeOutputs
        
        nativeOutputs:Init(#outputs)
        for outputName, outputMeta in pairs(outputs) do
            if not vlua.contains(classObj, outputName) then  -- i.e., programmer has custom override
                if vlua.contains(outputMeta, "type") then 
                    classObj[outputName] = function( self, activator, caller, param, delay ) self:FireOutput( outputName, activator, caller, param, delay ) end
                else 
                    classObj[outputName] = function( self, activator, caller, delay ) self:FireOutput( outputName, activator, caller, nil, delay ) end
                end
                nativeOutputs:AddOutput(outputName, vlua.contains(outputMeta, "description") and outputMeta.description or "")
            end
        end
    end
end


function EntityFramework:InstallClass_Publish(className, classObj) 
    -- Build a mapping between design name and class name
    if vlua.contains(classObj.Specification, "designername") then 
        local dname = classObj.Specification.designername
        if vlua.contains(EntityDesignerNameToClassname, dname) then 
            error("Designername '" .. dname .. "' already exists for class " .. EntityDesignerNameToClassname[dname])
        end
        EntityDesignerNameToClassname[dname] = className
    end
end



------------------------------------------------------------------------------
-- Helper functions to collect entity scripts and push metadata to fgdlib
------------------------------------------------------------------------------
function EntityFramework:AddClassToGameData(lookupName, classObj, GameDataObj) 
    if vlua.contains(classObj, "Specification") then 
        GameDataObj:ParseScriptedClass(lookupName, classObj.Specification)
    end
end


function EntityFramework:LoadEntityClasses(GameDataObj) 
    -- Send entity classes to fgdlib
    for key, value in pairs(EntityClasses) do
        if isclass(value) then
            local classObj = EntityClasses[key]
            
            if vlua.contains(classObj, "Specification") then 
                if vlua.contains(classObj.Specification, "designername") then 
                    local lookupName = classObj.Specification.designername
                    EntityFramework:AddClassToGameData(lookupName, classObj, GameDataObj)
                end
            end
        end
    end
end


-------------------------------------------------------------------------------
-- Function to tie script base class to a CPP class
-------------------------------------------------------------------------------

function EntityFramework:CreateScriptProxyClass( className )
    local result = class(
    {

        constructor = function (self) end
,
        describe_R = function (self, depth, idx, val) 
            local rv = ""
            
            -- ignore class members that are functions since these do not show up in the class instance
            if "function" == type(val) then 
                return rv
            end
            
            local prefix = "\t"
            for i = 2, depth, 1 do
                prefix = prefix .. "\t"
            end
            
            if type(val) == "table" then
                rv = rv .. prefix .. idx .. " = " .. " is "
                local arraylen = #val
                -- If table is not empty but # length operator returns 0 then must be a table
                local istable = next(val) and tablelen == 0
                if not istable then
                    -- Might be an array, lets be sure by iterating and seeing if #entries returned by next
                    -- matches arraylen
                    local n = 0
                    for _, tval in pairs(val) do
                        n = n + 1
                        if n > arraylen then
                            istable = true
                            break
                        end
                    end
                end
                if istable then
                    rv = rv .. " table\n"
                    for i, val2 in pairs(val) do
                        rv = rv .. describe_R(depth + 1, i, val2)
                    end
                else
                    rv = rv .. " array, length " .. #val .. ")\n"
                    for i, val2 in ipairs(val) do
                        rv = rv .. describe_R(depth + 1, i, val2)
                    end
                end
            else 
                rv = rv .. (prefix .. idx .. " = " .. tostring(val) .. " (" .. type(val) .. ")\n")
            end
            
            return rv
        end
,
        inspect = function (self, detailLevel) 
            if detailLevel == kINSPECTION_FULL then 
                local rv = "inspecting " .. getclass(self) .. tostring(self) .. "\n"
                for idx, val in pairs(getclass(self) --[[ iterate through each entry in Foo's class table ]] ) do
                    rv = rv + self:describe_R(1, idx, val)
                end
                return rv
            end
            return ""
        end
    }, 
    {
        Specification = { scriptclassname = className }
    }, nil)
    
    -- Fallback to the function table for the C++ bindings
    getmetatable( result ).__index = _G[className]
    
    return result
end


function EntityFramework:CreateCppClassProxy(className) 
    if not vlua.contains(EntityClasses, className) then 
        EntityClasses[className] = self:CreateScriptProxyClass( className )
    end
end


function EntityFramework:CreateEntity(className, instance) 
    local result = EntityClasses[className]()
	result.__self = instance.__self
	return result
end


function EntityFramework:CreateCppLinkClassProxyInstance(className) 
    return EntityLinkClasses[className]()
end


function EntityFramework:GetClassNameOverride(className) 
    local overrideName = className
    if vlua.contains(EntityClassNameOverrides, className) then 
        overrideName = EntityClassNameOverrides[className]
    end
    return overrideName
end


function EntityFramework:GetScriptClassForDesignerName(designerName) 
    local scriptClassName = designerName
    if vlua.contains(EntityDesignerNameToClassname, designerName) then 
        scriptClassName = EntityDesignerNameToClassname[designerName]
    end
    return scriptClassName
end

function EntityFramework:GetDesignerNameForScriptClass( scriptClassName )
	if vlua.contains( EntityClasses, scriptClassName ) then
		local scriptClass = EntityClasses[scriptClassName]
        if scriptClass ~= nil then 
			if vlua.contains( scriptClass.Specification, "designername" ) then 
				return scriptClass.Specification.designername
			end
		end
	end
	return ""
end

function EntityFramework:GetInputsForScriptClass(scriptClassName) 
    if vlua.contains(EntityClasses, scriptClassName) then 
		local scriptClass = EntityClasses[scriptClassName]
        if scriptClass ~= nil then 
			if vlua.contains( scriptClass.Specification, "inputs" ) then
				local inputlist = {} 
				for inputname, inputMeta in pairs(scriptClass.Specification.inputs) do
					table.insert( inputlist, inputname )
				end
				return inputlist
			end
		end
    end
    return nil
end


function EntityFramework:GetNativeClassForScriptClass(scriptClassName) 
    if vlua.contains(EntityClasses, scriptClassName) then 
        local rootScriptClass = EntityUtils:GetRootScriptClass(EntityClasses[scriptClassName])
        if rootScriptClass ~= nil then 
            return rootScriptClass.Specification.scriptclassname
        end
    end
    return ""
end


function EntityFramework:GetNativeClassForDesignerName(name) 
    return EntityFramework:GetNativeClassForScriptClass(EntityFramework:GetScriptClassForDesignerName(name))
end


function EntityFramework:GetNativeOutputsForClass(className) 
    local entityClass = EntityClasses[className]
    if vlua.contains(entityClass.Specification, "nativeOutputs") then 
        return entityClass.Specification.nativeOutputs
    end
end


-- Root defined automatically. @TBD need to figure out how to hook up for real
EntityFramework:CreateCppClassProxy("CEntityInstance")

EntityFramework:CreateCppClassProxy("CBaseEntity")


-------------------------------------------------------------------------------
-- Entity Utilities
-------------------------------------------------------------------------------
vlua.tableadd(EntityUtils, 
{
    GetRootScriptClass = function (self, classOrObj) 
        local type = type(self, classOrObj)
        local result = nil
        if isclass( classOrObj ) then 
            result = classOrObj
        else
            result = getclass(classOrObj)
        end
        
        if result ~= nil then 
            while getbase(result) do 
                result = getbase(result)
            end
        else 
            error("Non class or object passed to GetRootScriptClass()")
        end
        
        return result
    end
,
    GetClassFieldType = function (self, classname, fieldname) 
        local entity = nil
        if vlua.contains(EntityDesignerNameToClassname, classname) then 
            entity = EntityClasses[EntityDesignerNameToClassname[classname]]
        elseif vlua.contains(EntityClasses, classname) then
            entity = EntityClasses[classname]
        end
        
        if entity then 
            if vlua.contains(entity, "Specification") and vlua.contains(entity.Specification, "meta") then 
                local meta = entity.Specification.meta
                if vlua.contains(meta, fieldname) and vlua.contains(meta[fieldname], "type") then 
                    return meta[fieldname].type
                end
            end
        end
    end
})


-------------------------------------------------------------------------------
-- Function to tie script base class to a CPP class
-------------------------------------------------------------------------------

function EntityFramework:IsKeyValueUsed(entname, keyid) 
    local ent = EntityClasses[entname]
    local result = false
    local Specification = ent.Specification
    
    if vlua.contains(Specification, "meta") then 
        local meta = Specification.meta
        for variable, metaData in pairs(meta) do
            if MakeStringToken(variable) == keyid then 
                result = true
                return result
            end
        end
    end
    return result
end


-- We can unserialize everything but ehandles during precache.
-- We will unserialize ehandles during Spawn
function EntityFramework:UnserializeForPrecache(ent, context) 
    local Specification = ent.Specification

    -- Fill in values from the Specification
    if vlua.contains(Specification, "meta") then
        local meta = Specification.meta
        for variable, metaData in pairs(meta) do
            local keyValue = context:GetValue(variable)
            if keyValue ~= nil then
                if vlua.contains(metaData, "type") then
                    if metaData.type == "integer" or metaData.type == "choices" then
                        ent[variable] = tonumber(keyValue)
                    elseif metaData.type == "float" or metaData.type == "double" then
                        ent[variable] = tonumber(keyValue)
                    elseif metaData.type == "boolean" then
                        ent[variable] = keyValue
                    elseif metaData.type == "ehandle"or metaData.type == "target_destination" then
                        -- skip ehandles since they cannot be resolved in precache
                    elseif metaData.type == "vector" or metaData.type == "vector2" or metaData.type == "vector4" or metaData.type == "qangle" or metaData.type == "quaternion" then
                        ent[variable] = keyValue
                    elseif metaData.type ~= "manualUnserialization" then
                        ent[variable] = tostring(keyValue)
                    end
                else
                    ent[variable] = keyValue
                end
            end
        end
    end
end

function EntityFramework:UnserializeForSpawn(ent, entityKeyValues) 
    local Specification = ent.Specification

    -- Fill in ehandle-based values from the Specification, since we can do them during spawn
    if vlua.contains(Specification, "meta") then
        local meta = Specification.meta
        for variable, metaData in pairs(meta) do
            if vlua.contains(metaData, "type") then
                if metaData.type == "ehandle" then
                    local keyValue = entityKeyValues:GetValue(variable)
                    if keyValue ~= nil then
                        if type(keyValue) == "string" then
                            if vlua.contains(metaData, "list") and metaData.list == true then
                                ent[variable] = Entities:FindAllByName(tostring(keyValue))
                            else
                                ent[variable] = Entities:FindByName(nil, tostring(keyValue))
                            end
                        else
                            ent[variable] = keyValue
                        end
                    end
                elseif metaData.type == "target_destination" then
                    local keyValue = entityKeyValues:GetValue(variable)
                    if keyValue ~= nil then
                        if vlua.contains(metaData, "list") and metaData.list == true then
                            ent[variable] = Entities:FindAllByName(tostring(keyValue))
                        else
                            ent[variable] = tostring(keyValue)
                        end
                    end
                end
            end
        end
    end
end

function EntityFramework:DispatchPrecache(ent, context)
    -- First read in key values and fill in our instance table
    self:UnserializeForPrecache( ent, context )

    -- Next call a precache method if it has one
    if vlua.contains( ent, "Precache" ) then
        ent:Precache( context )
    end
end


function EntityFramework:DispatchSpawn( ent, entityKeyValues ) 
    self:UnserializeForSpawn( ent, entityKeyValues )

    if vlua.contains( ent, "Spawn" ) then 
        ent:Spawn( entityKeyValues )
    end
end


function EntityFramework:DispatchActivate(ent) 
    local result = true
    if vlua.contains(ent, "Activate") then 
        result = ent:Activate()
        if result == nil then result = true end
    end
    return result
end


function EntityFramework:DispatchUpdateOnRemove(ent) 
    if vlua.contains(ent, "UpdateOnRemove") then 
        ent:UpdateOnRemove()
    end
end


function EntityFramework:DispatchInput(inputName, target, args)
	if vlua.contains(target, inputName) then
		target[inputName]( args )
		return true
	end
	return false
end


function EntityFramework:GetEntityHandle(ent) 
    return ent:GetEntityHandle()
end


function EntityFramework:PrecacheResource(resourceName) 
    NativeFunctions:ScriptPrecacheResource(resourceName)
end


-------------------------------------------------------------------------------
-- Hack for including known entities in the right order. Later (a) want this
-- handled in game dir and (b) have IncludeScript not include more than once.
-------------------------------------------------------------------------------

require "game.entities.entmixin_enabledisable"
