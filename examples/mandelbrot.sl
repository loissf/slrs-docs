@lib types

var resolution = 100

var x0 = -2.1
var x1 = 0.47

var y0 = -1.12
var y1 = 1.12

var maxIt = 50

var x
var y
var x_i
var y_i
var temp

var i

var gray = " .:-=+*#%@"

for py, resolution {
    var out = ""
    for px, resolution {
        x = types::float(px) / types::float(resolution - 1) * (x1 - x0) + x0
        y = types::float(py) / types::float(resolution - 1) * (y1 - y0) + y0
        x_i = 0.0
        y_i = 0.0
        i = 0
        while x_i * x_i + y_i * y_i <= 4.0 and i < maxIt {
            temp = x_i * x_i - y_i * y_i + x
            y_i = 2.0 * x_i * y_i + y
            x_i = temp
            i = i + 1
        }
        if i == maxIt {
            i = 0
        }
        out = out + gray[i * 10 / maxIt]
    }

    print(out)
}