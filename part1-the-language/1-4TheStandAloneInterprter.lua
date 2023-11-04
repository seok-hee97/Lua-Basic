

-- When the interpreter loads a file, it ignores its first line if that line starts with a number sign (`#´). That feature allows the use of Lua as a script interpreter in Unix systems. If you start your program with something like

--     #!/usr/local/bin/lua
-- (assuming that the stand-alone interpreter is located at /usr/local/bin), or
--     #!/usr/bin/env lua
-- then you can call the program directly, without explicitly calling the Lua interpreter.
-- The usage of lua is

--     lua [options] [script [args]]
