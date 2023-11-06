# 5.1 – Multiple Results
An unconventional, but quite convenient feature of Lua is that functions may return multiple results. Several predefined functions in Lua return multiple values. An example is the string.find function, which locates a pattern in a string. It returns two indices: the index of the character where the pattern match starts and the one where it ends (or nil if it cannot find the pattern). A multiple assignment allows the program to get both results:
```
    s, e = string.find("hello Lua users", "Lua")
    
    print(s, e)   -->  7      9
```
Functions written in Lua also can return multiple results, by listing them all after the return keyword. For instance, a function to find the maximum element in an array can return both the maximum value and its location:
```
    function maximum (a)
      local mi = 1          -- maximum index
      local m = a[mi]       -- maximum value
      for i,val in ipairs(a) do
        if val > m then
          mi = i
          m = val
        end
      end
      return m, mi
    end
    
    print(maximum({8,10,23,12,5}))     --> 23   3
```
Lua always adjusts the number of results from a function to the circumstances of the call. When we call a function as a statement, Lua discards all of its results. When we use a call as an expression, Lua keeps only the first result. We get all results only when the call is the last (or the only) expression in a list of expressions. These lists appear in four constructions in Lua: multiple assignment, arguments to function calls, table constructors, and return statements. To illustrate all these uses, we will assume the following definitions for the next examples:
```
    function foo0 () end                  -- returns no results
    function foo1 () return 'a' end       -- returns 1 result
    function foo2 () return 'a','b' end   -- returns 2 results
```
In a multiple assignment, a function call as the last (or only) expression produces as many results as needed to match the variables:
```
    x,y = foo2()        -- x='a', y='b'
    x = foo2()          -- x='a', 'b' is discarded
    x,y,z = 10,foo2()   -- x=10, y='a', z='b'
```
If a function has no results, or not as many results as we need, Lua produces nils:
```
    x,y = foo0()      -- x=nil, y=nil
    x,y = foo1()      -- x='a', y=nil
    x,y,z = foo2()    -- x='a', y='b', z=nil
```
A function call that is not the last element in the list always produces one result:
```
    x,y = foo2(), 20      -- x='a', y=20
    x,y = foo0(), 20, 30  -- x=nil, y=20, 30 is discarded
```
When a function call is the last (or the only) argument to another call, all results from the first call go as arguments. We have seen examples of this construction already, with print:
```
    print(foo0())          -->
    print(foo1())          -->  a
    print(foo2())          -->  a   b
    print(foo2(), 1)       -->  a   1
    print(foo2() .. "x")   -->  ax         (see below)
```
When the call to foo2 appears inside an expression, Lua adjusts the number of results to one; so, in the last line, only the "a" is used in the concatenation.
The print function may receive a variable number of arguments. (In the next section we will see how to write functions with variable number of arguments.) If we write f(g()) and f has a fixed number of arguments, Lua adjusts the number of results of g to the number of parameters of f, as we saw previously.

A constructor also collects all results from a call, without any adjustments:
```
    a = {foo0()}         -- a = {}  (an empty table)
    a = {foo1()}         -- a = {'a'}
    a = {foo2()}         -- a = {'a', 'b'}
```
As always, this behavior happens only when the call is the last in the list; otherwise, any call produces exactly one result:
    a = {foo0(), foo2(), 4}   -- a[1] = nil, a[2] = 'a', a[3] = 4
Finally, a statement like return f() returns all values returned by f:
```
    function foo (i)
      if i == 0 then return foo0()
      elseif i == 1 then return foo1()
      elseif i == 2 then return foo2()
      end
    end
    
    print(foo(1))     --> a
    print(foo(2))     --> a  b
    print(foo(0))     -- (no results)
    print(foo(3))     -- (no results)
```
You can force a call to return exactly one result by enclosing it in an extra pair of parentheses:
```
    print((foo0()))        --> nil
    print((foo1()))        --> a
    print((foo2()))        --> a
```
Beware that a return statement does not need parentheses around the returned value, so any pair of parentheses placed there counts as an extra pair. That is, a statement like return (f()) always returns one single value, no matter how many values f returns. Maybe this is what you want, maybe not.
A special function with multiple returns is unpack. It receives an array and returns as results all elements from the array, starting from index 1:
```
    print(unpack{10,20,30})    --> 10   20   30
    a,b = unpack{10,20,30}     -- a=10, b=20, 30 is discarded
```
An important use for unpack is in a generic call mechanism. A generic call mechanism allows you to call any function, with any arguments, dynamically. In ANSI C, for instance, there is no way to do that. You can declare a function that receives a variable number of arguments (with stdarg.h) and you can call a variable function, using pointers to functions. However, you cannot call a function with a variable number of arguments: Each call you write in C has a fixed number of arguments and each argument has a fixed type. In Lua, if you want to call a variable function f with variable arguments in an array a, you simply write
```
    f(unpack(a))
```
The call to unpack returns all values in a, which become the arguments to f. For instance, if we execute
```
    f = string.find
    a = {"hello", "ll"}
```
then the call f(unpack(a)) returns 3 and 4, exactly the same as the static call string.find("hello", "ll").
Although the predefined unpack is written in C, we could write it also in Lua, using recursion:
```
    function unpack (t, i)
      i = i or 1
      if t[i] ~= nil then
        return t[i], unpack(t, i + 1)
      end
    end
```
The first time we call it, with a single argument, i gets 1. Then the function returns t[1] followed by all results from unpack(t, 2), which in turn returns t[2] followed by all results from unpack(t, 3), and so on, until the last non-nil element.