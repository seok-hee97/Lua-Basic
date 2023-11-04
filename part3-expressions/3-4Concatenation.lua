-- 3.4 - Concatenation

-- Lua denotes the string concatenation operator by ".." (two dots).
-- If any of its operands is a number, Lua converts that number to a string.


print("Hello " .. "World")  --> Hello World
print(0 .. 1)               --> 01


-- Remember that strings in Lua are immutable values.
-- The concatenation operator always creates a new string,
-- without any modification to its operands:


a = "Hello"
print(a .. " World")   --> Hello World
print(a)               --> Hello