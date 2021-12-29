import Cocoa

let input = 702831

//print(input)

extension Int {
    func digits() -> [Int] {
        String(self).map { Int(String($0))! }
    }
}

func partOne() -> String {
    var a: Int = 0
    var b: Int = 1

    var r: [Int] = [3,7,1,0]

    var result: [Int] = []

    while true {
        let n = r[a] + r[b]
        r.append(contentsOf: n.digits())

        let x = r[a] + 1
        let y = r[b] + 1

        if a+x >= r.count {
            a =  (a + x) % r.count
        }
        else {
            a += x
        }

        if b+y >= r.count {
            b = (b + y) % r.count
        }
        else {
            b += y
        }

        if r.count == input + 10 + 1 {
            result = Array(r[input ..< r.count-1])
            break
        }
    }

    return result.map { String($0) }.joined()
}

func partTwo() -> String {
    var a: Int = 0
    var b: Int = 1

    var r: [Int] = [3,7,1,0]

    var count = -1

    var buffer: [Int] = Array.init(repeating: 0, count: input.digits().count)

    while true {
        let n = r[a] + r[b]
        r.append(contentsOf: n.digits())

        let x = r[a] + 1
        let y = r[b] + 1

        if a+x >= r.count {
            a =  (a + x) % r.count
        }
        else {
            a += x
        }

        if b+y >= r.count {
            b = (b + y) % r.count
        }
        else {
            b += y
        }

        var canBreak = false
        for d in n.digits() {
            buffer.append(d)
            buffer.removeFirst()
            if buffer == input.digits() {
                canBreak = true
                break
            }
            count += 1
        }

        if canBreak {
            break
        }
    }

    return count.description
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
