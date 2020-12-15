import Cocoa

let input = """
5,2,8,16,18,0,1
""".components(separatedBy: ",").map { Int($0)! }

print(input)

func partOne() -> Int {
    var index = 0
    var spoken : [Int: Int] = [:]
    var last = Int.min
    var new = true
    while index < 2020 {
        if index < input.count {
            spoken[index+1] = input[index]
            last = input[index]
        }
        else {
            var result: Int? = nil
            if new {
                result = 0
            }
            else {
                let sorted = spoken.filter { $0.value == last}.sorted { (d1, d2) -> Bool in
                    return d1.key > d2.key
                }

                result = sorted[0].key - sorted[1].key

                result = result == 0 ? 1 : result
            }

            new = spoken.filter { $0.value == result }.count == 0
            spoken[index+1] = result
            last = result!
        }
        index += 1
    }

    return spoken[2020] ?? -1
}

func partTwo() -> Int {
    var inputs = input
    var last: [Int: Int] = [:]
    for (i,n) in inputs.enumerated() {
        if i != inputs.count-1 {
            last[n] = i
        }
    }

    while inputs.count < 30_000_000 {
        var next: Int
        let prev = inputs.last!
        let pprev = last[prev, default: -1]
        last[prev] = inputs.count-1
        if pprev == -1 {
            next = 0
        }
        else {
            next = inputs.count - 1 - pprev
        }
        inputs.append(next)
    }

    return inputs.last!
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
