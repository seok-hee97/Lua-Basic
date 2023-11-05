-- 4.2 – Local Variables and Blocks
-- Besides global variables, Lua supports local variables.
--  We create local variables with the local statement:

j = 10         -- global variable
local i = 1    -- local variable



-- Unlike global variables, local variables have their scope limited to the block where they are declared.
-- A block is the body of a control structure, the body of a function, or a chunk
-- (the file or string with the code where the variable is declared).

x = 10
local i = 1        -- local to the chunk

while i<=x do
  local x = i*2    -- local to the while body
  print(x)         --> 2, 4, 6, 8, ...
  i = i + 1
end

if i > 20 then
  local x          -- local to the "then" body
  x = 20
  print(x + 2)
else
  print(x)         --> 10  (the global one)
end

print(x)           --> 10  (the global one)




-- Lua handles local variable declarations as statements. As such,
-- you can write local declarations anywhere you can write a statement
-- The scope begins after the declaration and goes until the end of the block.
-- The declaration may include an initial assignment, which works the same way as a conventional assignment:
-- Extra values are thrown away; extra variables get nil. As a specific case,
-- if a declaration has no initial assignment, it initializes all its variables with nil.

local a, b = 1, 10
if a<b then
  print(a)   --> 1
  local a    -- `= nil' is implicit
  print(a)   --> nil
end          -- ends the block started at `then'
print(a,b)   -->  1   10



-- A common idiom in Lua is

local foo = foo

-- This code creates a local variable, foo, and initializes it with the value of the global variable foo.
-- That idiom is useful when the chunk needs to preserve the original value of foo
--  even if later some other function changes the value of the global foo; it also speeds up access to foo.




-- We can delimit a block explicitly, bracketing it with the keywords do-end.
-- These do blocks can be useful when you need finer control over the scope of one or more local variables:

    do
      local a2 = 2*a
      local d = sqrt(b^2 - 4*a*c)
      x1 = (-b + d)/a2
      x2 = (-b - d)/a2
    end          -- scope of `a2' and `d' ends here
    print(x1, x2)