# 6.3 – Proper Tail Calls
Another interesting feature of functions in Lua is that they do proper tail calls. (Several authors use the term proper tail recursion, although the concept does not involve recursion directly.)

A tail call is a kind of goto dressed as a call. A tail call happens when a function calls another as its last action, so it has nothing else to do. For instance, in the following code, the call to g is a tail call:
```
    function f (x)
      return g(x)
    end
```
After f calls g, it has nothing else to do. In such situations, the program does not need to return to the calling function when the called function ends. Therefore, after the tail call, the program does not need to keep any information about the calling function in the stack. Some language implementations, such as the Lua interpreter, take advantage of this fact and actually do not use any extra stack space when doing a tail call. We say that those implementations support proper tail calls.
Because a proper tail call uses no stack space, there is no limit on the number of "nested" tail calls that a program can make. For instance, we can call the following function with any number as argument; it will never overflow the stack:
```
    function foo (n)
      if n > 0 then return foo(n - 1) end
    end
```
A subtle point when we use proper tail calls is what is a tail call. Some obvious candidates fail the criteria that the calling function has nothing to do after the call. For instance, in the following code, the call to g is not a tail call:
```
    function f (x)
      g(x)
      return
    end
```
The problem in that example is that, after calling g, f still has to discard occasional results from g before returning. Similarly, all the following calls fail the criteria:
```
    return g(x) + 1     -- must do the addition
    return x or g(x)    -- must adjust to 1 result
    return (g(x))       -- must adjust to 1 result
```
In Lua, only a call in the format return g(...) is a tail call. However, both g and its arguments can be complex expressions, because Lua evaluates them before the call. For instance, the next call is a tail call:
      return x[i].foo(x[j] + a*b, i + j)
As I said earlier, a tail call is a kind of goto. As such, a quite useful application of proper tail calls in Lua is for programming state machines. Such applications can represent each state by a function; to change state is to go to (or to call) a specific function. As an example, let us consider a simple maze game. The maze has several rooms, each with up to four doors: north, south, east, and west. At each step, the user enters a movement direction. If there is a door in that direction, the user goes to the corresponding room; otherwise, the program prints a warning. The goal is to go from an initial room to a final room.

This game is a typical state machine, where the current room is the state. We can implement such maze with one function for each room. We use tail calls to move from one room to another. A small maze with four rooms could look like this:
```
    function room1 ()
      local move = io.read()
      if move == "south" then return room3()
      elseif move == "east" then return room2()
      else print("invalid move")
           return room1()   -- stay in the same room
      end
    end
    
    function room2 ()
      local move = io.read()
      if move == "south" then return room4()
      elseif move == "west" then return room1()
      else print("invalid move")
           return room2()
      end
    end
    
    function room3 ()
      local move = io.read()
      if move == "north" then return room1()
      elseif move == "east" then return room4()
      else print("invalid move")
           return room3()
      end
    end
    
    function room4 ()
      print("congratulations!")
    end
```
We start the game with a call to the initial room:
```
    room1()
```
Without proper tail calls, each user move would create a new stack level. After some number of moves, there would be a stack overflow. With proper tail calls, there is no limit to the number of moves that a user can make, because each move actually performs a goto to another function, not a conventional call.

For this simple game, you may find that a data-driven program, where you describe the rooms and movements with tables, is a better design. However, if the game has several special situations in each room, then this state-machine design is quite appropriate.