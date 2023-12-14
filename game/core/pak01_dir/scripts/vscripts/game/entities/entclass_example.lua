--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
--
--=============================================================================

-- @TODO: Automate this
EntityFramework:CreateCppClassProxy("CInfoItemPosition")


EntityClasses.CExampleEntity = class(
{
    
    -- Data
    value = 0,
    min = 0,
    max = 0
}, 
{
    Specification = 
    {
        bases = {"root"},
        description = "Example entity for addition and subtraction of integers with associated triggers",
        tags = 
        {
            "math",
            "logic",
            "trigger"
        },
        documentation = "https://intranet.valvesoftware.com/wiki/logicents/sample_entity",
        designername = "sample_entity",
        helpers = "sphere(min) sphere(max) iconsprite(materials/editor/env_tonemap_controller.vmat) line(255 255 255, targetname, position1, targetname, position2)",
        
        meta = 
        {
            startvalue = 
            {
                tags = "publish",
                type = "integer",
                name = "Initial value",
                description = "Starting value for the counter."
            },
            min = 
            {
                tags = "publish",
                type = "integer",
                name = "Minimum Legal Value",
                description = "Minimum legal value for the counter. If min=0 and max=0, no clamping is performed."
            },
            max = 
            {
                tags = "publish",
                type = "integer",
                name = "Maximum Legal Value",
                description = "Maximum legal value for the counter. If min=0 and max=0, no clamping is performed."
            },
            value = 
            {
                tags = "debug",
                type = "integer",
                description = "Current value for the counter."
            },
            choicesTest = 
            {
                tags = "publish",
                type = "choices",
                name = "Choices Test",
                description = "Choices Test",
                choices = 
                {
                    [1] = "Hello There",
                    [2] = "Welcome",
                    [5] = "Good Morning"
                },
                def = "5"
            },
            position1 = 
            {
                tags = {"publish"},
                type = "ehandle",
                name = "Position 1",
                description = "entity used to mark a position"
            },
            position2 = 
            {
                tags = {"publish"},
                type = "ehandle",
                name = "Position 2",
                description = "entity used to mark a position"
            },
            tagTest = 
            {
                tags = "publish",
                type = "tag_list",
                name = "Tag Test",
                description = "Tag Test",
                tag_list = 
                {
                    {
                        "GAMESTRING1",
                        "Designer game string 1",
                        0
                    },
                    
                    {
                        "GAMESTRING2",
                        "Designer game string 2",
                        0
                    }
                }
            }
        },
        
        inputs = 
        {
            Add = 
            {
                tags = "publish",
                type = "integer",
                description = "Add an amount to the counter and fire the OutValue output with the result."
            },
            Subtract = 
            {
                tags = "publish",
                type = "integer",
                description = "Subtract an amount to the counter and fire the OutValue output with the result."
            },
            GetValue = 
            {
                tags = "publish",
                returnType = "integer"
            }
        },
        
        outputs = 
        {
            OutValue = 
            {
                tags = "publish",
                type = "integer",
                description = "Fired when the counter value changes."
            },
            OnHitMin = 
            {
                tags = "publish",
                description = "Fired when the counter value meets or goes below the min value. The counter must go back above the min value before the output will fire again."
            },
            OnHitMax = 
            {
                tags = "publish",
                description = "Fired when the counter value meets or goes above the min value. The counter must go back below the max value before the output will fire again."
            }
        },
        
        validators = 
        {
            tools = {
            {
                function () 
                    return (min <= startvalue and startvalue <= max)
                end
,
                "Initial value value must be between min and max"
            }},
            
            always = {
            {
                function () 
                    return (min <= max)
                end
,
                "Minimum value must be equal to or less than maximum value"
            }},
            
            runtime = {
            {
                function () 
                    return (min <= value and value <= max)
                end
,
                "Value value must be between min and max"
            }}
        }
    },
    
    Mixins = {"EnableDisable"}
}, EntityClasses.CInfoItemPosition)


-- Functions
function EntityClasses.CExampleEntity:Spawn(spawnKeys) 
    getbase(self):Spawn(spawnKeys)
    EnableDisable_Spawn(spawnKeys)
    self.value = spawnKeys:GetValue(startvalue)
end


function EntityClasses.CExampleEntity:Add(toAdd) 
    self:Update(self.value, self.value + toAdd)
end


function EntityClasses.CExampleEntity:Subtract(toSubtract) 
    self:Update(self.value, self.value - toSubtract)
end


function EntityClasses.CExampleEntity:Update(oldValue, newValue) 
    print("Inside Update with oldValue " .. oldValue .. " (" .. type(oldValue) .. ") and newValue " .. newValue .. " (" .. type(newValue) .. ")")
    if enabled then 
        if self.min ~= 0 or self.max ~= 0 then 
            -- trigger
            self.value = Clamp(newValue, self.min, self.max)
            
            if self.value == self.min and oldValue > self.min then 
                OnHitMin(self, self, 0)
            elseif self.value == self.max and oldValue < self.max then
                OnHitMax(self, self, 0)
            end
        end
        
        OutValue(self, self, self.value, 0)
    end
end


function EntityClasses.CExampleEntity:GetValue() 
    return self.value
end
