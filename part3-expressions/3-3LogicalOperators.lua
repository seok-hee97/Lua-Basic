-- The logical operators are and, or, and not. 
-- Like control structures, all logical operators consider false and nil as false and anything else as true.
-- The operator and returns its first argument if it is false; otherwise, it returns its second argument.
-- The operator or returns its first argument if it is not false; otherwise, it returns its second argument:


print(4 and 5)         --> 5
print(nil and 13)      --> nil
print(false and 13)    --> false
print(4 or 5)          --> 4
print(false or 5)      --> 5




-- Both and or use short-cut evaluation, that is,


-- A useful Lua idiom is x=x or v, which is equivalent to

if not x then = v end

-- Another useful idiom is (a and b) or
--  c (or simply a and b or c, because and has a higher precedence than or),
--   which is equivalent to the C expression

a ? b : c


-- provided that b is not false.
--  For instance, we can select the maximum of two numbers x and y
--   with a statement like
max = (x > y) and x or y



-- When x > y, the first expression of the and is true, 
-- so the and results in its second expression (x) (which is also true, because it is a number), 
-- and then the or expression results in the value of its first expression, x. When x > y is false,
-- the and expression is false and so the or results in its second expression, y.
-- The operator not always returns true or false:



print(not nil)      --> true
print(not false)    --> true
print(not 0)        --> false
print(not not nil)  --> false