function compt_pi(n: int) {
    var k = 1
    var s = 0
    var sign = 1
    for i, n {
        s = s + ( sign * (4.0/k) )
        sign = sign * -1
        k = k + 2
    }
    return s
}

var start = time()

print(compt_pi(1000000))

var end = time()
print((end - start) + "ms")