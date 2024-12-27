import Algorithms
import Foundation

struct Day24: AdventDay {
  var data: String

  func part1() -> Any {
    return 0
    let com = data.components(separatedBy: "\n\n")
    var output: [String] = []
    var values: [String: Int] = [:]
    var connections: [String] = com[1].components(separatedBy: "\n").filter { $0.count > 0 }
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
    var gates: Set<String> = []
    var xs: Set<String> = []
    var ys: Set<String> = []
    var zs: Set<String> = []
    var values: [String: Int] = [:]
    var connections: [String] = com[1].components(separatedBy: "\n").filter { $0.count > 0 }
    for wire in com[0].components(separatedBy: "\n") {
      let w = wire.components(separatedBy: ": ")
      values[w[0]] = Int(w[1])!

      if w[0].contains("x") {
        xs.insert(w[0])
      }
      if w[1].contains("x") {
        xs.insert(w[1])
      }
      if w[1].contains("y") {
        ys.insert(w[1])
      }
      if w[0].contains("y") {
        ys.insert(w[0])
      }
    }

    var original = values

    //print(values, connections)

    func getResult() -> Int {
      values = original
      func perform() {
        var pending = false
        for connection in connections {
          let pars = connection.components(separatedBy: " -> ")
          let left = pars[0].components(separatedBy: " ")
          let right = pars[1]
          if right.contains("z") {
            zs.insert(right)
          }
          gates.insert(right)
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
      var ans: [Int] = []
      for z in zs.sorted(by: <).reversed() {
        ans.append(values[z]!)
      }
      print(ans)
      return ans.intValue
    }

    let x = xs.sorted(by: <).reversed().compactMap { values[$0] }
    //print(x, x.intValue)
    let y = ys.sorted(by: <).reversed().compactMap { values[$0] }
    // print(y, y.intValue)
    print(x.intValue + y.intValue)
    print(getResult())

    let expecte = x.intValue + y.intValue
    let all = gates.sorted(by: <).reversed()
    print(all, all.count)

    while true {

      break
    }

    return 0
  }
}
