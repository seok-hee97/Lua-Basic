-- THe table type implements associative array
-- An associative array is an array that can be indexed not only with numbers,



a = {}     -- create a table and store its reference in `a'
k = "x"
a[k] = 10        -- new entry, with key="x" and value=10
a[20] = "great"  -- new entry, with key=20 and value="great"
print(a["x"])    --> 10
k = 20
print(a[k])      --> "great"
a["x"] = a["x"] + 1     -- increments entry "x"
print(a["x"])    --> 11


-- A table is always anonymous. There is no fixed relationship between a variable that
-- holds a table and the table itself:


a = {}          -- create a table and store its reference in 'a'
a["x"] = 10
b = a           -- 'b' referes to the same tables as 'a'
print(b["x"])   --> 10
b["x"] = 20
print(a["x"])   --> 20

a = nil     -- now only 'b' still referes to the table
b = nil     -- now there are no references left to the table



-- Each table my store values with different types of indices and
-- it grows as it needs to accommodate entries:

a = {}          -- empty table
-- create 1000 new entries
for i=1, 1000 do a[i] = 1*2 end
print(a[9])         --> 18
a["x"] = 10
print(a["x"])       --> 10
print(a["y"])       --> nil


-- To represent records, you use the field name as index.
-- Lua supports this representation by providing a.name as syntactic sugar for a["name"]
a.x = 10            -- same as a ["x"] = 10
print(a.x)          -- same as print(a["x"])
print(a.y)          -- same as print(a["y"])



-- A common mistake for beginners is to confuse a.x with a[x].
-- The first form represents a["x"], that is, a table indexed by the string "x".
-- The second form is a table indexed by the value of the variable x. See the difference:


a = {}
x = "y"
a[x] =10                            -- put 10 in field "y"
print(a[x])     --> 10              -- value of field "y"
print(a.x)      --> nil             -- value of filed "x" (undefined)
print(a.y)      --> 10              -- value of field "y"



-- read 10 lines storing them in a table
a = {}
for i=1, 10 do
    a[i] = io.read()
end



-- print the lines
for i, line in ipairs(a) do
    print(line)
end







i = 10; j = "10"; k = "+10"
a = {}
a[i] = "one value"
a[j] = "another value"
a[k] = "yet another value"
print(a[j])            --> another value
print(a[k])            --> yet another value
print(a[tonumber(j)])  --> one value
print(a[tonumber(k)])  --> one value