-- A comment starts anywhere with a double hyphen (--)
-- and runs to the end of the line. Lua also offers long comments,
-- which start with --[[ and run until the matching ]].

--[[
print(10)         -- no action (comment)
--]]


-- A common trick: adding an extra dash at the start re-enables the block.
---[[
print(10)         --> 10
--]]
