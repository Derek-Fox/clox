# clox

`clox` is a bytecode virtual machine interpreter for the **Lox** programming language, written in C. It is built following the second half of Bob Nystrom's [_Crafting Interpreters_](https://craftinginterpreters.com/).

Lox is a small, dynamic language with:

- Variables, blocks, control flow (`if`/`else`, `while`, `for`)
- Functions and closures (with upvalues)
- Classes, methods, fields, and `this`/`super`
- Inheritance (`<`) and subclassing
- Automatic garbage collection
- A built-in `clock()` native function

## Installation

- Copy the code using `git clone https://github.com/Derek-Fox/clox.git`.
- Proceed to Build instructions.

## Build

Requirements: `gcc` (C99), `make`.

```sh
make
```

This produces the `./clox` binary. Clean build artifacts with:

```sh
make clean
```

## Run

Launch the interactive REPL:

```sh
./clox
```

Run a Lox source file:

```sh
./clox path/to/script.lox
```

Exit codes: `65` on compile error, `70` on runtime error, `64` on usage error.

## Project structure

```
clox/
├── Makefile
├── test.lox
└── src/
    ├── chunk.c/h        # bytecode chunks and disassembly
    ├── common.h         # debug macros and shared constants
    ├── compiler.c/h     # single-pass compiler
    ├── debug.c/h        # opcode disassembler
    ├── main.c           # entry point, REPL, file runner
    ├── memory.c/h       # memory management / allocation helpers
    ├── object.c/h       # runtime object types (strings, functions, closures, classes, instances, upvalues)
    ├── scanner.c/h      # lexical scanner
    ├── table.c/h        # hash tables
    ├── value.c/h        # tagged values
    └── vm.c/h           # interpreter / virtual machine
```

## Language examples

A brief tour of Lox syntax as supported by `clox`:

### Values and operators

```lox
print 1 + 2 * 3;          // => 7
print (1 + 2) * 3;        // => 9
print 1 + 2 > 3;          // => false
print "hello " + "world"; // => hello world
print !true;              // => false
print nil;                // => nil
```

### Variables and scopes

```lox
var x = 10;
var y = 20;
{
  var x = 0;     // shadowing in a new block scope
  print x + y;   // => 20
}
print x;           // => 10
```

### Control flow

```lox
var i = 0;
while (i < 5) {
  print i;
  i = i + 1;
}

for (var j = 0; j < 3; j = j + 1) {
  print j;
}

if (i == 5) {
  print "five";
} else {
  print "not five";
}

var a = 1;
var b = 2;
print a or b;   // short-circuit or => 1
print a and b;  // short-circuit and => 2
```

### Functions and closures

```lox
fun fib(n) {
  if (n <= 1) return n;
  return fib(n - 1) + fib(n - 2);
}
print fib(10);     // => 55

fun makeCounter() {
  var i = 0;
  fun count() {
    i = i + 1;
    return i;
  }
  return count;    // closure captures `i`
}
var counter = makeCounter();
print counter();   // => 1
print counter();   // => 2
```

### Classes, methods, and inheritance

```lox
class Animal {
  init(name) {
    this.name = name;
  }
  speak() {
    print this.name + " makes a sound.";
  }
}

class Dog < Animal {
  speak() {
    super.speak();
    print this.name + " barks!";
  }
}

var d = Dog("Rex");
d.speak();
```

### print statement

```lox
print "Hello, Lox!";   // top-level statement form
```

## Debug

Debug builds set macros such as `DEBUG_PRINT_CODE`, `DEBUG_TRACE_EXECUTION`, `DEBUG_STRESS_GC`, and `DEBUG_LOG_GC` (see `src/common.h`). Adjust them there to change the verbosity of the build.

## License

This project is released under the [MIT License](LICENSE).
