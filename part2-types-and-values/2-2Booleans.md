# 2.2 - Booleans

The boolean type has two values, `false` and `true`, which represent
the traditional boolean values. However, booleans are not the only way
to condition a value. In Lua, any value may represent a condition.
Conditional tests (e.g., conditions in control structures) consider
both the boolean `false` and `nil` as false and anything else as true.
In particular, Lua considers both zero and the empty string as true in
conditional tests.

```lua
if 0   then print("zero is true")   end  -- prints
if ""  then print("empty is true")  end  -- prints
```
