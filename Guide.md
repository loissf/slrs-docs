## Keywords

`var`, `and`, `or`, `not`, `true`, `false`, `if`, `while`, `for`, `else`, `function`, `lambda`, `struct`, `null`, `return`, `lib`, `import`, `is`

## Types

Values can be of one of the following types

### Value types

| Type          | Description                                    |
| ------------- | ---------------------------------------------- |
| null          | Missing or uninitialized, value                |
| int           | 32 bit signed integer number                   |
| float         | 32 bit signed floating point number            |
| bool          | `true` or `false`                              |

#### Reference types

| Type          | Description                                    |
| ------------- | ---------------------------------------------- |
| string        | Sequence of 8 bit values representing text     |
| list          | Sequence of any other values                   |
| function      | A function in the program                      |
| struct        | Description of a user-defined data structure   |
| instance      | An occurrence of a struct with its own state   |

#### Type names

Types are specified using the following type names

| Name          | Matches                                        |
| ------------- | ---------------------------------------------- |
| void          | Nothing                                        |
| Null          | `null`                               |
| int           | `int`                                          |
| float         | `float`                                        |
| number        | `int` or `float`                               |
| string        | `string`                                       |
| boolean       | `true` or `false`                              |
| list          | `list`                                         |
| Function      | `function`                                     |
| Struct        | `struct`                                       |
| instance      | `instance`                                     |
| callable      | `function` or `struct`                         |
| any           | All values                                     |

This names can be combined using `or` to match any combination of types, since under the hood, they are bitmasks representing a type with each bit, `void` being all 0 and `any` all 1.

E.g: `var foo: int or Struct or list`

## Literals

### Integer literals

Integer numbers from `-2147483648` to `2147483647`

### Floating-point literals

Floating-point numbers from `-3.4028235e38` to `3.4028235e38`

### Boolean literals

`true` or `false`

### Null literal

`null`

### String literals

Any segment of characters wrapped in double or single quotes `""` `''`.

Escape sequences are:

- `'\` single quote
- `"\` double quote
- `\\` backslash
- `\0` null character
- `\n` new line
- `\r` carriage return
- `\t` tab

### List literals

A sequence of comma separated values, wrapped in square brackets `[` `]`

`[1, 2, "Foo", true, "Bar", false]`

Any variables used in list literals will be initially set to `null` and correctly assigned at runtime before the first use of the list

## Variables

To declare a variable, the keyword `var` is used:

`var <identifier> (: <type>)? (= <value>)?`

If `<type>` is not specified, the variable will be of type `any`

If `<value>` is not specified, the variable will have a default value depending of its type

### Default values

| Type          | Value |
| ------------- | ----- |
| null          | null  |
| int           | 0     |
| float         | 0.0   |
| bool          | false |
| string        | ""    |
| list          | [ ]   |
| function      | null  |
| struct        | null  |
| instance      | null  |

Any union of types (e.g `int or float`) will have `null` as its default value

```
var foo                         # foo = null
var bar: int                    # bar = 0
var baz: float = 1.3            # baz = 1.3
var qux: int or float           # qux = null
```

```
var foo: int                    # error, assigned 'null' to 'int'
var bar: int or float = "bar"   # error, assigned 'string' to 'int or float'
```

## Operators

### Order of operations

From first to last, the order of operations for the binary operators is:

`%`   ,
`/`   ,
`*`   ,
`-`   ,
`+`   ,
`<=`  ,
`<`   ,
`>=`  ,
`>`   ,
`!=`  ,
`==`  ,
`and` ,
`or`

### Arithmetic operators

- Unary: `plus +`, `minus -`, `increment ++`, `decrement --`
- Binary: `multiplication *`, `division /`, `modulo %`, `addition +`, `subtraction -`

Any numerical operation between an `int` and a `float` will coerce both to `float`

#### Subtraction and division

Subtraction and division can only be performed on numerical (`int`, `float`) types.

#### Increment and decrement

Increment and decrement are postfix only operators that increase or decrease the value of its operand by one.

#### Addition

Apart from the numeric multiplication, `string` and `list` operands can be added with any type of operand, in which case, the other operand is coerced, if not of the same type, and both are concatenated.

```
var foo = "Foo" + 5             # foo = "Foo5"
var bar = 5 + [1, 2, 3]         # bar = [5, 1, 2, 3]
var baz = [1, 2] + [3, 4]       # baz = [1, 2, 3, 4]
```

#### Multiplication

Apart from the numeric multiplication, `string` and `list` operands can be multiplied by an `int` operand.

```
var foo = "Foo" * 3             # foo = "FooFooFoo"
var bar = 2 * [1, 2, 3]         # bar = [1, 2, 3, 1, 2, 3]
```

### Logic operators

- Unary: `not`
- Binary: `and`, `or`

Logic operations can only be performed on `bool` types.

### Comparison operators

`greater >`, `greater or equal >=`, `lower <`, `lower or equal <=`

Comparison operations can only performed on numerical (`int`, `float`) and `bool` types, otherwise, the result is always `false`

### Equality operators

`equal ==`, `not equal !=`

Equality operations between an `int` and a `float` will coerce both to `float`.

`function` and `instance` reference types result in `true` if the references are the same.

### Type operators

- Type check:  `is`
- Type assert: `as`

#### Type check

The operation `<expression> is <type>` checks the left operand against the right operand and returns a `bool` as result.

If the right operand is a type name or combination of type names, returns `true` if the left operand type matches the right operand, `false` otherwise.

```
var foo = 20
foo is int          # true
foo is float        # false
```

If the right operand is a `struct`, the operation returns `true` if the left operand is `instance` and its `struct` equal to the right operand. 

```
struct Foo {}
var foo = Foo()
foo is Foo          # true
```

#### Type assert

The operation `<expression> as <type>` does the same as a type check, but without returning a value. Instead creates a run-time error for the cases where a type check would return `false`.

From this operation onwards, compile-time type checking will assume the left operand is of the specified type

### Postfix operators

#### Field access

`<lvalue>.<identifier>`

Only an `instance` is a valid left value for this operation. If the `instance` has a field with that name, the field value is returned, otherwise, an error is created.

#### List access

`<lvalue>[<expression>]`

Only `list` or `string` are valid left values for this operation. The operation returns the `<expression>`-th element. In case of `string`, the result is another `string` of length 1.

#### Assignment

`<postfix> = <expression>`

Field access and list access can both be the left operand of an assignment operator `=`, with the excetion of the `string` type, that is inmutable. ( For a lack of `char` type *WIP* )

```
var foo = [1, 2, 3]
foo[0] = 50             # foo = [50, 1, 2]
```

#### Call operator

`<value>( ( <expression> ,)* )`

If the value is `function` it will execute it with the given parameters, and return the result, if any.

```
function Foo(a, b) {
    return b
}

var foo = Foo(1, 2)     # foo = 2
```

If the value is `struct`, parameters are not allowed. The result will be an `instance` of the struct.

```
struct Foo {
    a: 20
}

var foo = Foo()         # foo = <struct Foo>
print(foo.a)            # 20
```

Calling any other type creates an error.

##### Catch

Using the bang `!` symbol at the end of a call causes the stack frame it creates to capture any error that happens during the call, returning it as a value of type `<instance Error>`, an instance of the built-in struct `Error`.

```
var foo = Foo()!
```

### Ternary operation

`<left-expression> if <expression> else <right-expression>`

If `<expression>` is `true`, the operation evaluates to `<left-expression>`, if `false`, evaluates to `<righ-expression>`

```
var foo = 20 if true else 50        # foo = 20
```

## Statements

### If

`if <expression> { <statements> } ( else { <statements> } )?`

```
if (20 + 5) < 10 {
    print("Foo")
} else {
    print("Bar")
}
```

### For

`for <identifier> , <expression> { <statements> }`

The `for` statement will execute its `<statements>` in a loop, `<expression>` number of times, coerced to `int`. The number of the iteration, starting at `0` and ending at `<expression> - 1` is stored in a variable `<identifier>`, in scope only inside the loop.

```
for i, 2000 {
    print(i)
}
```

### While

`while <expression> { <statements> }`

```
var i = 0
while i < 2000 {
    print(i)
    i++
}
```

### Return

`return <expression>?`

The `return` statement breaks out of the current function, taking `<expression>` as its result, or `null` if there is none.

## Function declaration

`function <identifier> ( (<identifier> (: <type>)?  ,)* ) { <statements> }`

Functions execute its inner statements in their own scope, meaning they have no access to outside variables.

Function parameters can optionally be typed just as variable declarations. Typed parameters are required to be of the specified type when calling a function, creating a run-time error otherwise. Parameters without type are considered `any`.

A function return type is calculated as the union of the types of all its return statements, if the result is `void` (all empty returns), the function will return `null`, but as `void` type, trying to use the value will cause an error at compile- run-time time.

```
function Foo(a, b: int, c: float) {
    if b < c {
        return b    # int
    } else {
        return c    # float
    }
    print(a) # unreachable statement
}
# function return type is considered int or float
```

## Struct declaration

```
struct <identifier> {
    ( <identifier>(: <type>)? (= <const expression>)? )*
    ( <function declaration> )*
}
```

Structs can contain only fields and functions. Fields are almost like variables, but can only be defined with constant values.

Functions declared in a struct are just normal functions, namespaced inside the struct name, and can be called statically `Foo::Bar()` or from an instance `foo.Bar()`.

When a function member of a struct is called from an instance, the instance is automatically passed to the function as the first parameter. This parameter can have any name, even if all the examples use `self` as convention.

Fields of the instance of a struct can be accessed using `.`, while the namespace of the struct is accessed using `::`

```
struct Foo {
    bar = 20
    baz = [1, 2, 3]

    function Bar() {}

    function Baz(self) {}
}

Foo::Bar()

var foo = Foo()
foo.Baz()
```

### Namespaces

`<identifier>(::<identifier>)*`

Namespaces only exist at compile-time, they are used in structs and imports to group their symbols under their name.

```
Foo::Bar            # Symbol Bar in namespace Foo
Foo::Bar::Baz       # Symbol Baz in namespace Foo::Bar
```

Currently namespaces do not support assignment

## File structure

```
( <import directive> <eol> )*

( <statement> )*
```

Each file is a module, each module contains any number of namespaces. Anything on a file that is used without a namespace is considered in the root namespace.

Statements are closed at their closing brackets `}`, or semicolon `;`, in case of expressions and variable declarations.

The semicolon is optional if its followed by an end of line `eol`.

Before execution, functions and structs are analyzed first, so using them before their declarations is valid.

## Import directives

`@lib <path | identifier>(::<identifier>)* (as <identifier>)?`

`@import <path | identifier>(::<identifier>)* (as <identifier>)?`

For each file, any import directive has to be at the top, before any other statement, since they are only used at compile-time, to collect all files and symbols that are needed for the program.

Imports are analyzed, top to bottom, depth-first. Each file is only executed once even if its imported multiple times or through a circular chain.

By default, imports create a namespace to place imported symbols at, but specific symbols can be selected insead using `namespace access` syntax.

The keyword `as` can be used to rename the imported namespace or symbol.

### @import

The `@import` directive looks for a script file in `<path>` or a file named `<identifier>` in the current path, includes it in the program and gives access to any function or struct defined inside of it to the current file. By default, the file name is used as the namespace to place those symbols in.

### @lib

The `@lib` directive is used for importing native code. If an identifier is used, the built-in modules are searched first, then, a dynamic library named `<identifier>` in the current path.
If a path was used instead, the import will look for a dynamic library at that path directly.
