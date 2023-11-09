# 6.2 – Non-Global Functions
An obvious consequence of first-class functions is that we can store functions not only in global variables, but also in table fields and in local variables.

We have already seen several examples of functions in table fields: Most Lua libraries use this mechanism (e.g., io.read, math.sin). To create such functions in Lua, we only have to put together the regular syntax for functions and for tables:
```
    Lib = {}
    Lib.foo = function (x,y) return x + y end
    Lib.goo = function (x,y) return x - y end
```
Of course, we can also use constructors:
```
    Lib = {
      foo = function (x,y) return x + y end,
      goo = function (x,y) return x - y end
    }
```
Moreover, Lua offers yet another syntax to define such functions:
```
    Lib = {}
    function Lib.foo (x,y)
      return x + y
    end
    function Lib.goo (x,y)
      return x - y
    end
```
This last fragment is exactly equivalent to the first example.
When we store a function into a local variable we get a local function, that is, a function that is restricted to a given scope. Such definitions are particularly useful for packages: Because Lua handles each chunk as a function, a chunk may declare local functions, which are visible only inside the chunk. Lexical scoping ensures that other functions in the package can use these local functions:
```
    local f = function (...)
      ...
    end
    
    local g = function (...)
      ...
      f()   -- external local `f' is visible here
      ...
    end
```
Lua supports such uses of local functions with a syntactic sugar for them:
```
    local function f (...)
      ...
    end
```
A subtle point arises in the definition of recursive local functions. The naive approach does not work here:
```
    local fact = function (n)
      if n == 0 then return 1
      else return n*fact(n-1)   -- buggy
      end
    end
```
When Lua compiles the call fact(n-1), in the function body, the local fact is not yet defined. Therefore, that expression calls a global fact, not the local one. To solve that problem, we must first define the local variable and then define the function:
```
    local fact
    fact = function (n)
      if n == 0 then return 1
      else return n*fact(n-1)
      end
    end
```
Now the fact inside the function refers to the local variable. Its value when the function is defined does not matter; by the time the function executes, fact already has the right value. That is the way Lua expands its syntactic sugar for local functions, so you can use it for recursive functions without worrying:
```
    local function fact (n)
      if n == 0 then return 1
      else return n*fact(n-1)
      end
    end
```
Of course, this trick does not work if you have indirect recursive functions. In such cases, you must use the equivalent of an explicit forward declaration:
```
    local f, g    -- `forward' declarations
    
    function g ()
      ...  f() ...
    end
    
    function f ()
      ...  g() ...
    end
```