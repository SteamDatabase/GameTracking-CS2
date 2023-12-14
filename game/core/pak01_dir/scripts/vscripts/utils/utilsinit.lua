--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
--
--=============================================================================

function Deg2Rad(deg) 
    return deg * (math.pi / 180.0)
end


function Rad2Deg(rad) 
    return rad * (180.0 / math.pi)
end


function Clamp(val, min, max) 
    if val > max then 
        val = max
    elseif val < min then
        val = min
    end
    
    return val
end


function Lerp(t, a, b) 
    return a + t * (b - a)
end


function VectorDistanceSq(v1, v2) 
    return (v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y) + (v1.z - v2.z) * (v1.z - v2.z)
end


function VectorDistance(v1, v2) 
    return math.sqrt(VectorDistanceSq(v1, v2))
end


function VectorLerp(t, a, b) 
    return Vector(Lerp(t, a.x, b.x), Lerp(t, a.y, b.y), Lerp(t, a.z, b.z))
end


function VectorIsZero(v) 
    return (v.x == 0.0) and (v.y == 0.0) and (v.z == 0.0)
end


-- Remap a value in the range [a,b] to [c,d].
function RemapVal(v, a, b, c, d) 
    if a == b then 
        return (v >= b) and d or c
    end
    
    return c + (d - c) * (v - a) / (b - a)
end


-- Remap a value in the range [a,b] to [c,d].
function RemapValClamped(v, a, b, c, d) 
    if a == b then 
        return (v >= b) and d or c
    end
    
    local t = (v - a) / (b - a)
    t = Clamp(t, 0.0, 1.0)
    return c + (d - c) * t
end


function min(x, y) 
    if x < y then 
        return x
    end
    return y
end


function max(x, y) 
    if x > y then 
        return x
    end
    return y
end


function abs(val) 
    return val > 0 and val or -val
end


function Merge(table1, table2) 
    local result = vlua.clone(table2)
    for key, val in pairs(table1) do
        result[key] = val
    end
    return result
end


-- Rough system for passing 1-4 control points to a 1-shot effect from script.
-- See StartParticleEffectControlPoints to see how this is parsed out. Can definately use a rework.
ParticleEffectControlPoints = class(
{
    cp0_pos = nil,
    cp0_norm = nil,
    cp1_pos = nil,
    cp1_norm = nil,
    cp2_pos = nil,
    cp2_norm = nil,
    cp3_pos = nil,
    cp3_norm = nil
}, {}, nil)


require "utils.deepprint"
