--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
--
--=============================================================================

EntityMixins.EnableDisable = 
{
    Specification = 
    {
        description = "Standard implementation for entities that can be enabled & disabled (logically)",
        documentation = "http://",
        
        meta = 
        {
            enabled = 
            {
                tags = "publish",
                type = "boolean",
                name = "Is enabled",
                def = true
            }
        },
        
        inputs = 
        {
            Enable = 
            {
                tags = "publish",
                description = "Enable the entity"
            },
            Disable = 
            {
                tags = "publish",
                description = "Disable the entity"
            }
        }
    },
    
    enabled = true
}


function EntityMixins.EnableDisable:InstallMixin(target) 
    local nullFunc = function (self) 
        
    end
    if not vlua.contains(target, "OnEnable") then 
        target.OnEnable = nullFunc
    end
    if not vlua.contains(target, "OnDisable") then 
        target.OnDisable = nullFunc
    end
end


function EntityMixins.EnableDisable:Spawn(spawnKeys) 
    
end


function EntityMixins.EnableDisable:Enable(args) 
    if not self.enabled then 
        --                      print( "enabling! " .. this )
        self.enabled = true
        self:OnEnable()
    end
end


function EntityMixins.EnableDisable:Disable(args) 
    if self.enabled then 
        --                      print( "disabling! " .. this )
        self.enabled = false
        self:OnDisable()
    end
end
