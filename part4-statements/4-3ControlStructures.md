# 4.3 – Control Structures
Lua provides a small and conventional set of control structures, with if for conditional and while, repeat, and for for iteration. All control structures have an explicit terminator: end terminates the if, for and while structures; and until terminates the repeat structure.

The condition expression of a control structure may result in any value. Lua treats as true all values different from false and nil.




### 4.3.1 - if then else

An if statement tests its condition and executes its then-part or its else-part accordingly. The else-part is optional.



An if statement tests its condition and executes its then-part or its else-part accordingly. The else-part is optional.
```
    if a<0 then a = 0 end
    
    if a<b then return a else return b end
    
    if line > MAXLINES then
      showpage()
      line = 0
    end
```

When you write nested ifs, you can use elseif. It is similar to an else followed by an if, but it avoids the need for multiple ends:

```
    if op == "+" then
      r = a + b
    elseif op == "-" then
      r = a - b
    elseif op == "*" then
      r = a*b
    elseif op == "/" then
      r = a/b
    else
      error("invalid operation")
    end
```


### 4.3.2 – while
As usual, Lua first tests the while condition; if the condition is false, then the loop ends; otherwise, Lua executes the body of the loop and repeats the process.
```
    local i = 1
    while a[i] do
      print(a[i])
      i = i + 1
    end
```



### 4.3.3 – repeat
As the name implies, a repeat-until statement repeats its body until its condition is true. The test is done after the body, so the body is always executed at least once.
```
    -- print the first non-empty line
    repeat
      line = io.read()
    until line ~= ""
    print(line)
```



### 4.3.4 – Numeric for
The for statement has two variants: the numeric for and the generic for.

A numeric for has the following syntax:
```
    for var=exp1,exp2,exp3 do
      something
    end
```

That loop will execute something for each value of var from exp1 to exp2, using exp3 as the step to increment var. This third expression is optional; when absent, Lua assumes one as the step value. As typical examples of such loops, we have

```
    for i=1,f(x) do print(i) end
    
    for i=10,1,-1 do print(i) end
```

The for loop has some subtleties that you should learn in order to make good use of it. First, all three expressions are evaluated once, before the loop starts. For instance, in the first example, f(x) is called only once. Second, the control variable is a local variable automatically declared by the for statement and is visible only inside the loop. A typical mistake is to assume that the variable still exists after the loop ends:

```
    for i=1,10 do print(i) end
    max = i      -- probably wrong! `i' here is global
```
If you need the value of the control variable after the loop (usually when you break the loop), you must save this value into another variable:

```
    -- find a value in a list
    local found = nil
    for i=1,a.n do
      if a[i] == value then
        found = i      -- save value of `i'
        break
      end
    end
    print(found)
```

Third, you should never change the value of the control variable: The effect of such changes is unpredictable. If you want to break a for loop before its normal termination, use break.






### 4.3.5 - Generic for

The generic for loop allows you to traverse all values returned by an iterator function. We have already seen examples of the generic for:
```
    -- print all values of array `a'
    for i,v in ipairs(a) do print(v) end
```
For each step in that code, i gets an index, while v gets the value associated with that index. A similar example shows how we traverse all keys of a table:
```
    -- print all keys of table `t'
    for k in pairs(t) do print(k) end
```
Despite its apparent simplicity, the generic for is powerful. With proper iterators, we can traverse almost anything, and do it in a readable fashion. The standard libraries provide several iterators, which allow us to iterate over the lines of a file (io.lines), the pairs in a table (pairs), the words of a string (string.gfind, which we will see in Chapter 20), and so on. Of course, we can write our own iterators. Although the use of the generic for is easy, the task of writing iterator functions has its subtleties. We will cover this topic later, in Chapter 7.
The generic loop shares two properties with the numeric loop: The loop variables are local to the loop body and you should never assign any value to the loop variables.

Let us see a more concrete example of the use of a generic for. Suppose you have a table with the names of the days of the week:
```
    days = {"Sunday", "Monday", "Tuesday", "Wednesday",
            "Thursday", "Friday", "Saturday"}
```
Now you want to translate a name into its position in the week. You can search the table, looking for the given name. Frequently, however, a more efficient approach in Lua is to build a reverse table, say revDays, that has the names as indices and the numbers as values. That table would look like this:
```
    revDays = {["Sunday"] = 1, ["Monday"] = 2,
                ["Tuesday"] = 3, ["Wednesday"] = 4,
                ["Thursday"] = 5, ["Friday"] = 6,
                ["Saturday"] = 7}
```
Then, all you have to do to find the order of a name is to index this reverse table:
```
    x = "Tuesday"
    print(revDays[x])    --> 3
```
Of course, we do not need to manually declare the reverse table. We can build it automatically from the original one:
```
    revDays = {}
    for i,v in ipairs(days) do
      revDays[v] = i
    end
```
The loop will do the assignment for each element of days, with the variable i getting the index (1, 2, ...) and v the value ("Sunday", "Monday", ...).




### 4.4 - break and return

The break and return statements allow us to jump out from an inner block.

You use the break statement to finish a loop. This statement breaks the inner loop (for, repeat, or while) that contains it; it cannot be used outside a loop. After the break, the program continues running from the point immediately after the broken loop.

A return statement returns occasional results from a function or simply finishes a function. There is an implicit return at the end of any function, so you do not need to use one if your function ends naturally, without returning any value.

For syntactic reasons, a break or return can appear only as the last statement of a block (in other words, as the last statement in your chunk or just before an end, an else, or an until). For instance, in the next example, break is the last statement of the then block.
```
    local i = 1
    while a[i] do
      if a[i] == v then break end
      i = i + 1
    end
```
Usually, these are the places where we use these statements, because any other statement following them is unreachable. Sometimes, however, it may be useful to write a return (or a break) in the middle of a block; for instance, if you are debugging a function and want to avoid its execution. In such cases, you can use an explicit do block around the statement:
```
    function foo ()
      return          --<< SYNTAX ERROR
      -- `return' is the last statement in the next block
      do return end   -- OK
      ...             -- statements not reached
    end
```