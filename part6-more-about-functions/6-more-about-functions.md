# 6 – More about Functions
Functions in Lua are first-class values with proper lexical scoping.

What does it mean for functions to be "first-class values"? It means that, in Lua, a function is a value with the same rights as conventional values like numbers and strings. Functions can be stored in variables (both global and local) and in tables, can be passed as arguments, and can be returned by other functions.

What does it mean for functions to have "lexical scoping"? It means that functions can access variables of its enclosing functions. (It also means that Lua contains the lambda calculus properly.) As we will see in this chapter, this apparently innocuous property brings great power to the language, because it allows us to apply in Lua many powerful programming techniques from the functional-language world. Even if you have no interest at all in functional programming, it is worth learning a little about how to explore those techniques, because they can make your programs smaller and simpler.

A somewhat difficult notion in Lua is that functions, like all other values, are anonymous; they do not have names. When we talk about a function name, say print, we are actually talking about a variable that holds that function. Like any other variable holding any other value, we can manipulate such variables in many ways. The following example, although a little silly, shows the point:
```
    a = {p = print}
    a.p("Hello World") --> Hello World
    print = math.sin  -- `print' now refers to the sine function
    a.p(print(1))     --> 0.841470
    sin = a.p         -- `sin' now refers to the print function
    sin(10, 20)       --> 10      20
```
Later we will see more useful applications for this facility.
If functions are values, are there any expressions that create functions? Yes. In fact, the usual way to write a function in Lua, like
```
    function foo (x) return 2*x end
```
is just an instance of what we call syntactic sugar; in other words, it is just a pretty way to write
    foo = function (x) return 2*x end
That is, a function definition is in fact a statement (an assignment, more specifically) that assigns a value of type "function" to a variable. We can see the expression function (x) ... end as a function constructor, just as {} is a table constructor. We call the result of such function constructors an anonymous function. Although we usually assign functions to global names, giving them something like a name, there are several occasions when functions remain anonymous. Let us see some examples.
The table library provides a function table.sort, which receives a table and sorts its elements. Such a function must allow unlimited variations in the sort order: ascending or descending, numeric or alphabetical, tables sorted by a key, and so on. Instead of trying to provide all kinds of options, sort provides a single optional parameter, which is the order function: a function that receives two elements and returns whether the first must come before the second in the sort. For instance, suppose we have a table of records such as
```
     network = {
       {name = "grauna",  IP = "210.26.30.34"},
       {name = "arraial", IP = "210.26.30.23"},
       {name = "lua",     IP = "210.26.23.12"},
       {name = "derain",  IP = "210.26.23.20"},
     }
```
If we want to sort the table by the field name, in reverse alphabetical order, we just write
```
    table.sort(network, function (a,b)
      return (a.name > b.name)
    end)
```
See how handy the anonymous function is in that statement.
A function that gets another function as an argument, such as sort, is what we call a higher-order function. Higher-order functions are a powerful programming mechanism and the use of anonymous functions to create their function arguments is a great source of flexibility. But remember that higher-order functions have no special rights; they are a simple consequence of the ability of Lua to handle functions as first-class values.

To illustrate the use of functions as arguments, we will write a naive implementation of a common higher-order function, plot, that plots a mathematical function. Below we show this implementation, using some escape sequences to draw on an ANSI terminal. (You may need to change these control sequences to adapt this code to your terminal type.)
```
    function eraseTerminal ()
      io.write("\27[2J")
    end
    -- writes an `*' at column `x' , row `y'
    function mark (x,y)
      io.write(string.format("\27[%d;%dH*", y, x))
    end
    -- Terminal size
    TermSize = {w = 80, h = 24}
    
    -- plot a function
    -- (assume that domain and image are in the range [-1,1])
    function plot (f)
      eraseTerminal()
      for i=1,TermSize.w do
         local x = (i/TermSize.w)*2 - 1
         local y = (f(x) + 1)/2 * TermSize.h
         mark(i, y)
      end
      io.read()  -- wait before spoiling the screen
    end
```
With that definition in place, you can plot the sine function with a call like
```
    plot(function (x) return math.sin(x*2*math.pi) end)
```
(We need to massage the data a little to put values in the proper range.) When we call plot, its parameter f gets the value of the given anonymous function, which is then called inside the for loop repeatedly to provide the values for the plotting.
Because functions are first-class values in Lua, we can store them not only in global variables, but also in local variables and in table fields. As we will see later, the use of functions in table fields is a key ingredient for some advanced uses of Lua, such as packages and object-oriented programming.