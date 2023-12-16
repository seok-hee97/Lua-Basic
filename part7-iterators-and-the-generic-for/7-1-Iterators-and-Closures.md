7.1 – Iterators and Closures
An iterator is any construction that allows you to iterate over the elements of a collection. In Lua, we typically represent iterators by functions: Each time we call that function, it returns a "next" element from the collection.

Any iterator needs to keep some state between successive calls, so that it knows where it is and how to proceed from there. Closures provide an excellent mechanism for that task. Remember that a closure is a function that accesses one or more local variables from its enclosing function. Those variables keep their values across successive calls to the closure, allowing the closure to remember where it is along a traversal. Of course, to create a new closure we must also create its external local variables. Therefore, a closure construction typically involves two functions: the closure itself; and a factory, the function that creates the closure.

As a simple example, let us write a simple iterator for a list. Unlike ipairs, this iterator does not return the index of each element, only the value:
```
    function list_iter (t)
      local i = 0
      local n = table.getn(t)
      return function ()
               i = i + 1
               if i <= n then return t[i] end
             end
    end
```
In this example, list_iter is the factory. Each time we call it, it creates a new closure (the iterator itself). That closure keeps its state in its external variables (t, i, and n) so that, each time we call it, it returns a next value from the list t. When there are no more values in the list, the iterator returns nil.
We can use such iterator with a while:
```
    t = {10, 20, 30}
    iter = list_iter(t)    -- creates the iterator
    while true do
      local element = iter()   -- calls the iterator
      if element == nil then break end
      print(element)
    end
```
However, it is easier to use the generic for. After all, it was designed for that kind of iteration:
```
    t = {10, 20, 30}
    for element in list_iter(t) do
      print(element)
    end
```
The generic for does all the bookkeeping from an iteration loop: It calls the iterator factory; keeps the iterator function internally, so we do not need the iter variable; calls the iterator at each new iteration; and stops the loop when the iterator returns nil. (Later we will see that the generic for actually does more than that.)
As a more advanced example, we will write an iterator to traverse all the words from the current input file. To do this traversal, we need to keep two values: the current line and where we are in that line. With this data, we can always generate the next word. To keep it, we use two external local variables, line and pos:
```
    function allwords ()
      local line = io.read()  -- current line
      local pos = 1           -- current position in the line
      return function ()      -- iterator function
        while line do         -- repeat while there are lines
          local s, e = string.find(line, "%w+", pos)
          if s then           -- found a word?
            pos = e + 1       -- next position is after this word
            return string.sub(line, s, e)     -- return the word
          else
            line = io.read()  -- word not found; try next line
            pos = 1           -- restart from first position
          end
        end
        return nil            -- no more lines: end of traversal
      end
    end
```
The main part of the iterator function is the call to string.find. This call searches for a word in the current line, starting at the current position. It describes a "word" using the pattern '%w+', which matches one or more alphanumeric characters. If it finds the word, the function updates the current position to the first character after the word and returns that word. (The string.sub call extracts a substring from line between the given positions). Otherwise, the iterator reads a new line and repeats the search. If there are no more lines, it returns nil to signal the end of the iteration.
Despite its complexity, the use of allwords is straightforward:
```
    for word in allwords() do
      print(word)
    end
```
This is a common situation with iterators: They may be difficult to write, but are easy to use. This is not a big problem; more often than not, end users programming in Lua do not define iterators, but only use those provided by the application.