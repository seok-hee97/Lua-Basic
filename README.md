# Lua-Basic

Study notes for learning the Lua programming language, based on
*Programming in Lua* (1st edition) by Roberto Ierusalimschy.

This repository walks through the language one chapter at a time,
mixing prose explanations (`.md` files) with runnable examples (`.lua` files).

## Roadmap

| Part | Topic | Status |
| ---- | ----- | ------ |
| [Part 1](part1-the-language/) | The Language | Complete |
| [Part 2](part2-types-and-values/) | Types and Values | Complete |
| [Part 3](part3-expressions/) | Expressions | Complete |
| [Part 4](part4-statements/) | Statements | Complete |
| [Part 5](part5-functions/) | Functions | Complete |
| [Part 6](part6-more-about-functions/) | More about Functions | Complete |
| [Part 7](part7-iterators-and-the-generic-for/) | Iterators and the Generic For | Complete |

There is also a single-file overview at [lua-basic.lua](lua-basic.lua),
adapted from "Learn Lua in 15 Minutes".

## Running the Examples

Install Lua (5.1+ recommended for these notes; the examples target the
language as described in PIL 1st edition):

```sh
# macOS
brew install lua

# Debian / Ubuntu
sudo apt-get install lua5.1
```

Then run any example directly:

```sh
lua part1-the-language/factorial.lua
```

## References

- [Programming in Lua (1st edition)](https://www.lua.org/pil/contents.html)
- [Learn Lua in 15 Minutes](https://tylerneylon.com/a/learn-lua/)
- [Lua Short Reference](http://lua-users.org/wiki/LuaShortReference)
