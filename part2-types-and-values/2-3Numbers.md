# 2.3 - Numbers

The number type represents real (double-precision floating-point)
numbers. Lua has no integer type, as it does not need it. There is a
widespread misconception about floating-point arithmetic errors and
some people fear that even a simple increment can go weird with
floating-point numbers. The fact is that, when you use a double to
represent an integer, there is no rounding error at all (unless the
number is greater than 100,000,000,000,000). Specifically, a Lua
number can represent any 32-bit integer without rounding problems.
Moreover, most modern CPUs do floating-point arithmetic as fast as (or
even faster than) integer arithmetic.

We can write numeric constants with an optional decimal part, plus an
optional decimal exponent. Examples of valid numeric constants are:

```
4     0.4     4.57e-3     0.3e12     5e+20
```

We can also write hexadecimal constants, prefixing them with `0x`.
