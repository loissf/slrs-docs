@lib rand::randint

var c_ = ["     ","     ","     ","     ","     "]
var c0 = ["#####","#   #","#   #","#   #","#####"]
var c1 = ["  #","  #","  #","  #","  #"]
var c2 = ["#### ","    #"," ### ","#    ","#####"]
var c3 = ["#### ","    #","#### ","    #","#### "]
var c4 = ["#   #","#   #","#####","    #","    #"]
var c5 = [" ####","#    ","#### ","    #","#### "]
var c6 = [" ### ","#    ","#### ","#   #","#### "]
var c7 = ["#####","    #","   # ","  #  "," #   "]
var c8 = [" ### ","#   #"," ### ","#   #"," ### "]
var c9 = [" ####","#   #"," ####","    #","   # "]

var nums = [c0, c1, c2, c3, c4, c5, c6, c7, c8, c9]

function print_n(n: list) {
    for i, length(n) {
        print(n[i])
    }
}

function digits(number: int) {
    var digits = []
    var n = number + 0
    var len = length(n + "")
    for i, len {
        digits = (n % 10) + digits
        n = n / 10
    }

    return digits
}

function print_number(number: int, nums: list) {
    var digits = digits(number)

    var empty = nums[0]

    for i, length(empty) {
        var line = ""
        for j, length(digits) {
            var digit = digits[j]
            var n = nums[digit]
            line = line + n[i] + "   "
        }
        print(line)
    }
}

for i, 200000 {
    print_number(i * 1000, nums)
    print("")
    sleep(80)
    print("\n" * 15)
}