import Cocoa

let input = load(.input, runFromTerminal:false).trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

print(input)

struct Instruction: CustomStringConvertible {

    var description: String {
        "\(op) \(a) \(b)"
    }

    enum Operation: String {
        case inp = "inp"
        case add = "add"
        case mul = "mul"
        case div = "div"
        case mod = "mod"
        case eql = "eql"
    }

    let op: Operation
    var a: String = ""
    var b: String = ""

    init(_ line: String) {
        let com = line.components(separatedBy: " ")
        let operation = com[0]
        self.op = Operation.init(rawValue: operation)!
        self.a = com[1]
        if self.op != .inp {
            self.b = com[2]
        }
    }
}


struct ALU {
    let instructions: [Instruction]
    let inputs: [Int]
    var register: [String: Int] = [:]
    var pos: Int = 0

    init(_ instructions: [Instruction], _ inputs: [Int]) {
        self.instructions = instructions
        self.inputs = inputs
    }

    mutating func run() -> Int {

        for instruction in instructions {
            let op = instruction.op
            let a = instruction.a
            let b = instruction.b
            switch op {
            case .inp:
                let r = inputs[pos]
                register[a] = r
                pos += 1
            case .add:
                let left = Int(a) == nil ? register[a, default: 0] : Int(a)!
                let right = Int(b) == nil ? register[b, default: 0] : Int(b)!

                let r = left + right
                register[a] = r
            case .mul:
                let left = Int(a) == nil ? register[a,default: 0] : Int(a)!
                let right = Int(b) == nil ? register[b, default: 0] : Int(b)!

                let r = left * right
                register[a] = r
            case .div:
                let left = Int(a) == nil ? register[a, default: 0] : Int(a)!
                let right = Int(b) == nil ? register[b, default: 0] : Int(b)!
                assert(right != 0)
                let r = (Double(left) / Double(right)).rounded(.towardZero)
                register[a] = Int(r)
            case .mod:
                let left = Int(a) == nil ? register[a, default: 0] : Int(a)!
                let right = Int(b) == nil ? register[b, default: 0] : Int(b)!
                assert(left >= 0)
                assert(right > 0)
                let r = left % right
                register[a] = r
            case .eql:
                let left = Int(a) == nil ? register[a, default: 0] : Int(a)!
                let right = Int(b) == nil ? register[b, default: 0] : Int(b)!

                let r = left == right ? 1 : 0
                register[a] = r
            }
        }
        return register["z"]!
    }
}

func roundDown(_ left: Int, _ right: Int) -> Int {
    Int((Double(left) / Double(right)).rounded(.towardZero))
}

var instructions: [Instruction] = []

for line in input {
    instructions.append(Instruction.init(line))
}

func solve(_ combo: [Int]) -> Bool {
    var alu = ALU.init(instructions,combo)
    let r = alu.run()
    return r == 0
}

func permutations() -> [[Int]] {
    var perms: [[Int]] = []
    for a in 1 ... 9 {
        for b in 1 ... 9 {
            for c in 1 ... 9 {
                for d in 1 ... 9 {
                    for e in 1 ... 9 {
                        for f in 1 ... 9 {
                            for g in 1 ... 9 {
                                perms.append([a,b,c,d,e,f,g])
                            }
                        }
                    }
                }
            }
        }
    }
    return perms
}

let perms = permutations()

func findModelNumber(_ smallest: Bool) -> Int {
    let typeOne = [9, 1, 11, 3, -1, 5, 0, -1, 9, -1, -1, -1, -1, -1]
    let typeTwo = [-1, -1, -1, -1, 11, -1, -1, 6, -1, 6, 6, 16, 4, 2]

    func trySolve(_ number: [Int]) -> [Int]? {
        var result: [Int] = Array.init(repeating: 0, count: 14)
        var j = 0
        var z = 0
        var skip = false
        for i in 0 ..< 14 {
            let plus = typeOne[i]
            let mod = typeTwo[i]

            if plus != -1 {
                z = z * 26 + number[j] + plus
                result[i] = number[j]
                j += 1
            }
            else {
                result[i] = (z % 26) - mod
                z = z / 26

                if result[i] < 1 || result[i] > 9 {
                    skip = true
                    break
                }
            }
        }

        return skip ? nil : result
    }

    let combos = smallest ? perms : perms.reversed()

    var ans = 0
    for combo in combos {
        if let result = trySolve(combo) {
            assert(solve(result))
            ans = Int(result.map { String($0) }.joined())!
            break
        }
    }
    return ans
}

func partOne() -> Int {
    return findModelNumber(false)
}

func partTwo() -> Int {
    return findModelNumber(true)
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

enum PuzzleInput: String {
    case input = "input"
    case test  = "test_input"
}

func load(_ input: PuzzleInput, runFromTerminal: Bool = false) -> String {
    switch input {
    case .input:
        return load(file: "input", runFromTerminal)
    default:
        return load(file: "test_input", runFromTerminal)
    }
}

func load(file name: String, _ runFromTerminal: Bool = false) -> String {

    if runFromTerminal {
        let projectURL = URL(fileURLWithPath: #file)
                .deletingLastPathComponent()
                .appendingPathComponent("Resources")
        let fileURL = projectURL.appendingPathComponent(name+".txt")
        guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else {
            fatalError("Cannot convert file contents to string for file :\(name)")
        }

        return content
    }

    guard let url = Bundle.main.url(forResource: name, withExtension: "txt") else {
        fatalError("Cannot load file with name :\(name)")
    }

    guard let content = try? String(contentsOf: url, encoding: .utf8) else {
        fatalError("Cannot convert file contents to string for file :\(name)")
    }

    return content
}
