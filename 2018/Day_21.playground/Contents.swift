import Cocoa

let input = #"""
#ip 5
seti 123 0 3
bani 3 456 3
eqri 3 72 3
addr 3 5 5
seti 0 0 5
seti 0 9 3
bori 3 65536 1
seti 9450265 6 3
bani 1 255 4
addr 3 4 3
bani 3 16777215 3
muli 3 65899 3
bani 3 16777215 3
gtir 256 1 4
addr 4 5 5
addi 5 1 5
seti 27 1 5
seti 0 9 4
addi 4 1 2
muli 2 256 2
gtrr 2 1 2
addr 2 5 5
addi 5 1 5
seti 25 7 5
addi 4 1 4
seti 17 5 5
setr 4 6 1
seti 7 8 5
eqrr 3 0 4
addr 4 5 5
seti 5 8 5
"""#.components(separatedBy: .newlines)

//print(input)

extension String {
    var numbers: [Int] {
        split(whereSeparator: { "-0123456789".contains($0) == false })
            .map { Int($0)! }
    }
}

struct Instruction: CustomStringConvertible {
    let code: Opcode
    let a: Int
    let b: Int
    let c: Int

    init(_ line: String) {
        let numbers = line.numbers
        self.code = Opcode.init(rawValue: line.components(separatedBy: " ")[0])!
        self.a = numbers[0]
        if numbers.count > 1 {
            self.b = numbers[1]
            self.c = numbers[2]
        }
        else {
            self.b = -1
            self.c = -1
        }
    }

    var description: String {
        "\(code.rawValue) \(a) \(b) \(c)"
    }
}

enum Opcode: String {
    case ip = "#ip"
    case addr
    case addi
    case mulr
    case muli
    case banr
    case bani
    case borr
    case bori
    case setr
    case seti
    case gtir
    case gtri
    case gtrr
    case eqir
    case eqri
    case eqrr
}

struct OpCodeComputer {
    var register: [Int]
    var instruction: [Instruction]
    var registerBound: Int

    init(_ ins: [Instruction], _ reg: [Int]) {
        self.instruction = ins
        self.register = reg
        self.registerBound = ins[0].a
    }

    var ip: Int {
        get {
            register[registerBound]
        }

        set {
            register[registerBound] = newValue
        }
    }

    mutating func performOperation(_ code: Opcode, _ a: Int, _ b: Int, _ c: Int) {
        switch code {
        case .ip: fatalError()
        case .addr: register[c] = register[a] + register[b]
        case .addi: register[c] = register[a] + b
        case .mulr: register[c] = register[a] * register[b]
        case .muli: register[c] = register[a] * b
        case .banr: register[c] = register[a] & register[b]
        case .bani: register[c] = register[a] & b
        case .borr: register[c] = register[a] | register[b]
        case .bori: register[c] = register[a] | b
        case .setr: register[c] = register[a]
        case .seti: register[c] = a
        case .gtir: register[c] = a > register[b] ? 1 : 0
        case .gtri: register[c] = register[a] > b ? 1 : 0
        case .gtrr: register[c] = register[a] > register[b] ? 1 : 0
        case .eqir: register[c] = a == register[b] ? 1 : 0
        case .eqri: register[c] = register[a] == b ? 1 : 0
        case .eqrr: register[c] = register[a] == register[b] ? 1 : 0
        }
    }

    mutating func runLow() -> Int {
        let ins = Array(instructions.dropFirst())

        repeat {
            let cur = ins[ip]
            performOperation(cur.code, cur.a, cur.b, cur.c)
            ip += 1
            if ip == 28 {
                return register[3]
            }
        } while ins.indices.contains(ip)

        fatalError()
    }

    mutating func runHigh() -> Int {
        var values: Set<Int> = []
        var recent = -1
        let ins = Array(instructions.dropFirst())

        repeat {
            let cur = ins[ip]
            performOperation(cur.code, cur.a, cur.b, cur.c)
            ip += 1
            if ip == 28 {
                let new = register[3]
                guard values.contains(new) == false else {
                    return recent
                }
                values.insert(new)
                recent = new
            }
        } while ins.indices.contains(ip)

        fatalError()
    }
}

let instructions = input.map { Instruction.init($0) }
print(instructions)

func partOne() -> Int {
    let register = Array.init(repeating: 0, count: 6)
    var computer = OpCodeComputer.init(instructions, register)
    return computer.runLow()
}

func partTwo() -> Int {
    let register = Array.init(repeating: 0, count: 6)
    var computer = OpCodeComputer.init(instructions, register)
    return computer.runHigh()
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
