import Algorithms
import Collections

extension Int {
  func pow(toPower: Int) -> Int {
    guard toPower >= 0 else { return 0 }
    return Array(repeating: self, count: toPower).reduce(1, *)
  }
}

struct Day17: AdventDay {
  var data: String

  var input: [String] {
    data.lines
  }

  class Computer {
    var registers: [String: Int] = [:]
    let instructions: [Int]

    init(_ data: String) {
      let com = data.components(separatedBy: "\n\n")
      let regs = com[0].numbers
      self.registers["A"] = regs[0]
      self.registers["B"] = regs[1]
      self.registers["C"] = regs[2]
      self.instructions = com[1].numbers
    }

    init(_ registers: [String: Int], _ instructions: [Int]) {
      self.registers = registers
      self.instructions = instructions
    }

    func output() -> [Int] {
      func combo(_ operand: Int) -> Int {
        var left = -1
        switch operand {
        case 0, 1, 2, 3:
          left = operand
        case 4:
          left = registers["A"]!
        case 5:
          left = registers["B"]!
        case 6:
          left = registers["C"]!
        default:
          break
        }
        return left
      }

      var i = 0
      var output: [Int] = []

      while i < instructions.count {
        let opcode = instructions[i]
        let operand = instructions[i + 1]

        var canJump = false
        switch opcode {
        case 0:
          registers["A"] = registers["A"]! / 2.pow(toPower: combo(operand))

        case 1:
          registers["B"] = registers["B"]! ^ operand

        case 2:
          registers["B"] = combo(operand) % 8

        case 3:
          if registers["A"] != 0 {
            i = operand
            canJump = true
          }

        case 4:
          registers["B"] = registers["B"]! ^ registers["C"]!

        case 5:
          output.append(combo(operand) % 8)

        case 6:
          registers["B"] = registers["A"]! / 2.pow(toPower: combo(operand))

        case 7:
          registers["C"] = registers["A"]! / 2.pow(toPower: combo(operand))

        default:
          fatalError("Received unknown opcode \(opcode)")
        }
        if !canJump {
          i += 2
        }
      }

      return output
    }
  }

  func part1() -> Any {
    Computer(data).output().map { String($0) }.joined(separator: ",")
  }

  func part2() -> Any {
    let computer = Computer(data)
    var a: Int = 0
    var b: Int = 0
    var c: Int = 0

    /*
     2,4,1,1,7,5,1,5,4,0,5,5,0,3,3,0

     b = a % 8 // 2,4
     b = b ^ 1 // 1,1
     c = a / 2 ^ b //7,5
     b = b ^ 5  // 1,5
     b = b ^ c // 4,0
     output = b%8 // 5,5
     a = a / 2 ^ 3 // 0.3
     a != 0 jump to 0 // 3,0
    */

    func find(_ program: [Int], _ ans: Int) -> Int? {
      if program.isEmpty {
        return ans
      }

      for t in 0..<8 {
        a = (ans << 3) + t
        b = a % 8
        b = b ^ 1
        c = a >> b
        b = b ^ 5
        b = b ^ c

        if b % 8 == program.last {
          let new = program.dropLast()
          if let sub = find(Array(new), a) {
            return sub
          }
        }
      }
      return nil
    }

    return find(computer.instructions, 0) ?? "0"
  }
}
