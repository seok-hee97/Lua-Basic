-- 3.5- Precedence

-- Operator precedence in Lua follows the table below,
-- from the higher to the lower priority:


```
^
not  - (unary)
*   /
+   -
..
<   >   <=  >=  ~=  ==
and
or
```


-- All binary operators are left associative, 
-- except for `^´ (exponentiation) and `..´ (concatenation),
--  which are right associative. Therefore,
--   the following expressions on the left are equivalent to those on the right:

```
a+i < b/2+1          <-->       (a+i) < ((b/2)+1)
5+x^2*8              <-->       5+((x^2)*8)
a < y and y <= z     <-->       (a < y) and (y <= z)
-x^2                 <-->       -(x^2)
x^y^z                <-->       x^(y^z)
```



When in doubt, always use explicit parentheses. It is easier than looking up in the manual and probably you will have the same doubt when you read the code again.