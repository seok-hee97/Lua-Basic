-- String have the usual meaning : a sequence of characters

a = "one string"
b = string.gsub(a, "one", "another")  -- change string parts
print(a)       --> one string
print(b)       --> another string



-- excap  sequence

-- \a	bell
-- \b	back space
-- \f	form feed
-- \n	newline
-- \r	carriage return
-- \t	horizontal tab
-- \v	vertical tab
-- \\	backslash
-- \"	double quote
-- \'	single quote
-- \[	left square bracket
-- \]	right square bracket

-- page = [[
--     <HTML>
--     <HEAD>
--     <TITLE>An HTML Page</TITLE>
--     </HEAD>
--     <BODY>
--      <A HREF="http://www.lua.org">Lua</A>
--      [[a text between double brackets]]
--     </BODY>
--     </HTML>
--     ]]
    
--     write(page)




print("10" + 1)           --> 11
print("10 + 1")           --> 10 + 1
print("-5.3e-10"*"2")     --> -1.06e-09
print("hello" + 1)        -- ERROR (cannot convert "hello")




line = io.read()     -- read a line
n = tonumber(line)   -- try to convert it to a number
if n == nil then
    error(line .. " is not a valid number")
else
    print(n*2)
end


print(tostring(10) == "10")   --> true
print(10 .. "" == "10")       --> true