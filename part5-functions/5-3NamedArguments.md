# 5.3 – Named Arguments
The parameter passing mechanism in Lua is positional: When we call a function, arguments match parameters by their positions. The first argument gives the value to the first parameter, and so on. Sometimes, however, it is useful to specify the arguments by name. To illustrate this point, let us consider the function rename (from the os library), which renames a file. Quite often, we forget which name comes first, the new or the old; therefore, we may want to redefine this function to receive its two arguments by name:
```
    -- invalid code
    rename(old="temp.lua", new="temp1.lua")
```
Lua has no direct support for that syntax, but we can have the same final effect, with a small syntax change. The idea here is to pack all arguments into a table and use that table as the only argument to the function. The special syntax that Lua provides for function calls, with just one table constructor as argument, helps the trick:
```
    rename{old="temp.lua", new="temp1.lua"}
```
Accordingly, we define rename with only one parameter and get the actual arguments from this parameter:
```
    function rename (arg)
      return os.rename(arg.old, arg.new)
    end
```
This style of parameter passing is especially helpful when the function has many parameters, and most of them are optional. For instance, a function that creates a new window in a GUI library may have dozens of arguments, most of them optional, which are best specified by names:
```
    w = Window{ x=0, y=0, width=300, height=200,
                title = "Lua", background="blue",
                border = true
              }
```
The Window function then has the freedom to check for mandatory arguments, add default values, and the like. Assuming a primitive _Window function that actually creates the new window (and that needs all arguments), we could define Window as follows:
```
    function Window (options)
      -- check mandatory options
      if type(options.title) ~= "string" then
        error("no title")
      elseif type(options.width) ~= "number" then
        error("no width")
      elseif type(options.height) ~= "number" then
        error("no height")
      end
    
      -- everything else is optional
      _Window(options.title,
              options.x or 0,    -- default value
              options.y or 0,    -- default value
              options.width, options.height,
              options.background or "white",   -- default
              options.border      -- default is false (nil)
             )
    end
```