import Cocoa

//let input = load(.input).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)


//[[[[[9,8],1],2],3],4]
//[7,[6,[5,[4,[3,2]]]]]
//[[6,[5,[4,[3,2]]]],1]
//[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]
//[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]
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

print(input)

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
            print(input)
        }

        var description: String {
            input.joined(separator: " ")
        }

        func magnitude() -> Int {
            var input = input

            func solve() -> Int {
                var i = 0
                var value = 0
                //[[1,2],[[3,4],5]]
                while i < input.count - 1 {
                    let first = input[i]
                    let second = input[i+1]
                    if first.isNumber() && second.isNumber() {
                        print(first,second)
                        value = first.toNumber() * 3 + second.toNumber() * 2
                        break
                    }
                    i += 1
                }
                input.replaceSubrange(i-1 ..< i+3, with: [String(value)])
                print(input)
                return value
            }

            var result = 0
            while input.count > 1 {
                result = solve()
            }

            return result
        }

        func merge(_ line: Line) -> Line {
            var left = self.input
            let right = line.input

            left.insert("[", at: 0)
            left.append(contentsOf: right)
            left.append("]")

            print("Added :\(left.joined())")

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
                    stack.popLast()
                }

                parts.append(char)
                if stack.count > 4 {
//                    print(stack)
//                    print("found")
//                    print(parts)
                    //[11,3] or [9,0]
                    // ex 0,7
                    // [ [ [ [ 13 7 ] [ 14 12 ] ] [ [ 10 0 ] 15 ] ] [ 10 [ [ 0 21 ] [ [ 0 7 ] ] ] ] ]

                    print(input[i+1],input[i+2])
                    if !input[i+1].isNumber() || !input[i+2].isNumber() {
                        continue
                    }
                    parts.removeLast()
                    let currentPair = (input[i+1].toNumber(),input[i+2].toNumber())
                    print(currentPair)
                    var newPair = (0,0)
                    if let leftIndex = parts.lastIndex(where: { $0.isNumber() }) {
                        let left = parts[leftIndex]
                        newPair.0 = currentPair.0 + left.toNumber()
                        // [[[[0,7],4],[7,[[8,4],9]]],[1,1]]
                        // [[[[0,7],4],[7,[[
                        var partsL = parts[parts.startIndex ..< leftIndex]
                        let partsR = parts[parts.index(after: leftIndex) ..< parts.endIndex]
//                        print(partsL)
//                        print(partsR)
                        partsL.append("\(newPair.0)")
                        partsL.append(contentsOf: partsR)
//                        print(partsL)
                        parts = Array(partsL)
    //                    parts.insert(contentsOf: "\(newPair.0)", at: leftIndex)
//                        print(parts)
    //                    parts.insert(newPair.0.toCharacter(), at: leftIndex)
    //                    parts.remove(at: parts.index(after: leftIndex))
                    }
                    else {
                        parts.append("0")
                    }

                    var rem = input[input.index(after: i+3)..<input.endIndex]
//                    print(rem)
                    var next: [String] = Array(rem)
                    if let rightIndex = rem.firstIndex(where: { $0.isNumber() }) {
                        let right = input[rightIndex]
                        newPair.1 = currentPair.1 + right.toNumber()

//                        print("rem: \(rem)")
                        var remR = rem[rem.index(after: rightIndex) ..< rem.endIndex]
                        var remL = rem[rem.startIndex ..< rightIndex]
                        remL.append("\(newPair.1)")
                        remL.append(contentsOf: remR)
//                        print(remL)
                        next = Array(remL)

//                        rem.insert(contentsOf: "\(newPair.1)", at: rightIndex)
                        //rem.insert(newPair.1.toCharacter(), at: rightIndex)
//                        rem.remove(at: line.index(after: rightIndex))
                    }
                    else {
                        next.insert("0", at: next.startIndex)
                        if parts.last == "[" && next[1] == "]" {
                            next.insert("0", at: next.startIndex)
                        }
                    }


                    if newPair.0 != 0, newPair.1 != 0 {
                        next.insert("0", at: next.startIndex)
                    }

//                    print(newPair)
//                    print(next)

                    parts += next
//                    print("parts :\(parts.joined(separator: " "))")
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
                    stack.popLast()
                }

                if part.isNumber() {
                    if part.toNumber() >= 10 {
                        let double = Double(part.toNumber()) / 2.0
                        let left = String(Int(double.rounded(.down)))
                        let right = String(Int(double.rounded(.up)))
                        print(left,right)
                        //parts.removeLast()
                        parts.append("[")
                        parts.append(left)
                        parts.append(right)
                        parts.append("]")

                        let next = input[input.index(input.startIndex, offsetBy: i+1)..<input.endIndex]
                        parts += next
                        print(parts.joined(separator: " "))
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

    func sum() -> Line {
        var left = input[0]
        var index = 1
        while index < input.count {
            let right = input[index]
            let result = add(left, right)
            left = result
            index += 1
        }
//        print("SUM: \(left)")
//        return left
        return left
    }

    func add(_ left: Line, _ right: Line) -> Line {
        let line = left.merge(right)
        print(line)
        return _reduce(line)
    }

    func _reduce(_ line: Line) -> Line {
        var line = line

        while true {
            let ex = line.explode()
            print("Try Exploding")
            print(line)
            print(ex.1)
            if ex.0 {
                line = ex.1
                continue
            }

            let sp = line._split()
            print("Try Splitting")
            print(line)
            print(sp.1)
            if sp.0 {
                line = sp.1
            }

            if !sp.0 {
                break
            }
        }
        print(line)
        return line
    }

    func add(_ left: String, _ right: String) -> String {
        var new: String = "[\(left)"
        new.insert(contentsOf: ",\(right)]", at: new.endIndex)
        print(new)
        return tryReduce(new)
    }

    func tryReduce(_ line: String) -> String {
        var line = line

        while true {
            let exploded = tryExplode(line)
            print("Try Exploding")
            print(line)
            print(exploded)
            if exploded.0 {
                line = exploded.1
            }

            let splitted = trySplit(line)
            print("Try Splitting")
            print(line)
            print(splitted)
            if splitted.0 {
                line = splitted.1
            }

            if !exploded.0 && !splitted.0 {
                break
            }
        }
        print(line)
        return line
    }

    func trySplit(_ line: String) -> (Bool,String) {
        var parts: String = ""
        var splited: Bool = false
        // [[[[0,7],4],[15,[0,13]]],[1,1]]
        // [[[[0,7],4],[[7,8],[0,13]]],[1,1]]
        var stack: [Character] = []
        for (i,char) in line.enumerated() {
            if char == "[" {
                stack.append(char)
            }
            if char == "]" {
                stack.popLast()
            }

            if char.isNumber() {
                if let last = parts.last, last.isNumber {
                    let cur = "\(last)\(char)"
                    print(cur)
                    if cur.toNumber() >= 10 {
                        let double = Double(cur.toNumber()) / 2.0
                        let left = Int(double.rounded(.down))
                        let right = Int(double.rounded(.up))
                        print(left,right)
                        parts.removeLast()
                        parts.append(contentsOf: "[\(left),\(right)]")

                        let next = line[line.index(line.startIndex, offsetBy: i+1)..<line.endIndex]
                        parts += next
                        print(parts)
                        splited = true
                        break
                    }
                }
            }
            parts.append(char)
        }
        return (splited,parts)
    }

    func tryExplode(_ line: String) -> (Bool,String) {
        print(line)
        var parts: String = ""
        var stack: [Character] = []
        var exploded: Bool = false
        // [[[[[9,8],1],2],3],4]
        // [[[[0,9],2],3],4]
        for (i, char) in line.enumerated() {
            if char == "[" {
                stack.append(char)
            }
            if char == "]" {
                stack.popLast()
            }

            parts.append(char)
            if stack.count > 4 {
                print(stack)
                print("found")
                print(parts)
                parts.removeLast()

                //[11,3] or [9,0]
                let s = line.index(line.startIndex, offsetBy: i+1)
                let e = line[s ..< line.endIndex].firstIndex(where: { $0 == "]" })!
                var check = line[s..<e].components(separatedBy: ",").map { Int($0)! }
                print(check)
                let currentPair = (check.first!, check.last!)
//                let currentPair = (line[i+1].toNumber(),line[i+3].toNumber())
                print(currentPair)
                var newPair = (0,0)
                if let leftIndex = parts.lastIndex(where: { $0.isNumber }) {
                    let left = parts[leftIndex]
                    newPair.0 = currentPair.0 + left.toNumber()
                    // [[[[0,7],4],[7,[[8,4],9]]],[1,1]]
                    // [[[[0,7],4],[7,[[
                    var partsL = parts[parts.startIndex ..< leftIndex]
                    let partsR = parts[parts.index(after: leftIndex) ..< parts.endIndex]
                    print(partsL)
                    print(partsR)
                    partsL.append(contentsOf: "\(newPair.0)")
                    partsL.append(contentsOf: partsR)
                    print(partsL)
                    parts = String(partsL)
//                    parts.insert(contentsOf: "\(newPair.0)", at: leftIndex)
                    print(parts)
//                    parts.insert(newPair.0.toCharacter(), at: leftIndex)
//                    parts.remove(at: parts.index(after: leftIndex))
                }
                else {
                    parts.append("0")
                }
                var rem = line[line.index(after: e)..<line.endIndex]
                print(rem)
                var next: Substring = rem
                if let rightIndex = rem.firstIndex(where: { $0.isNumber }) {
                    let right = line[rightIndex]
                    newPair.1 = currentPair.1 + right.toNumber()

                    print("rem: \(rem)")
                    var remR = rem[rem.index(after: rightIndex) ..< rem.endIndex]
                    var remL = rem[rem.startIndex ..< rightIndex]
                    remL.append(contentsOf: "\(newPair.1)")
                    remL.append(contentsOf: remR)
                    print(remL)
                    next = remL

                    rem.insert(contentsOf: "\(newPair.1)", at: rightIndex)
                    //rem.insert(newPair.1.toCharacter(), at: rightIndex)
                    print(rem)
                    rem.remove(at: line.index(after: rightIndex))
//                    next = rem
                }
                else {
                    next.insert("0", at: next.startIndex)
                }

                if newPair.0 != 0 , newPair.1 != 0 {
                    next.insert("0", at: next.startIndex)
                }

                print(newPair)
                print(next)

                parts += next
                print("parts :\(parts)")
                exploded = true
                break
            }
        }
        return (exploded,parts)
    }
}

func partOne() -> Int {
    let calc = SnailFishCalculator.init(input)
    let line = calc.sum()
    print(line)
    return 0
}

func partTwo() -> Int {
    return 0
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

//enum PuzzleInput: String {
//    case input = "input"
//    case test  = "test_input"
//}
//
//func load(_ input: PuzzleInput) -> String {
//    switch input {
//    case .input:
//        return load(file: "input")
//    default:
//        return load(file: "test_input")
//    }
//}
//
//func load(file name: String) -> String {
//    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
//        fatalError("Cannot load file with name :\(name)")
//    }
//
//    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
//        fatalError("Cannot convert file contents to string for file :\(name)")
//    }
//
//    return content
//}

