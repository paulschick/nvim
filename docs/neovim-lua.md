### Lua Example: Calling a Function with Multiple Arguments

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Illustrates a simple Lua assignment where a function 'f' is called with a string, a table field access, and an integer as arguments, and its result is assigned to variable 'a'.

```Lua
a = f("how", t.x, 14)
```

--------------------------------

### Lua C API: lua_equal

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Compares two values on the Lua stack for equality using Lua's `==` operator semantics. It returns 1 if they are equal, otherwise 0, also handling invalid indices.

```APIDOC
int lua_equal (lua_State *L, int index1, int index2);

Returns 1 if the two values in acceptable indices `index1` and `index2` are equal, following the semantics of the Lua `==` operator (that is, may call metamethods). Otherwise returns 0. Also returns 0 if any of the indices is non valid.

Parameters:
  L: The Lua state pointer.
  index1: The stack index of the first value.
  index2: The stack index of the second value.
Returns:
  int: 1 if the values are equal, 0 otherwise.
```

--------------------------------

### Lua C API: Loading Lua Chunks (`luaL_loadbuffer`, `luaL_loadfile`, `luaL_loadstring`)

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

These functions provide various ways to load Lua chunks (code) into the Lua state without executing them. They are wrappers around `lua_load` and handle loading from memory buffers, files, or C strings.

```APIDOC
int luaL_loadbuffer (lua_State *L,
                     const char *buff,
                     size_t sz,
                     const char *name);
  - Loads a buffer as a Lua chunk.
  - This function uses `lua_load` to load the chunk in the buffer pointed to by `buff` with size `sz`.
  - Parameters:
    - L: The Lua state.
    - buff: Pointer to the buffer containing the chunk.
    - sz: Size of the buffer.
    - name: Chunk name, used for debug information and error messages.
  - Returns: Same results as `lua_load` (0 on success, LUA_ERRSYNTAX, LUA_ERRMEM).

int luaL_loadfile (lua_State *L, const char *filename);
  - Loads a file as a Lua chunk.
  - This function uses `lua_load` to load the chunk in the file named `filename`.
  - If `filename` is `NULL`, then it loads from the standard input.
  - The first line in the file is ignored if it starts with a `#`.
  - Parameters:
    - L: The Lua state.
    - filename: Path to the file. If NULL, loads from standard input.
  - Returns: Same results as `lua_load`, but with an extra error code `LUA_ERRFILE` if it cannot open/read the file.
  - Note: This function only loads the chunk; it does not run it.

int luaL_loadstring (lua_State *L, const char *s);
  - Loads a zero-terminated C string as a Lua chunk.
  - This function uses `lua_load` to load the chunk in the zero-terminated string `s`.
  - Parameters:
    - L: The Lua state.
    - s: The C string containing the chunk.
  - Returns: Same results as `lua_load`.
  - Note: This function only loads the chunk; it does not run it.
```

--------------------------------

### Lua C API Stack Push Functions

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Comprehensive documentation for Lua C API functions used to push various data types onto the Lua stack. These functions handle memory allocation and type conversion, allowing C code to prepare values for Lua scripts.

```APIDOC
lua_pushfstring (lua_State *L, const char *fmt, ...)
  - Pushes a formatted string onto the stack and returns a pointer to this string.
  - Similar to C's `sprintf`, but Lua handles memory allocation and garbage collection.
  - Conversion specifiers are restricted: `%%` (inserts `%`), `%s` (zero-terminated string), `%f` (lua_Number), `%p` (pointer as hexadecimal), `%d` (int), `%c` (int as char).
  - Parameters:
    - L: The Lua state.
    - fmt: The format string.
    - ...: Variable arguments for formatting.
  - Returns: A pointer to the pushed string.

lua_pushinteger (lua_State *L, lua_Integer n)
  - Pushes a number with value `n` onto the stack.
  - Parameters:
    - L: The Lua state.
    - n: The integer value to push.

lua_pushlightuserdata (lua_State *L, void *p)
  - Pushes a light userdata onto the stack.
  - Represents a C pointer in Lua. It is a value, not created or collected by Lua's GC, and has no individual metatable.
  - A light userdata is equal to any other light userdata with the same C address.
  - Parameters:
    - L: The Lua state.
    - p: The C pointer to push as light userdata.

lua_pushlstring (lua_State *L, const char *s, size_t len)
  - Pushes the string pointed to by `s` with size `len` onto the stack.
  - Lua makes (or reuses) an internal copy of the given string, so the memory at `s` can be freed or reused immediately.
  - The string can contain embedded zeros.
  - Parameters:
    - L: The Lua state.
    - s: Pointer to the string data.
    - len: The length of the string.

lua_pushnil (lua_State *L)
  - Pushes a nil value onto the stack.
  - Parameters:
    - L: The Lua state.

lua_pushnumber (lua_State *L, lua_Number n)
  - Pushes a number with value `n` onto the stack.
  - Parameters:
    - L: The Lua state.
    - n: The number value to push.

lua_pushstring (lua_State *L, const char *s)
  - Pushes the zero-terminated string pointed to by `s` onto the stack.
  - Lua makes (or reuses) an internal copy of the given string, so the memory at `s` can be freed or reused immediately.
  - The string cannot contain embedded zeros; it is assumed to end at the first zero.
  - Parameters:
    - L: The Lua state.
    - s: Pointer to the zero-terminated string.

lua_pushthread (lua_State *L)
  - Pushes the thread represented by `L` onto the stack.
  - Parameters:
    - L: The Lua state (representing the thread).
  - Returns: 1 if this thread is the main thread of its state, otherwise 0.

lua_pushvalue (lua_State *L, int index)
  - Pushes a copy of the element at the given valid index onto the stack.
  - Parameters:
    - L: The Lua state.
    - index: The valid stack index of the element to copy.

lua_pushvfstring (lua_State *L, const char *fmt, va_list argp)
  - Equivalent to `lua_pushfstring`, but receives a `va_list` instead of a variable number of arguments.
  - Parameters:
    - L: The Lua state.
    - fmt: The format string.
    - argp: The `va_list` containing arguments for formatting.
  - Returns: A pointer to the pushed string.
```

--------------------------------

### Lua C API Core Functions

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Detailed documentation for various essential functions provided by the Lua C API. This includes functions for checking data types, creating and managing Lua states, manipulating tables on the stack, loading Lua chunks, and handling threads and userdata.

```APIDOC
lua_isuserdata (lua_State *L, int index)
  - Returns 1 if the value at the given acceptable index is a userdata (either full or light), and 0 otherwise.

lua_lessthan (lua_State *L, int index1, int index2)
  - Returns 1 if the value at acceptable index `index1` is smaller than the value at acceptable index `index2`, following the semantics of the Lua `<` operator (that is, may call metamethods). Otherwise returns 0. Also returns 0 if any of the indices is non valid.

lua_load (lua_State *L, lua_Reader reader, void *data, const char *chunkname)
  - Loads a Lua chunk. If there are no errors, `lua_load` pushes the compiled chunk as a Lua function on top of the stack. Otherwise, it pushes an error message.
  - Returns:
    - `0`: no errors;
    - `LUA_ERRSYNTAX`: syntax error during pre-compilation;
    - `LUA_ERRMEM`: memory allocation error.
  - This function only loads a chunk; it does not run it.
  - `lua_load` automatically detects whether the chunk is text or binary, and loads it accordingly.
  - Parameters:
    - `L`: The Lua state.
    - `reader`: A user-supplied function to read the chunk (see |lua_Reader|).
    - `data`: An opaque value passed to the reader function.
    - `chunkname`: A name for the chunk, used for error messages and debug information (see |lua-apiDebug|).

lua_newstate (lua_Alloc f, void *ud)
  - Creates a new, independent Lua state.
  - Returns: A pointer to the new `lua_State`, or `NULL` if creation fails (e.g., due to lack of memory).
  - Parameters:
    - `f`: The allocator function; Lua uses this for all memory allocation for this state.
    - `ud`: An opaque pointer passed to the allocator in every call.

lua_newtable (lua_State *L)
  - Creates a new empty table and pushes it onto the stack.
  - Equivalent to `lua_createtable(L, 0, 0)` (see |lua_createtable()|).

lua_newthread (lua_State *L)
  - Creates a new thread, pushes it on the stack, and returns a pointer to a `lua_State` that represents this new thread.
  - The new state shares all global objects (such as tables) with the original state but has an independent execution stack.
  - Threads are subject to garbage collection; there is no explicit function to close or destroy them.

lua_newuserdata (lua_State *L, size_t size)
  - Allocates a new block of memory with the given size, pushes onto the stack a new full userdata with the block address, and returns this address.
  - Userdata represents C values in Lua. A full userdata is an object (like a table): it can have its own metatable and can be detected when collected.
  - When Lua collects a full userdata with a `gc` metamethod, Lua calls the metamethod and marks the userdata as finalized. When collected again, Lua frees its corresponding memory.

lua_next (lua_State *L, int index)
  - Pops a key from the stack, and pushes a key-value pair from the table at the given index (the "next" pair after the given key).
  - Returns 0 if there are no more elements in the table (and pushes nothing).
```

```C
/* table is in the stack at index 't' */
lua_pushnil(L);  /* first key */
while (lua_next(L, t) != 0) {
  /* uses 'key' (at index -2) and 'value' (at index -1) */
  // ... process key and value ...
  lua_pop(L, 1); // removes 'value'; keeps 'key' for next iteration
}
```

--------------------------------

### Calling Lua Functions from Vimscript using v:lua

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Details the `v:lua` prefix for invoking global Lua functions or functions within Lua modules from Vimscript, covering direct calls, module access, `require` usage, and common error scenarios. Includes an example Lua omnifunc.

```APIDOC
Vimscript v:lua Interface:

Purpose: Call Lua functions from Vimscript.

Syntax:
- Call global Lua function: `call v:lua.func(arg1, arg2)`
  Equivalent Lua: `return func(...)`
- Call Lua module function: `call v:lua.somemod.func(args)`
  Equivalent Lua: `return somemod.func(...)`
- Call Lua module function via require:
  `call v:lua.require'mypack'.func(arg1, arg2)`
  `call v:lua.require'mypack.submod'.func(arg1, arg2)`
  Note: Only single quote form without parens is allowed for `require`.

Usage with "func" options (e.g., 'tagfunc', 'omnifunc'):
- Setting Vimscript option: `vim.bo[buf].omnifunc = 'v:lua.mymod.omnifunc'`

Calling Lua functions as Vimscript methods:
- Syntax: `:eval arg1->v:lua.somemod.func(arg2)`

Common Errors/Limitations:
- `v:lua` without a call is not allowed in Vimscript expressions.
- Funcrefs cannot represent Lua functions.
- Examples of errors:
  `let g:Myvar = v:lua.myfunc`
  `call SomeFunc(v:lua.mycallback)`
  `let g:foo = v:lua`
  `let g:foo = v:['lua']`
```

```Vimscript
call v:lua.func(arg1, arg2)
call v:lua.somemod.func(args)
call v:lua.require'mypack'.func(arg1, arg2)
call v:lua.require'mypack.submod'.func(arg1, arg2)
vim.bo[buf].omnifunc = 'v:lua.mymod.omnifunc'
:eval arg1->v:lua.somemod.func(arg2)
let g:Myvar = v:lua.myfunc        " Error
call SomeFunc(v:lua.mycallback)   " Error
let g:foo = v:lua                 " Error
let g:foo = v:['lua']             " Error
```

```Lua
function mymod.omnifunc(findstart, base)
  if findstart == 1 then
    return 0
  else
    return {'stuff', 'steam', 'strange things'}
  end
end
```

--------------------------------

### Lua Auxiliary Library Functions for Buffer Manipulation

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Functions provided by the Lua auxiliary library for efficiently building strings using `luaL_Buffer`.

```APIDOC
luaL_addchar (luaL_Buffer *B, char c)
  - Adds the character 'c' to the buffer 'B'.
  - Parameters:
    - B: A pointer to a luaL_Buffer structure.
    - c: The character to add.
  - Returns: void.

luaL_addlstring (luaL_Buffer *B, const char *s, size_t l)
  - Adds the string pointed to by 's' with length 'l' to the buffer 'B'.
  - Parameters:
    - B: A pointer to a luaL_Buffer structure.
    - s: A pointer to the string to add.
    - l: The length of the string.
  - Returns: void.
  - Note: The string may contain embedded zeros.
```

--------------------------------

### Execute Lua Command in Neovim

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Demonstrates how to run a Lua expression directly within Neovim's command line using the `:lua` command, specifically to print the `package.loaded` table which lists all currently loaded Lua modules.

```Lua
:lua vim.print(package.loaded)
```

--------------------------------

### C Function Example: Calculating Average and Sum of Lua Arguments

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

A C function `foo` that receives a variable number of numerical arguments from Lua, calculates their sum and average, and returns both values to Lua. It includes error handling for non-numeric arguments, demonstrating proper stack interaction and return value handling.

```C
static int foo (lua_State *L) {
  int n = lua_gettop(L);    /* number of arguments */
  lua_Number sum = 0;
  int i;
  for (i = 1; i <= n; i++) {
    if (!lua_isnumber(L, i)) {
      lua_pushstring(L, "incorrect argument");
      lua_error(L);
    }
    sum += lua_tonumber(L, i);
  }
  lua_pushnumber(L, sum/n); /* first result */
  lua_pushnumber(L, sum);   /* second result */
  return 2;                 /* number of results */
}
```

--------------------------------

### C Equivalent: Calling Lua Function from C

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Demonstrates how to call a Lua function 'f' from C, passing arguments and handling return values using the Lua C API. It shows stack manipulation for arguments and retrieving the result, ensuring the stack is balanced at the end.

```C
lua_getfield(L, LUA_GLOBALSINDEX, "f"); // function to be called
lua_pushstring(L, "how");                        // 1st argument
lua_getfield(L, LUA_GLOBALSINDEX, "t");   // table to be indexed
lua_getfield(L, -1, "x");        // push result of t.x (2nd arg)
lua_remove(L, -2);                  // remove 't' from the stack
lua_pushinteger(L, 14);                          // 3rd argument
lua_call(L, 3, 1);     // call 'f' with 3 arguments and 1 result
lua_setfield(L, LUA_GLOBALSINDEX, "a");        // set global 'a'
```

--------------------------------

### Pretty Print Lua Variables (Lua)

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Demonstrates how to use `vim.print` to pretty-print Lua variables to the Neovim message area. This is useful for debugging and inspecting table structures or other complex data.

```Lua
local hl_normal = vim.print(vim.api.nvim_get_hl(0, { name = 'Normal' }))
```

--------------------------------

### Lua C API - Stack Manipulation

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Functions for manipulating the Lua stack, such as moving elements.

```APIDOC
lua_insert (lua_State *L, int index)
  - Description: Moves the top element into the given valid index, shifting up elements above this index. Cannot be called with a pseudo-index.
  - Parameters:
    - L: The Lua state.
    - index: The valid stack index where the top element should be moved.
  - Returns: void
```

--------------------------------

### Define and Call a Lua Function in Neovim

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Demonstrates the basic definition of a Lua function and how to call it with all expected arguments. Shows how `print` outputs values to the Neovim message area.

```lua
local foo = function(a, b)
    print("A: ", a)
    print("B: ", b)
end

foo(1, 2)
```

--------------------------------

### Lua Function Argument and Vararg Handling

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Illustrates how Lua functions handle arguments, including `nil` for missing parameters, truncation of extra arguments, and the behavior of vararg expressions (`...`). It also shows how multiple return values from a function are handled when passed as arguments.

```lua
function f(a, b) end
function g(a, b, ...) end
function r() return 1,2,3 end

-- CALL            PARAMETERS
-- f(3)             a=3, b=nil
-- f(3, 4)          a=3, b=4
-- f(3, 4, 5)       a=3, b=4
-- f(r(), 10)       a=1, b=10
-- f(r())           a=1, b=2

-- g(3)             a=3, b=nil, ... -->  (nothing)
-- g(3, 4)          a=3, b=4,   ... -->  (nothing)
-- g(3, 4, 5, 8)    a=3, b=4,   ... -->  5  8
-- g(5, r())        a=5, b=1,   ... -->  2  3
```

--------------------------------

### Lua Numeric For Loop Syntax and Expansion

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Explains the syntax and behavior of the numeric `for` loop in Lua, which iterates a block of code through an arithmetic progression. It provides the equivalent Lua code demonstrating how the loop variables, limits, and steps are managed internally, including the evaluation of control expressions only once before the loop starts.

```APIDOC
stat ::= for Name = exp , exp [ , exp ] do block end
```

```lua
do
  local var, limit, step = tonumber(e1), tonumber(e2), tonumber(e3)
  if not ( var and limit and step ) then error() end
  while ( step >0 and var <= limit )
          or ( step <=0 and var >= limit ) do
    block
    var = var + step
  end
end
```

--------------------------------

### Lua String Library Functions Reference

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Comprehensive documentation for the built-in Lua `string` library, detailing functions for character manipulation, string formatting, pattern matching, and binary representation of functions. Includes parameter descriptions, return values, and usage notes.

```APIDOC
string.byte({s} [, {i} [, {j}]])
  - Returns the internal numerical codes of the characters `s[i]`, `s[i+1]`,..., `s[j]`.
  - Parameters:
    - s: The input string.
    - i: (Optional) The starting index (1-based). Default is 1.
    - j: (Optional) The ending index (1-based). Default is {i}.
  - Returns: Numerical codes (integers).
  - Note: Numerical codes are not necessarily portable across platforms.

string.char({...})
  - Receives zero or more integers and returns a string with characters corresponding to their internal numerical codes.
  - Parameters:
    - ...: Zero or more integers representing character codes.
  - Returns: A string.
  - Note: Numerical codes are not necessarily portable across platforms.

string.dump({function})
  - Returns a string containing a binary representation of the given function.
  - Parameters:
    - function: A Lua function without upvalues.
  - Returns: A string (binary representation).
  - Usage: A later `loadstring()` on this string can return a copy of the function.

string.find({s}, {pattern} [, {init} [, {plain}]])
  - Looks for the first match of {pattern} in the string {s}.
  - Parameters:
    - s: The string to search within.
    - pattern: The pattern to search for.
    - init: (Optional) Where to start the search (1-based index, can be negative). Default is 1.
    - plain: (Optional) If true, turns off pattern matching facilities, performing a plain substring search.
  - Returns:
    - If a match is found: The indices of {s} where the occurrence starts and ends.
    - If no match: `nil`.
    - If the pattern has captures: The captured values are also returned after the two indices.

string.format({formatstring}, {...})
  - Returns a formatted version of its variable number of arguments.
  - Parameters:
    - formatstring: The format string, following `printf` family rules from C.
    - ...: Variable arguments to be formatted.
  - Supported options: `c`, `d`, `E`, `e`, `f`, `g`, `G`, `i`, `o`, `u`, `X`, `x` (expect number); `q`, `s` (expect string).
  - Unsupported options: `*`, `l`, `L`, `n`, `p`, `h`.
  - Special `q` option: Formats a string to be safely read back by Lua interpreter (escapes quotes, newlines, zeros, backslashes).
  - Limitation: Does not accept string values containing embedded zeros.
  - Example:
    string.format('%q', 'a string with "quotes" and \n new line')
    -- Expected output: "a string with \"quotes\" and \\n new line"

string.gmatch({s}, {pattern})
  - Returns an iterator function that, each time it is called, returns the next captures from {pattern} over string {s}.
  - Parameters:
    - s: The string to iterate over.
    - pattern: The pattern to match.
  - Returns: An iterator function.
  - Behavior:
    - If {pattern} specifies no captures, the whole match is produced in each call.
  - Example:
    s = "hello world from Lua"
    for w in string.gmatch(s, "%a+") do
      print(w)
    end
    -- This loop will iterate over all the words from string {s}, printing one per line.
```

--------------------------------

### Run Lua Script from Shell

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Illustrates how to execute a Lua script directly from the shell using the Neovim executable with the `-l` argument, allowing external Lua files to be run with Neovim's Lua environment.

```Shell
nvim -l foo.lua [args...]
```

--------------------------------

### Lua C API: State and Metatable Management (`luaL_newmetatable`, `luaL_newstate`, `luaL_openlibs`)

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

These functions facilitate the creation and initialization of Lua states, the management of metatables in the registry, and the loading of standard Lua libraries.

```APIDOC
int luaL_newmetatable (lua_State *L, const char *tname);
  - If the registry already has the key `tname`, returns 0. Otherwise, creates a new table to be used as a metatable for userdata, adds it to the registry with key `tname`, and returns 1.
  - In both cases, pushes onto the stack the final value associated with `tname` in the registry.
  - Parameters:
    - L: The Lua state.
    - tname: The name for the metatable in the registry.
  - Returns: 0 if metatable already exists, 1 if a new one was created.

lua_State *luaL_newstate (void);
  - Creates a new Lua state.
  - It calls `lua_newstate` with an allocator based on the standard C `realloc` function and then sets a panic function that prints an error message to the standard error output in case of fatal errors.
  - Returns: The new state, or `NULL` if there is a memory allocation error.

void luaL_openlibs (lua_State *L);
  - Opens all standard Lua libraries into the given state.
  - Parameters:
    - L: The Lua state.
```

--------------------------------

### Emulating Keyword Arguments (Kwargs) in Lua

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Shows how to mimic named parameters (kwargs) in Lua by passing a table literal as the sole argument to a function. This leverages Lua's syntax sugar for table arguments, providing a visually similar interface to Python/C# kwargs.

```lua
local func_with_opts = function(opts)
    local will_do_foo = opts.foo
    local filename = opts.filename
    -- ...
end

func_with_opts { foo = true, filename = "hello.world" }
```

--------------------------------

### Lua C API Thread and Coroutine Management

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

This section covers Lua C API functions for managing values across different Lua threads and for yielding coroutines.

```APIDOC
lua_xmove
  void lua_xmove (lua_State *from, lua_State *to, int n);
    - Exchanges values between different threads of the `same` global state.
    - This function pops `n` values from the stack `from`, and pushes them onto the stack `to`.
    - Parameters:
      - from: The source Lua state (thread).
      - to: The destination Lua state (thread).
      - n: The number of values to move.
    - Returns: `void`.

lua_yield
  int lua_yield (lua_State *L, int nresults);
    - Yields a coroutine.
    - This function should only be called as the return expression of a C function.
    - When a C function calls `lua_yield` in that way, the running coroutine suspends its execution, and the call to `lua_resume` (see |lua_resume()|) that started this coroutine returns.
    - The parameter `nresults` is the number of values from the stack that are passed as results to `lua_resume`.
    - Parameters:
      - L: The Lua state.
      - nresults: The number of values on the stack to pass as results to `lua_resume`.
    - Returns: An `int` (typically `LUA_YIELD`).
    - Usage Example:
      return lua_yield (L, nresults);
```

--------------------------------

### Lua Logical Operator Examples

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Demonstrates the behavior of Lua's logical operators (`and`, `or`, `not`) including short-circuit evaluation. Shows how `nil` and `false` are treated as false, and all other values as true.

```Lua
10 or 20            --> 10
10 or error()       --> 10
nil or "a"          --> "a"
nil and 10          --> nil
false and error()   --> false
false and nil       --> false
false or nil        --> nil
10 and 20           --> 20
```

--------------------------------

### Evaluate Lua Code from Vimscript using luaeval

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Demonstrates how to execute arbitrary Lua code and call Lua functions from Vimscript using `luaeval`, including passing Vimscript variables and handling return values.

```Vimscript
:echo luaeval('math.pi')
:function Rand(x,y)
:  return luaeval('(_A.y-_A.x)*math.random()+_A.x', {'x':a:x,'y':a:y})
:  endfunction
:echo Rand(1,10)
```

--------------------------------

### Lua Math Library Reference

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Comprehensive reference for Lua's standard math library, including trigonometric, logarithmic, exponential, and utility functions, as well as constants. These functions operate on numerical inputs and return numerical results.

```APIDOC
math.abs({x})
	- Returns the absolute value of {x}.
	- Parameters:
		- x: The number.

math.acos({x})
	- Returns the arc cosine of {x} (in radians).
	- Parameters:
		- x: The number, typically in the range [-1, 1].

math.asin({x})
	- Returns the arc sine of {x} (in radians).
	- Parameters:
		- x: The number, typically in the range [-1, 1].

math.atan({x})
	- Returns the arc tangent of {x} (in radians).
	- Parameters:
		- x: The number.

math.atan2({y}, {x})
	- Returns the arc tangent of y/x (in radians), using the signs of both arguments to determine the quadrant.
	- Parameters:
		- y: The y-coordinate.
		- x: The x-coordinate.

math.ceil({x})
	- Returns the smallest integer larger than or equal to {x}.
	- Parameters:
		- x: The number.

math.cos({x})
	- Returns the cosine of {x} (assumed to be in radians).
	- Parameters:
		- x: The angle in radians.

math.cosh({x})
	- Returns the hyperbolic cosine of {x}.
	- Parameters:
		- x: The number.

math.deg({x})
	- Returns the angle {x} (given in radians) in degrees.
	- Parameters:
		- x: The angle in radians.

math.exp({x})
	- Returns the value `e^x`.
	- Parameters:
		- x: The exponent.

math.floor({x})
	- Returns the largest integer smaller than or equal to {x}.
	- Parameters:
		- x: The number.

math.fmod({x}, {y})
	- Returns the remainder of the division of {x} by {y}.
	- Parameters:
		- x: The dividend.
		- y: The divisor.

math.frexp({x})
	- Returns `m` and `e` such that `x = m * 2^e`, `e` is an integer and the absolute value of `m` is in the range `[0.5, 1)` (or zero when {x} is zero).
	- Parameters:
		- x: The number.
	- Returns:
		- m: The mantissa.
		- e: The exponent.

math.huge
	- The value `HUGE_VAL`, a value larger than or equal to any other numerical value.

math.ldexp({m}, {e})
	- Returns `m * 2^e` (`e` should be an integer).
	- Parameters:
		- m: The mantissa.
		- e: The integer exponent.

math.log({x})
	- Returns the natural logarithm of {x}.
	- Parameters:
		- x: The number.

math.log10({x})
	- Returns the base-10 logarithm of {x}.
	- Parameters:
		- x: The number.

math.max({x}, {...})
	- Returns the maximum value among its arguments.
	- Parameters:
		- x: The first number.
		- ...: Additional numbers.

math.min({x}, {...})
	- Returns the minimum value among its arguments.
	- Parameters:
		- x: The first number.
		- ...: Additional numbers.

math.modf({x})
	- Returns two numbers, the integral part of {x} and the fractional part of {x}.
	- Parameters:
		- x: The number.
	- Returns:
		- integral_part: The integral part of x.
		- fractional_part: The fractional part of x.

math.pi
	- The value of `pi`.

math.pow({x}, {y})
	- Returns `x^y`. (You can also use the expression `x^y` to compute this value.)
	- Parameters:
		- x: The base.
		- y: The exponent.

math.rad({x})
	- Returns the angle {x} (given in degrees) in radians.
	- Parameters:
		- x: The angle in degrees.

math.random([{m} [, {n}]])
	- This function is an interface to the simple pseudo-random generator function `rand` provided by ANSI C. (No guarantees can be given for its statistical properties.)
	- When called without arguments, returns a pseudo-random real number in the range `[0,1)`.
	- When called with a number {m}, `math.random` returns a pseudo-random integer in the range `[1, m]`.
	- When called with two numbers {m} and {n}, `math.random` returns a pseudo-random integer in the range `[m, n]`.
	- Parameters:
		- m (optional): Upper bound for integer generation (inclusive, starting from 1).
		- n (optional): Upper bound for integer generation (inclusive, starting from m).

math.randomseed({x})
	- Sets {x} as the "seed" for the pseudo-random generator: equal seeds produce equal sequences of numbers.
	- Parameters:
		- x: The seed value.

math.sin({x})
	- Returns the sine of {x} (assumed to be in radians).
	- Parameters:
		- x: The angle in radians.

math.sinh({x})
	- Returns the hyperbolic sine of {x}.
	- Parameters:
		- x: The number.

math.sqrt({x})
	- Returns the square root of {x}. (You can also use the expression `x^0.5` to compute this value.)
	- Parameters:
		- x: The number.

math.tan({x})
	- Returns the tangent of {x} (assumed to be in radians).
	- Parameters:
		- x: The angle in radians.

math.tanh({x})
	- Returns the hyperbolic tangent of {x}.
	- Parameters:
		- x: The number.
```

--------------------------------

### Lua Table Count Examples

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/lua.txt

Shows how `vim.tbl_count` correctly counts elements in both list-like and dictionary-like Lua tables.

```lua
vim.tbl_count({ a=1, b=2 })  --> 2
vim.tbl_count({ 1, 2 })      --> 2
```

--------------------------------

### Lua Coroutine Management API

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Provides functions for creating, resuming, suspending, and checking the status of Lua coroutines, enabling cooperative multitasking within Neovim's Lua environment.

```APIDOC
coroutine.create({f})
  - Creates a new coroutine, with body {f}. {f} must be a Lua function.
  - Returns: This new coroutine, an object with type "thread".

coroutine.resume({co} [, {val1}, {...}])
  - Starts or continues the execution of coroutine {co}.
  - Parameters:
    - co: The coroutine to resume.
    - val1, ...: Values passed as arguments to the body function (first resume) or as results from the yield (subsequent resumes).
  - Returns:
    - `true` plus any values passed to `yield` (if the coroutine yields) or any values returned by the body function (if the coroutine terminates).
    - `false` plus the error message (if there is any error).

coroutine.running()
  - Returns: The running coroutine, or `nil` when called by the main thread.

coroutine.status({co})
  - Returns: The status of coroutine {co}, as a string:
    - "running": If the coroutine is running (that is, it called `status`).
    - "suspended": If the coroutine is suspended in a call to `yield`, or if it has not started running yet.
    - "normal": If the coroutine is active but not running (that is, it has resumed another coroutine).
    - "dead": If the coroutine has finished its body function, or if it has stopped with an error.

coroutine.wrap({f})
  - Creates a new coroutine, with body {f}. {f} must be a Lua function.
  - Returns: A function that resumes the coroutine each time it is called.
    - Any arguments passed to the function behave as the extra arguments to `resume`.
    - Returns the same values returned by `resume`, except the first boolean.
    - In case of error, propagates the error.

coroutine.yield({...})
  - Suspends the execution of the calling coroutine.
  - Constraints: The coroutine cannot be running a C function, a metamethod, or an iterator.
  - Parameters:
    - ...: Any arguments to `yield` are passed as extra results to `resume`.
```

--------------------------------

### Lua C API Functions for State and Stack Management

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Documentation for core Lua C API functions used to define C functions, manage stack space, close Lua states, and concatenate values on the stack. These functions are fundamental for C code interacting with the Lua runtime.

```APIDOC
lua_CFunction
typedef int (*lua_CFunction) (lua_State *L);
  - Type for C functions that interact with Lua.
  - Protocol: Receives arguments from Lua on its stack (first argument at index 1).
  - Returns values by pushing them onto the stack (first result pushed first) and returning the number of results.

lua_checkstack (lua_State *L, int extra)
  - Ensures that there are at least 'extra' free stack slots in the stack.
  - Returns: false if it cannot grow the stack to that size.
  - Behavior: Never shrinks the stack; if already larger, it remains unchanged.

lua_close (lua_State *L)
  - Destroys all objects in the given Lua state (calling corresponding garbage-collection metamethods, if any).
  - Frees all dynamic memory used by this state.
  - Use Case: Important for long-running programs (daemons, web servers) to release resources when states are no longer needed.

lua_concat (lua_State *L, int n)
  - Concatenates the 'n' values at the top of the stack.
  - Pops the 'n' values and leaves the single concatenated result on the top of the stack.
```

--------------------------------

### Lua C API: String Global Substitution (`luaL_gsub`)

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

This function creates a new string by replacing all occurrences of a substring `p` with another substring `r` within an input string `s`. The resulting string is pushed onto the Lua stack.

```APIDOC
const char *luaL_gsub (lua_State *L,
                       const char *s,
                       const char *p,
                       const char *r);
  - Creates a copy of string `s` by replacing any occurrence of the string `p` with the string `r`.
  - Pushes the resulting string on the stack and returns it.
  - Parameters:
    - L: The Lua state.
    - s: The original string.
    - p: The substring to be replaced.
    - r: The replacement string.
  - Returns: A pointer to the new string (also pushed onto the stack).
```

--------------------------------

### Lua Chunk Syntax Definition

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Defines the basic syntax of a Lua chunk, which serves as the unit of execution. A chunk is a sequence of statements, where each statement can be optionally terminated by a semicolon. Chunks are treated as anonymous functions, allowing them to define local variables, receive arguments, and return values.

```Lua
chunk ::= {stat [ ; ]}
```

--------------------------------

### Lua File I/O Operations

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Documentation for standard Lua file object methods, covering reading, seeking, buffering, and writing operations. These functions allow direct interaction with file streams.

```APIDOC
file:read(format)
  - Reads from the file according to the specified format.
  - Parameters:
    - format: The format string to use for reading.
      - "*n": Reads a number; returns a number.
      - "*a": Reads the whole file from the current position; returns empty string on EOF.
      - "*l": Reads the next line (skipping the end of line); returns nil on EOF. This is the default format.
      - number: Reads a string with up to that number of characters; returns nil on EOF. If zero, reads nothing and returns an empty string, or nil on EOF.

file:seek([{whence}] [, {offset}])
  - Sets and gets the file position, measured from the beginning of the file.
  - Parameters:
    - whence: (string, optional) Base for the offset.
      - "set": Base is position 0 (beginning of the file).
      - "cur": Base is current position.
      - "end": Base is end of file.
      - Default: "cur"
    - offset: (number, optional) Offset from the base.
      - Default: 0
  - Returns: The final file position (in bytes from the beginning of the file) on success.
    - If fails, returns nil, plus a string describing the error.
  - Usage Notes:
    - file:seek(): Returns the current file position without changing it.
    - file:seek("set"): Sets the position to the beginning of the file (returns 0).
    - file:seek("end"): Sets the position to the end of the file and returns its size.

file:setvbuf({mode} [, {size}])
  - Sets the buffering mode for an output file.
  - Parameters:
    - mode: (string) The buffering mode.
      - "no": No buffering; output appears immediately.
      - "full": Full buffering; output performed only when buffer is full or explicitly flushed (io.flush()).
      - "line": Line buffering; output buffered until a newline or input from special files.
    - size: (number, optional) The size of the buffer in bytes (for "full" and "line" modes).
      - Default: An appropriate size.

file:write({...})
  - Writes the value of each of its arguments to the file.
  - Parameters:
    - ...: (string | number) Arguments to write. Must be strings or numbers.
      - To write other values, use tostring() or string.format() before write.
```

--------------------------------

### Lua File Handle Methods

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Documentation for methods available on Lua file handles, allowing for specific operations like closing, flushing, reading, and iterating over lines of an opened file.

```APIDOC
file:close()
  - Closes `file`. Note that files are automatically closed when their handles are garbage collected, but that takes an unpredictable amount of time to happen.

file:flush()
  - Saves any written data to `file`.

file:lines()
  - Returns an iterator function that, each time it is called, returns a new line from the file. (Unlike `io.lines`, this function does not close the file when the loop ends.)
  - Returns: An iterator function.

file:read({...})
  - Reads the file `file`, according to the given formats, which specify what to read. For each format, the function returns a string (or a number) with the characters read, or `nil` if it cannot read data with the specified format. When called without formats, it uses a default format.
```

--------------------------------

### pairs Lua Function Reference

Source: https://github.com/neovim/neovim/blob/master/runtime/doc/luaref.txt

Documents the `pairs` function in Lua, which provides an iterator for traversing all key-value pairs of a table.

```APIDOC
pairs({t})
  - Returns three values: the `next()` function, the table {t}, and `nil`.
  - Used to iterate over all key-value pairs of table {t}.
  - Parameters:
    - t: The table to iterate over.
  - Example usage:
    `for k,v in pairs(t) do`
    `  body`
    `end`
```