import Cocoa

//let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

let input = """
[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
""".components(separatedBy: .newlines)

extension Character {
    func isNumber() -> Bool {
        Int(String(self)) != nil
    }

    func toNumber() -> Int {
        Int(String(self))!
    }
}

extension Int {
    func toCharacter() -> Character {
        Character(String(self))
    }
}

extension String{

    func isNumber() -> Bool {
        Int(self) != nil
    }

    func toNumber() -> Int {
        Int(self)!
    }

    subscript(_ i: Int) -> Character! {
        get {
            let idx = index(startIndex, offsetBy: i)
            return self[idx]
        }
        set {
            let idx = index(startIndex, offsetBy: i)
            remove(at: idx)
            if let new = newValue {
                insert(new, at: idx)
            }
        }
    }
}


class SnailFishCalculator {

    struct Line: CustomStringConvertible {

        let input: [String]

        init(_ input: [String]) {
            self.input = input
        }

        init(_ line: String) {
            var parts: [String] = []
            var i = 0
            while i < line.count {
                let char = line[line.index(line.startIndex, offsetBy: i)]
                if ["[","]",","," "].contains(char) {
                    if char != "," {
                        parts.append(String(char))
                    }
                    i += 1
                }
                else {
                    var j = i
                    while j < line.count {
                        let c2 = line[line.index(line.startIndex, offsetBy: j)]
                        if c2.isNumber {
                           j += 1
                        }
                        else {
                            break
                        }
//                        if [",","[","]"," "].contains(c2) {
//                            break
//                        }
//                        j += 1
                    }
                    let s = line.index(line.startIndex, offsetBy: i)
                    let e = line.index(line.startIndex, offsetBy: j)
                    let number = line[s ..< e]
                    parts.append(String(number))
                    i = j
                }
            }
            self.input = parts
        }

        var description: String {
            input.joined(separator: " ")
        }

        func magnitude() -> Int {
            var input = input

            func solve() {
                var i = 0
                var value = 0
                //[[1,2],[[3,4],5]]
                var stack: [String] = []
                while i < input.count {
                    let char = input[i]
                    stack.append(char)

                    if char == "]" {
                        let pair = stack[stack.count - 3 ..< stack.count].map { $0 }
                        let first = pair[0]
                        let second = pair[1]
                        if first.isNumber() && second.isNumber() {
                            value = first.toNumber() * 3 + second.toNumber() * 2
                            stack = stack.dropLast(4)
                            stack.append(String(value))
                            input = stack + input[i+1 ..< input.count]
                            break
                        }
                    }
                    i += 1
                }
            }

            var stop = false
            while input.count > 1 {
                let c = input.count
                solve()
                if c == input.count {
                    stop = true
                    break
                }
            }

            return stop ? 0 : input[0].toNumber()
        }

        func merge(_ line: Line) -> Line {
            var left = self.input
            let right = line.input

            left.insert("[", at: 0)
            left.append(contentsOf: right)
            left.append("]")

            return Line.init(left)
        }

        func explode() -> (Bool, Line) {
            var success = false
            var parts: [String] = []

            var stack: [String] = []
            // [[[[[9,8],1],2],3],4]
            // [[[[0,9],2],3],4]
            for (i, char) in input.enumerated() {
                if char == "[" {
                    stack.append(char)
                }
                if char == "]" {
                    _ = stack.popLast()
                }

                parts.append(char)
                if stack.count > 4 {
                    if !input[i+1].isNumber() || !input[i+2].isNumber() {
                        continue
                    }
                    parts.removeLast()
                    let currentPair = (input[i+1].toNumber(),input[i+2].toNumber())
                    var newPair = (-1,-1)
                    if let leftIndex = parts.lastIndex(where: { $0.isNumber() }) {
                        let left = parts[leftIndex]
                        newPair.0 = currentPair.0 + left.toNumber()
                        // [[[[0,7],4],[7,[[8,4],9]]],[1,1]]
                        // [[[[0,7],4],[7,[[
                        var partsL = parts[parts.startIndex ..< leftIndex]
                        let partsR = parts[parts.index(after: leftIndex) ..< parts.endIndex]
                        partsL.append("\(newPair.0)")
                        partsL.append(contentsOf: partsR)
                        parts = Array(partsL)
                    }
                    else {
                        parts.append("0")
                    }

                    let rem = input[input.index(after: i+3)..<input.endIndex]
                    var next: [String] = Array(rem)
                    if let rightIndex = rem.firstIndex(where: { $0.isNumber() }) {
                        let right = input[rightIndex]
                        newPair.1 = currentPair.1 + right.toNumber()

                        let remR = rem[rem.index(after: rightIndex) ..< rem.endIndex]
                        var remL = rem[rem.startIndex ..< rightIndex]
                        remL.append("\(newPair.1)")
                        remL.append(contentsOf: remR)
                        next = Array(remL)

                    }
                    else {
                        next.insert("0", at: next.startIndex)
                        if parts.last == "[" && next[1] == "]" {
                            next.insert("0", at: next.startIndex)
                        }
                    }


                    if newPair.0 != -1, newPair.1 != -1 {
                        next.insert("0", at: next.startIndex)
                    }

                    parts += next
                    success = true
                    break
                }
            }

            return (success, Line.init(parts))
        }

        func _split() -> (Bool,Line) {
            var success = false
            var parts: [String] = []
            // [[[[0,7],4],[15,[0,13]]],[1,1]]
            // [[[[0,7],4],[[7,8],[0,13]]],[1,1]]
            var stack: [String] = []
            for (i,part) in input.enumerated() {
                if part == "[" {
                    stack.append(part)
                }
                if part == "]" {
                    _ = stack.popLast()
                }

                if part.isNumber() {
                    if part.toNumber() >= 10 {
                        let double = Double(part.toNumber()) / 2.0
                        let left = String(Int(double.rounded(.down)))
                        let right = String(Int(double.rounded(.up)))
                        parts.append("[")
                        parts.append(left)
                        parts.append(right)
                        parts.append("]")

                        let next = input[input.index(input.startIndex, offsetBy: i+1)..<input.endIndex]
                        parts += next
                        success = true
                        break
                    }
                }
                parts.append(part)
            }
            return (success, Line.init(parts))
        }
    }

    let input: [Line]

    init(_ input: [String]) {
        self.input = input.map { Line.init($0) }
    }

    func largeMagnitudeSum() -> Int {
        var mag: [Int] = []
        for i in input {
            for j in input {
                if i.input != j.input {
                    let line = add(i, j)
                    mag.append(line.magnitude())
                }
            }
        }
        return mag.max()!
    }


    func sum() -> Line {
        var left = input[0]
        var index = 1
        while index < input.count {
            let right = input[index]
            let result = add(left, right)
            left = result
            index += 1
        }
        return left
    }

    func add(_ left: Line, _ right: Line) -> Line {
        let line = left.merge(right)
        return _reduce(line)
    }

    func _reduce(_ line: Line) -> Line {
        var line = line

        while true {
            let ex = line.explode()
            if ex.0 {
                line = ex.1
                continue
            }

            let sp = line._split()
            if sp.0 {
                line = sp.1
            }

            if !sp.0 {
                break
            }
        }
        return line
    }
}

func partOne() -> Int {
    let calc = SnailFishCalculator.init(input)
    let line = calc.sum()
    return line.magnitude()
}

func partTwo() -> Int {
    let calc = SnailFishCalculator.init(input)
    return calc.largeMagnitudeSum()
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput) -> String {
    switch input {
    case .input:
        return load(file: "input")
    default:
        return load(file: "test_input")
    }
}

func load(file name: String) -> String {
    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}
