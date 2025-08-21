import Algorithms
import Foundation

struct Day24: AdventDay {
  var data: String

  func part1() -> Any {
    let com = data.components(separatedBy: "\n\n")
    guard com.count >= 2 else { return 0 }
    
    var output: [String] = []
    var values: [String: Int] = [:]
    let connections: [String] = com[1].components(separatedBy: "\n").filter { $0.count > 0 }
    for wire in com[0].components(separatedBy: "\n") {
      let w = wire.components(separatedBy: ": ")
      values[w[0]] = Int(w[1])!
    }

    //print(values, connections)

    func perform() {
      var pending = false
      for connection in connections {
        let pars = connection.components(separatedBy: " -> ")
        let left = pars[0].components(separatedBy: " ")
        let right = pars[1]
        if right.contains("z") {
          output.append(right)
        }
        //print(left, right)

        guard values[left[0]] != nil && values[left[2]] != nil else {
          pending = true
          continue
        }

        var result = 0
        switch left[1] {
        case "AND":
          result = values[left[0]]! & values[left[2]]!
          break
        case "XOR":
          result = values[left[0]]! ^ values[left[2]]!
          break
        case "OR":
          result = values[left[0]]! | values[left[2]]!
          break
        default:
          fatalError()
        }
        values[right] = result
      }

      if pending {
        perform()
      }
    }

    perform()

    output = output.uniques.sorted(by: <).reversed()
    print(output)

    var ans: [Int] = []
    for o in output {
      ans.append(values[o]!)
    }
    print(ans)
    return ans.intValue
  }

  func part2() -> Any {
    let com = data.components(separatedBy: "\n\n")
    guard com.count >= 2 else { return "No data" }
    
    var wireToGate: [String: (String, String, String)] = [:]
    
    let connections = com[1].components(separatedBy: "\n").filter { $0.count > 0 }
    
    // Parse gates and build lookup tables
    for connection in connections {
      let parts = connection.components(separatedBy: " -> ")
      let gateParts = parts[0].components(separatedBy: " ")
      let input1 = gateParts[0]
      let operation = gateParts[1]
      let input2 = gateParts[2]
      let output = parts[1]
      
      wireToGate[output] = (input1, operation, input2)
    }
    
    // Find maximum bit number
    let maxBit = wireToGate.keys.filter { $0.hasPrefix("z") }.compactMap { 
      Int($0.dropFirst()) 
    }.max() ?? 0
    
    // Helper function to check if wire is used by specific gate type
    func isUsedBy(_ wire: String, gateType: String) -> Bool {
      for (_, gate) in wireToGate {
        let (i1, op, i2) = gate
        if op == gateType && (i1 == wire || i2 == wire) {
          return true
        }
      }
      return false
    }
    
    // Industry-standard 4-rule system for identifying faulty gates
    var faultyGates: Set<String> = []
    
    // Rule 1: Z-wire outputs (except final bit) must be XOR gates
    for (output, gate) in wireToGate {
      let (_, op, _) = gate
      if output.hasPrefix("z") && output != String(format: "z%02d", maxBit) {
        if op != "XOR" {
          faultyGates.insert(output)
        }
      }
    }
    
    // Rule 2: XOR gates with x,y inputs should either output to z00 OR be used by another XOR
    for (output, gate) in wireToGate {
      let (i1, op, i2) = gate
      if op == "XOR" {
        let hasXInput = i1.hasPrefix("x") || i2.hasPrefix("x")
        let hasYInput = i1.hasPrefix("y") || i2.hasPrefix("y")
        
        if hasXInput && hasYInput {
          // This is xi XOR yi
          if output != "z00" && !isUsedBy(output, gateType: "XOR") {
            faultyGates.insert(output)
          }
        }
      }
    }
    
    // Rule 3: AND gates with x,y inputs must be used by OR gates (except x00 AND y00)
    for (output, gate) in wireToGate {
      let (i1, op, i2) = gate
      if op == "AND" {
        let hasXInput = i1.hasPrefix("x") || i2.hasPrefix("x")
        let hasYInput = i1.hasPrefix("y") || i2.hasPrefix("y")
        
        if hasXInput && hasYInput {
          // This is xi AND yi
          let isX00Y00 = (i1 == "x00" && i2 == "y00") || (i1 == "y00" && i2 == "x00")
          
          if !isX00Y00 && !isUsedBy(output, gateType: "OR") {
            faultyGates.insert(output)
          }
        }
      }
    }
    
    // Rule 4: XOR gates should NOT be used by OR gates
    for (output, gate) in wireToGate {
      let (_, op, _) = gate
      if op == "XOR" {
        if isUsedBy(output, gateType: "OR") {
          faultyGates.insert(output)
        }
      }
    }
    
    // Additional structural check: for each bit i, the XOR that uses (xi XOR yi)
    // together with that bit's carry-in should produce z(i). We can avoid
    // explicitly following the carry chain by finding the unique XOR that uses
    // the (xi XOR yi) intermediate (excluding the xi XOR yi gate itself).
    // If that XOR's output isn't z(i), both wires are part of a swapped pair.

    // Build helper maps: per bit, the wire that is (xi XOR yi)
    var xyXorByBit: [Int: String] = [:]
    for (out, gate) in wireToGate {
      let (i1, op, i2) = gate
      if op == "XOR" &&
        ((i1.hasPrefix("x") && i2.hasPrefix("y")) || (i1.hasPrefix("y") && i2.hasPrefix("x"))),
        let a = Int(i1.dropFirst()), let b = Int(i2.dropFirst()), a == b {
        xyXorByBit[a] = out
      }
    }

    // Index XOR gates by their inputs so we can query gates that use a given input
    var xorsByInput: [String: [(out: String, other: String, a: String, b: String)]] = [:]
    for (out, gate) in wireToGate {
      let (i1, op, i2) = gate
      if op == "XOR" {
        xorsByInput[i1, default: []].append((out: out, other: i2, a: i1, b: i2))
        xorsByInput[i2, default: []].append((out: out, other: i1, a: i1, b: i2))
      }
    }

    // For each z bit except z00 and the final carry bit, perform the local sum check
    let maxBit = wireToGate.keys.filter { $0.hasPrefix("z") }.compactMap { Int($0.dropFirst()) }.max() ?? 0
    if maxBit > 0 {
      for i in 1..<maxBit { // skip z00; last bit is a final OR carry
        guard let sWire = xyXorByBit[i] else { continue }
        // XORs that use sWire, excluding the xi XOR yi gate itself
        let cands = (xorsByInput[sWire] ?? []).filter { rec in
          let aIsXY = rec.a.hasPrefix("x") || rec.a.hasPrefix("y")
          let bIsXY = rec.b.hasPrefix("x") || rec.b.hasPrefix("y")
          // exclude the xi XOR yi gate itself (both inputs are x/y)
          return !(aIsXY && bIsXY)
        }
        if cands.count == 1 {
          let sumOut = cands[0].out
          let zi = String(format: "z%02d", i)
          if sumOut != zi {
            faultyGates.insert(sumOut)
            faultyGates.insert(zi)
          }
        }
      }
    }

    // Convert to sorted array and return all faulty wires (expect 8 wires)
    let sortedFaulty = Array(faultyGates).sorted()
    return sortedFaulty.joined(separator: ",")
  }
}
