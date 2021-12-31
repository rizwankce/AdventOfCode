import Cocoa

let input = #"""
#ip 3
addi 3 16 3
seti 1 3 1
seti 1 2 4
mulr 1 4 5
eqrr 5 2 5
addr 5 3 3
addi 3 1 3
addr 1 0 0
addi 4 1 4
gtrr 4 2 5
addr 3 5 3
seti 2 6 3
addi 1 1 1
gtrr 1 2 5
addr 5 3 3
seti 1 0 3
mulr 3 3 3
addi 2 2 2
mulr 2 2 2
mulr 3 2 2
muli 2 11 2
addi 5 8 5
mulr 5 3 5
addi 5 6 5
addr 2 5 2
addr 3 0 3
seti 0 5 3
setr 3 0 5
mulr 5 3 5
addr 3 5 5
mulr 3 5 5
muli 5 14 5
mulr 5 3 5
addr 2 5 2
seti 0 8 0
seti 0 9 3
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

    mutating func run() -> Int {
        let ins = Array(instructions.dropFirst())

        repeat {
            let cur = ins[ip]
            performOperation(cur.code, cur.a, cur.b, cur.c)
            ip += 1
//            print(register)
        } while ins.indices.contains(ip)

        return register[0]
    }
}

let instructions = input.map { Instruction.init($0) }
print(instructions)

func partOne() -> Int {
    let register = Array.init(repeating: 0, count: 6)
    var computer = OpCodeComputer.init(instructions, register)
    return computer.run()
}

func partTwo() -> Int {
//    var register = Array.init(repeating: 0, count: 6)
//    register[0] = 1
//    var computer = OpCodeComputer.init(instructions, register)
//    return computer.run()

    let r2 = 10551418
    let sr = Int(Double(r2).squareRoot())
    let all = (1 ... sr).filter { r2 % $0 == 0 }
    return all.flatMap { [$0, r2/$0] }.reduce(0, +)
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")
