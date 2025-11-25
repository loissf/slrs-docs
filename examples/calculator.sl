@lib types
@lib error

function parse_args(str: string) {
    var args = []
    var arg = ""
    for i, length(str) {
        var char = str[i]
        if char != " " {
            arg = arg + char
        } else {
            args = args + [""]
            args[length(args) - 1] = arg
            arg = ""
        }
    }
    args = args + [""]
    args[length(args) - 1] = arg
    arg = ""
    return args
}

function calculate(a, b, op) {
    if op == "+" { return (a + b) }
    if op == "-" { return (a - b) }
    if op == "*" { return (a * b) }
    if op == "/" { return (a / b) }
    if op == "%" { return (a % b) }
}

while true {
    var args = parse_args(input())

    if length(args) == 3 {
        var a = types::float(args[0])
        var b = types::float(args[2])
        var op = args[1]

        var res = calculate(a, b, op)!

        if res is error::Error {
            print(res.name())
        } else {
            print(res)
        }
    } else {
        print("Invalid operation")
    }
}