import Cocoa

let input = """
17115212
3667832
""".components(separatedBy: .newlines).map { Int($0)! }

print(input)

func partOne() -> Int {
    let a = input[0]
    let b = input[1]

    var i = 1
    var c1 = 0
    while i != a {
        i *= 7
        i %= 20201227
        c1 += 1
    }

    var e1 = 1
    for _ in (1...c1) {
        e1 *= b
        e1 %= 20201227
    }

    return e1
}

print("Part One answer is: \(partOne())")

