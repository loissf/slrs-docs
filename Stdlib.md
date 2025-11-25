# Built-in functions and structs

## Implicit

Symbols that are already included by default and do not need the use of `@lib`.

- `function` print
- `function` input
- `function` length
- `function` time
- `function` typeof
- `function` join
- `function` sleep

### print

`function print(any) -> void`

Prints to the standard output the string representation of the value passed as parameter.

### input

`function input() -> string`

Locks and reads the next line from the standard input.

### length

`function length(list or string) -> int`

Returns the length of a given `list` or `string`

### time

`function time() -> int`

Reads and returns the current Unix time minus `1747224000000` as an arbitrary operation to fit the value in the 32 bits of an `int`. This will be fixed in the future with higher than 32 bit integer values.

### typeof

`function typeof(any) -> string`

Returns the name of the type of its parameter as a `string`.

### join

`function join(list) -> string`

Returns the string representation of every value of a list, concatenated together as a `string`.

### sleep

`function sleep(int) -> void`

Puts the current thread to sleep for at least the amount of miliseconds specified as parameter.


## math

`@lib math`

- `function` sqrt
- `function` sin
- `function` cos
- `function` tan
- `function` asin
- `function` acos
- `function` atan
- `function` atan2

They all share the same signature `function <op>(float) -> float`, except `atan2` which takes 2 `float` parameters, and perform the operation they are named after, on 32 bit float values.

## rand

`@lib rand`

- `function` random
- `function` randint
- `function` acorn

### random

`function random() -> float`

A prng that returns the result of appliying the SplitMix algorithm to an internal randomly seeded state. The result is a `float` between `0` and `1`.

### randint

`function random() -> int`

Same algorithm as `random` but without the conversion to a `float` between `0` and `1`, returns values between minimum and maximum `int`.

### acorn

`function acorn() -> float`

Using an internal randomly seeded state, it calculates the next result of the ACORN prng, based on this source <https://acorn.wikramaratna.org/download.html>

## types

- `function` int
- `function` float

### int

`function int(float or int or bool or string) -> int`

Tries to convert from the input type to `int`. In case of `string`, parsing it, in case of `float`, truncating.

### float

`function float(float or int or bool or string) -> float`

Tries to convert from the input type to `float`. In the case of `string`, parsing it.

## error

- `struct` Error

### Error

```
struct Error {
    id: int
    details: string
}
```

This struct represents an error, and its the struct of the value returned in case of a captured error by `call()!`

>
- `function(self)` throw
- `function(self)` name
>
- `function` out_of_memory
- `function` stack_overflow
- `function` stack_underflow
- `function` unknown_instruction
- `function` alloc_error
- `function` dealloc_error
- `function` argument_error
- `function` ilegal_char
- `function` ilegal_operation
- `function` undefined
- `function` type_error
- `function` syntax_error
- `function` io_error

```
@lib error::Error

var err = Error::out_of_memory("Example details")

err.throw()

# error: Out of memory: Example details
```

#### throw

`function throw(instance) -> void`

Creates a run-time error with `id` and `details`.

#### name

`function name(instance) -> string`

Returns the name of the error type as `string`

#### Constructors

All the other methods with an error name, share the signature `<error-name>(string) -> instance`, and return an Error instance of that error type, with `string` details.