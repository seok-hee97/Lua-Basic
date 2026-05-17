# 7.2 - The Generic For

The generic `for` loop does all the bookkeeping of iterating: it keeps
the iterator function, calls it on each iteration, and stops when the
iterator returns `nil`. The syntax for the generic `for` is:

```
    for <var-list> in <exp-list> do
      <body>
    end
```

Here `<var-list>` is a list of one or more variable names, separated
by commas, and `<exp-list>` is a list of one or more expressions, also
separated by commas. Usually, `<exp-list>` has only one element: a
call to an iterator factory. For instance, in the code

```lua
    for k, v in pairs(t) do print(k, v) end
```

the variable list is `k, v` and the expression list is the single
element `pairs(t)`. The variable list may have more than one variable;
in this case, the iterator function returns multiple values, one for
each variable.

A more rigorous description: the generic `for` keeps three values
during its loop: the iterator function, an invariant state, and a
control variable. The generic `for` statement

```
    for <var_1>, ..., <var_n> in <explist> do <block> end
```

is equivalent to the following code:

```lua
    do
      local _f, _s, _var = <explist>
      while true do
        local <var_1>, ..., <var_n> = _f(_s, _var)
        _var = <var_1>
        if _var == nil then break end
        <block>
      end
    end
```

So, first the generic `for` evaluates the expressions after the `in`.
Those expressions should return the three values that the `for` keeps:
the iterator function, the invariant state, and the initial value for
the control variable. As in multiple assignments, only the last (or
the only) element of the list can result in more than one value, and
the number of values is adjusted to three, with extra values being
discarded or `nil`s being added as needed. (When we use simple
iterators, the factory returns only the iterator function, so the
invariant state and the control variable get `nil`.)

After this initialization step, the `for` calls the iterator function
with the invariant state and the control variable as arguments. (From
the `for` construct point of view, the invariant state has no meaning
at all. The `for` only passes the state value from the initialization
step to the calls to the iterator function.) Then the `for` assigns
the values returned by the iterator function to the variables declared
by its variable list. If the first value returned (the one assigned to
the control variable) is `nil`, the loop terminates. Otherwise, the
`for` executes its body and calls the iterator function again,
repeating the process.

More specifically, a construct such as

```lua
    for var_1, ..., var_n in <explist> do <block> end
```

is equivalent to the following:

```lua
    do
      local _f, _s, _var = <explist>
      while true do
        local var_1, ... , var_n = _f(_s, _var)
        _var = var_1
        if _var == nil then break end
        <block>
      end
    end
```

The fact that the `for` keeps the iterator function internally is
important. It means that we do not need to worry about its internal
state when we write the iterator: each call to the generic `for`
creates a new iterator and resets its state.

The use of `pairs` to traverse a table is a good example. The next
section explains its behavior and presents another standard iterator,
`ipairs`, which is the canonical way to traverse a sequence in order.
