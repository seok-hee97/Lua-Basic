-- 3.6 – Table Constructors

-- Constructors are expressions that create and initialize tables. 
-- They are a distinctive feature of Lua and one of its most useful and versatile mechanisms.

-- The simplest constructor is the empty constructor, {}, which creates an empty table;
--  we saw it before. Constructors also initialize arrays (called also sequences or lists).
-- For instance, the statement

days = {"Sunday", "Monday", "Tuesday", "Wednesday",
            "Thursday", "Friday", "Saturday"}



-- will initialize days[1] with the string "Sunday" 
-- (the first element has always index 1, not 0), days[2] with "Monday", and so on:

print(days[4])      --> Wednesday

-- Constructors do not need to use only constant expressions.
-- We can use any kind of expression for the value of each element.
--  For instance, we can build a short sine table as

tab = {sin(1), sin(2), sin(3), sin(4),
           sin(5), sin(6), sin(7), sin(8)}

 --  To initialize a table to be used as a record, Lua offers the following syntax:

 a = {x=0, y=0}

-- which is equivalent to
a = {}; a.x =0; a.y=0


-- No mattter what constructor we use to create a table, we can always add
--  and remove other fileds od nay type to it:

w = {x=0, y=0, label="console"}             -- label??
x = {sin(0), sin(1), sin(2)}
w[1] = "another field"
x.f = w
print(w["x"])   --> 0
print(w[1])     --> another field
print(x.f[1])   --> another field
w.x = nil       -- remove field "x"

-- That is, all tables are created equal; constructors only affect their initialization.

-- Every time Lua evaluates a constructor, it creates and initializes a new table.
-- Consequently, we can use tables to implement linked lists:

list = nil
for line in io.lines() do
    list = {next=list, value=line}
end



-- This code reads lines from the standard input and stores them in a linked list,
-- in reverse order. Each node in the list is a table with two fields:
-- value, with the line contents, and next, with a reference to the next node.
-- The following code prints the list contents:

l = list
while l do
    print(l.value)
    l = l.next
end


-- (Because we implemented our list as a stack, the lines will be printed in reverse order.) 
-- Although instructive, we hardly use the above implementation in real Lua programs;
-- lists are better implemented as arrays, as we will see in Chapter 11.
-- We can mix record-style and list-style initializations in the same constructor:

polyline = {color="blue", thickness=2, npoints=4,
            {x=0,   y=0},
            {x=-10, y=0},
            {x=-10, y=1},
            {x=0,   y=1}
            }



-- The above example also illustrates how we can nest constructors to represent more complex data structures.
--  Each of the elements polyline[1], ..., polyline[4] is a table representing a record:           

print(polyline[2].x)    --> -10


-- Those two constructor forms have their limitations. For instance,
-- you cannot initialize fields with negative indices, or with string indices that are not proper identifiers.
-- For such needs, there is another, more general, format. In this format,
-- we explicitly write the index to be initialized as an expression, between square brackets:

opnames = {["+"] = "add", ["-"] = "sub",
["*"] = "mul", ["/"] = "div"}

i = 20; s = "-"
a = {[i+0] = s, [i+1] = s..s, [i+2] = s..s..s}

print(opnames[s])    --> sub
print(a[22])         --> ---




-- That syntax is more cumbersome, but more flexible too:
-- Both the list-style and the record-style forms are special cases of this more general one. The constructor

{x=0, y=0}

-- is equivalent to

{["x"]=0, ["y"]=0}




-- and the constructor

{"red", "green", "blue"}

-- is equivalent to
{[1]="red", [2]="green", [3]="blue"}





-- For those that really want their arrays starting at 0, it is not difficult to write the following:

days = {[0]="Sunday", "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday"}




-- Now, the first value, "Sunday", is at index 0. That zero does not affect the other fields,
-- but "Monday" naturally goes to index 1, because it is the first list value in the constructor;
-- the other values follow it. Despite this facility, I do not recommend the use of arrays starting at 0 in Lua.
-- Remember that most functions assume that arrays start at index 1, and therefore will not handle such arrays correctly.


-- You can always put a comma after the last entry. These trailing commas are optional, but are always valid:
a = {[1]="red", [2]="green", [3]="blue",}




-- Finally, you can always use a semicolon instead of a comma in a constructor.
--  We usually reserve semicolons to delimit different sections in a constructor,
--  for instance to separate its list part from its record part:

{x=10, y=45; "one", "two", "three"}