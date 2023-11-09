6.1 – Closures
When a function is written enclosed in another function, it has full access to local variables from the enclosing function; this feature is called lexical scoping. Although that may sound obvious, it is not. Lexical scoping, plus first-class functions, is a powerful concept in a programming language, but few languages support that concept.

Let us start with a simple example. Suppose you have a list of student names and a table that associates names to grades; you want to sort the list of names, according to their grades (higher grades first). You can do this task as follows:
```
    names = {"Peter", "Paul", "Mary"}
    grades = {Mary = 10, Paul = 7, Peter = 8}
    table.sort(names, function (n1, n2)
      return grades[n1] > grades[n2]    -- compare the grades
    end)
```
Now, suppose you want to create a function to do this task:
```
    function sortbygrade (names, grades)
      table.sort(names, function (n1, n2)
        return grades[n1] > grades[n2]    -- compare the grades
      end)
    end
```
The interesting point in the example is that the anonymous function given to sort accesses the parameter grades, which is local to the enclosing function sortbygrade. Inside this anonymous function, grades is neither a global variable nor a local variable. We call it an external local variable, or an upvalue. (The term "upvalue" is a little misleading, because grades is a variable, not a value. However, this term has historical roots in Lua and it is shorter than "external local variable".)
Why is that so interesting? Because functions are first-class values. Consider the following code:
```
    function newCounter ()
      local i = 0
      return function ()   -- anonymous function
               i = i + 1
               return i
             end
    end
    
    c1 = newCounter()
    print(c1())  --> 1
    print(c1())  --> 2
```
Now, the anonymous function uses an upvalue, i, to keep its counter. However, by the time we call the anonymous function, i is already out of scope, because the function that created that variable (newCounter) has returned. Nevertheless, Lua handles that situation correctly, using the concept of closure. Simply put, a closure is a function plus all it needs to access its upvalues correctly. If we call newCounter again, it will create a new local variable i, so we will get a new closure, acting over that new variable:
```
    c2 = newCounter()
    print(c2())  --> 1
    print(c1())  --> 3
    print(c2())  --> 2
```
So, c1 and c2 are different closures over the same function and each acts upon an independent instantiation of the local variable i. Technically speaking, what is a value in Lua is the closure, not the function. The function itself is just a prototype for closures. Nevertheless, we will continue to use the term "function" to refer to a closure whenever there is no possibility of confusion.
Closures provide a valuable tool in many contexts. As we have seen, they are useful as arguments to higher-order functions such as sort. Closures are valuable for functions that build other functions too, like our newCounter example; this mechanism allows Lua programs to incorporate fancy programming techniques from the functional world. Closures are useful for callback functions, too. The typical example here occurs when you create buttons in a typical GUI toolkit. Each button has a callback function to be called when the user presses the button; you want different buttons to do slightly different things when pressed. For instance, a digital calculator needs ten similar buttons, one for each digit. You can create each of them with a function like the next one:
```
    function digitButton (digit)
      return Button{ label = digit,
                     action = function ()
                                add_to_display(digit)
                              end
                   }
    end
```
In this example, we assume that Button is a toolkit function that creates new buttons; label is the button label; and action is the callback function to be called when the button is pressed. (It is actually a closure, because it accesses the upvalue digit.) The callback function can be called a long time after digitButton did its task and after the local variable digit went out of scope, but it can still access that variable.
Closures are valuable also in a quite different context. Because functions are stored in regular variables, we can easily redefine functions in Lua, even predefined functions. This facility is one of the reasons Lua is so flexible. Frequently, however, when you redefine a function you need the original function in the new implementation. For instance, suppose you want to redefine the function sin to operate in degrees instead of radians. This new function must convert its argument, and then call the original sin function to do the real work. Your code could look like
```
    oldSin = math.sin
    math.sin = function (x)
      return oldSin(x*math.pi/180)
    end
```
A cleaner way to do that is as follows:
```
    do
      local oldSin = math.sin
      local k = math.pi/180
      math.sin = function (x)
        return oldSin(x*k)
      end
    end
```
Now, we keep the old version in a private variable; the only way to access it is through the new version.
You can use this same feature to create secure environments, also called sandboxes. Secure environments are essential when running untrusted code, such as code received through the Internet by a server. For instance, to restrict the files a program can access, we can redefine the open function (from the io library) using closures:
```
    do
      local oldOpen = io.open
      io.open = function (filename, mode)
        if access_OK(filename, mode) then
          return oldOpen(filename, mode)
        else
          return nil, "access denied"
        end
      end
    end
```
What makes this example nice is that, after that redefinition, there is no way for the program to call the unrestricted open, except through the new, restricted version. It keeps the insecure version as a private variable in a closure, inaccessible from the outside. With this facility, you can build Lua sandboxes in Lua itself, with the usual benefit: flexibility. Instead of a one-size-fits-all solution, Lua offers you a meta-mechanism, so that you can tailor your environment for your specific security needs.