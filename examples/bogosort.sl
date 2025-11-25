@lib rand
@lib types

function bogosort(l: list) {
    var len = length(l)
    for i, len {
        var swap = types::int(rand::random() * (len - 1))
        var aux = l[swap]
        l[swap] = l[i]
        l[i] = aux
    }
}

function check(l: list) {
    for i, (length(l) - 1) {
        if l[i] > l[i + 1] {
            return false
        }
    }
    return true
}

var unordered = [0.0] * 10

for i, length(unordered) {
    unordered[i] = types::int(rand::random() * 100)
}

var iters = 0
print(unordered)

var start = time()

while not check(unordered) {
    iters++
    bogosort(unordered)
}

print("Ordered in " + (time() - start) + "ms" + " after " + iters + " tries")
print(unordered)