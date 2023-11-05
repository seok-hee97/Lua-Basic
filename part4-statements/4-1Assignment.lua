-- 4.1 – Assignment
-- Assignment is the basic means of changing the value of a variable or a table field:

a = "hello" .. "world"
t.n = t.n + 1


-- Lua allows multiple assignment, where a list of values is assigned to a list of variables in one step.
--  Both lists have their elements separated by commas. For instance, in the assignment

a, b = 10, 2*x
-- the variable a gets the value 10 and b gets 2*x.



-- In a multiple assignment,
-- Lua first evaluates all values and only then executes the assignments.
-- Therefore, we can use a multiple assignment to swap two values, as in

x, y = y, x                -- swap `x' for `y'
a[i], a[j] = a[j], a[i]    -- swap `a[i]' for `a[j]'




-- Lua always adjusts the number of values to the number of variables:
-- When the list of values is shorter than the list of variables,
-- the extra variables receive nil as their values; when the list of values is longer,
--  the extra values are silently discarded:


a, b, c = 0, 1
print(a,b,c)           --> 0   1   nil
a, b = a+1, b+1, b+2   -- value of b+2 is ignored
print(a,b)             --> 1   2
a, b, c = 0
print(a,b,c)           --> 0   nil   nil





a, b, c = 0, 0, 0
print(a,b,c)           --> 0   0   0





a, b = f()
-- f() returns two results: a gets the first and b gets the second.