-- class.lua
-- Compatible with Lua 5.1 (not 5.0).
--
--[[
    Usage:

    -- Define a class A
    A = class(
            -- First parameter to class function is a table with properties and
            -- constructor method.  Error if not specified or not a table
            --
            {
                -- Define our properties.  These are the values each new instance will start out with.
                --
                a = 0;
                b = 0;
                c = 0;

                -- Implement a constructor that will get called once for each instance and create/set
                -- property values.   You are responsible for ensuring the first parameter is the self
                -- parameter as it will be invoked with the instanceObj when a new instance is created.
                -- Defining functions here is kind of ugly as you have to use table name = value syntax
                -- See __tostring example below for a better looking way to do it.
                --
                constructor = function (self, a, b, c)
                    -- For each parameter specified, overwrite default value, otherwise keep default value
                    --
                    self.a = a or self.a
                    self.b = b or self.b
                    self.c = c or self.c
                end

                -- Define any further class methods here.  Again, you are responsible
                -- for making sure the first parameter is the self parameter and calling
                -- the method with the : syntax (e.g. instanceObj:method) so that Lua will
                -- pass instanceObj as the first parameter to the method.
            },

            -- Second parameter is an optional (non-nil) table that defines
            -- static member variables.  Error if specified and not a table.
            --
            {
                __class__name = "A"
            },

            -- Third parameter is an optional (non-nil) table that defines
            -- the base class.  If present, this class will inherit, via copy,
            -- the base classes properties and methods.  Error if specified
            -- and not a table created by the the class function
            --
            nil
        )

    -- Add a new property d to the class definition before we create any instances
    --
    A.d = 0

    -- Implement a tostring method to return string representation of instance
    -- Using classname: syntax allows a more natural definition and  eliminates the
    -- need to explicitly specify the self parameter
    --
    function A:__tostring()
        return "A: " .. self.a .. "  B: " .. self.b .. "  C: " .. self.c .. "  D: " .. self.d
    end

    -- Implement a method to do a random calculation on the instance property values.
    --
    function A:Step(amount)
        self.a = self.b + (self.c * amount);
    end

    -- Create an instance of class A
    test = A(1,2,3);

    -- Display its value
    print("test.tostring: " .. test.tostring();

    -- Call Step method to do a random calculation
    test.Step(10);

    -- Display its value to see what changed.
    print("test.tostring: " .. test.tostring();
]]--

function class(def, statics, base)
    -- Error if def argument missing or is not a table
    if not def or type(def) ~= 'table' then error("class definition missing or not a table") end

    -- Error if statics argument is not nil and not a table
    if statics and type(statics) ~= 'table' then error("statics parameter specified but not a table") end

    -- Error if base argument not nil and not a table created by this function.
    if base and (type(base) ~= 'table' or not isclass(base)) then error("base parameter specified but not a table created by class function") end

    -- Start with a table for this class.  This will be the metatable for
    -- all instances of this class and where all class methods and static properties
    -- will be kept.  Initially it has two slots, __class__ == true to indicate this
    -- table represents a class created by this function and __base__, which if not
    -- nil is a reference to a base class created by this function
    --
    local c = {__base__ = base}
    c.__class__ = c

    -- Local function that will be used to create an instance of the class
    -- when the class is called
    --
    local function create(class_tbl, ...)
        -- Create an instance initialized with per instance properties
        --
        local instanceObj = {}

        -- Shallow copy of any class instance property initializers into our copy
        --
        for i,v in pairs(c.__initprops__) do
            instanceObj[i] = v
        end

        -- __index for each instance is the class object
        --
        setmetatable(instanceObj, { __index = c })

        -- If constructor key is not nil then it is this class's constructor
        -- so call it with our arguments
        --
        if instanceObj.constructor then
            instanceObj:constructor(...)
        end

        -- Return new instance of the class
        --
        return instanceObj
    end


    -- Create a metatable for the class whose __index field is just the class
    -- This will be the metatable for each new instance of this class created.
    --
    local c_mt = { __call = create}
    if base then
        -- Redirect class metatable __index slot to base class if specified
        --
        c_mt.__index = base
    end

    -- If statics is specified, shallow copy of non-function slots to our class
    --
    if statics then
        for i,v in pairs(statics) do
            if type(v) ~= 'function' then
                -- Ignore functions in statics table as we only support
                -- static properties.
                --
                c[i] = v
            else
                -- Error if this happens?
                error("function definitions not supported in statics table")
            end
        end
    end

    -- Table for instance property initial values
    --
    c.__initprops__ = {}

    -- Copy base class slots first if any so they will get overlayed
    -- by class slots of the same key
    --
    if base then
        -- Copy instance property initializers from base class
        --
        for i,v in pairs(base.__initprops__) do
            c.__initprops__[i] = v
        end
    end

    -- Now copy slots from the definition passed in.  For functions,
    -- store shallow copy to our class table.  For anything not a
    -- function slot, shallow copy to c.__initprops__ table for use
    -- when a new object of this class is instantiated.
    --
    for i,v in pairs(def) do
        if type(v) ~= 'function' then
            c.__initprops__[i] = v
        else
            c[i] = v
        end
    end

    -- Define an__instanceof__ method to determine if an instance.
    -- was derived from the passed class.  Used to emulate Squirrel
    -- instanceof binary operator
    --
    c.__instanceof__ =  function(instanceObj, classObj)
                            local c = getclass(instanceObj)
                            while c do
                                if c == classObj then return true end
                                c = c.__base__
                            end
                            return false
                        end

    -- Define an __getclass__ method to emulate Squirrel 3 object.getclass()
    --
    c.__getclass__ =function(instanceObj)
                        -- class object is __class__ slot of instance object's metatable
                        --
                        local classObj = getmetatable(instanceObj).__index

                        -- Sanity check the metatable is really a class object
                        -- we created.  If so return it otherwise nil
                        --
                        if isclass(classObj) then
                            return classObj
                        else
                            return nil
                        end
                    end

    -- Define a __getbase__ method to emulate Squirrel 3 object.getbase()
    -- method.
    --
    c.__getbase__ = function(classObj)
                        -- Sanity check the metatable is really a class object
                        -- we created.  If so return it's __base__ property
                        -- otherwise nil
                        --
                        if isclass(classObj) then
                            -- base class, if any,  is stored in class __base__ slot
                            --
                            return classObj.__base__
                        else
                            return nil
                        end
                    end

    setmetatable(c, c_mt)
    return c
end

-- Implement Squirrel instanceof binary operator
--
function instanceof(instanceObj, classObj)
    c = rawget(getmetatable(instanceObj) or {}, "__index")
    h = rawget(c or {}, "__instanceof__")
    return h and h(instanceObj, classObj) or nil
end


-- Implement Squirrel getclass function
--
function getclass(instanceObj)
    c = rawget(getmetatable(instanceObj) or {}, "__index")
    h = rawget(c or {}, "__getclass__")
    return h and h(instanceObj) or nil
end


-- Implement Squirrel getbase function
--
function getbase(instanceObj)
    c = isclass(instanceObj) and instanceObj or rawget(getmetatable(instanceObj) or {}, "__index")
    h = rawget(c or {}, "__getbase__")
    return h and h(c) or nil
end


-- Implement isclass function
--
function isclass(classObj)
    return classObj and classObj.__class__ == classObj
end
