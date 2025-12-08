import Algorithms
import Foundation

struct Day08: AdventDay {
  var data: String

  var entities: [Point3D] {
    data
      .trimmingCharacters(in: .newlines)
      .components(separatedBy: .newlines)
      .map {
        let com = $0.components(separatedBy: ",")
        return Point3D(x: Int(com[0])!, y: Int(com[1])!, z: Int(com[2])!)
      }
  }

  func distance(_ p1: Point3D, _ p2: Point3D) -> Double {
    let dx = p1.x - p2.x
    let dy = p1.y - p2.y
    let dz = p1.z - p2.z
    let v = dx * dx + dy * dy + dz * dz
    return sqrt(Double(v))
  }

  struct Line: Hashable {
    let p1: Point3D
    let p2: Point3D
    let dist: Double

    var description: String {
      "\(p1) to \(p2): \(dist)"
    }
  }

  struct Circuit: CustomStringConvertible {
    var points: Set<Point3D>

    func contains(_ point: Point3D) -> Bool {
      points.contains(point)
    }

    var description: String {
      "\(points)"
    }
  }

  func calculateAllDistances() -> [Line] {
    let ent = entities
    var all: [Line] = []
    all.reserveCapacity(ent.count * ent.count / 2)

    for i in 0..<ent.count {
      for j in (i + 1)..<ent.count {
        let p1 = ent[i]
        let p2 = ent[j]

        all.append(Line(p1: p1, p2: p2, dist: distance(p1, p2)))
      }
    }

    all = all.sorted(by: { l1, l2 in
      l1.dist < l2.dist
    })
    return all
  }

  func merge(_ line: Line, _ circuits: inout [Circuit]) {
    let points = line
    var cidx: [Int] = []

    for idx in 0..<circuits.count {
      let c = circuits[idx]
      if c.contains(points.p1) || c.contains(points.p2) {
        cidx.append(idx)
      }
    }

    if cidx.count == 0 {
      circuits.append(Circuit(points: [points.p1, points.p2]))
    } else if cidx.count == 1 {
      let idx = cidx.first!
      circuits[idx].points.insert(points.p1)
      circuits[idx].points.insert(points.p2)
    } else if cidx.count == 2 {
      var ps1 = circuits[cidx[0]].points
      let ps2 = circuits[cidx[1]].points

      circuits[cidx[0]].points.removeAll()
      circuits[cidx[1]].points.removeAll()
      _ = ps2.map { ps1.insert($0) }
      circuits.append(Circuit(points: ps1))
    } else {
      fatalError("not expected")
    }
  }

  func part1(_ max: Int) -> Int {
    let all = calculateAllDistances()

    var circuits: [Circuit] = []
    for i in 0..<max {
      merge(all[i], &circuits)
    }

    let counts = circuits.map { $0.points.count }.sorted().reversed()

    return counts[_offset: 0] * counts[_offset: 1] * counts[_offset: 2]
  }

  func part1() -> Any {
    part1(1000)
  }

  func part2() -> Any {
    let ent = entities
    let all = calculateAllDistances()

    var circuits: [Circuit] = []
    var idx: Int = 0
    for i in 0..<all.count {
      idx = i
      let points = all[i]
      merge(points, &circuits)

      let check = circuits.map({ $0.points.count }).filter({ $0 != 0 })
      if check.count == 1 && check.first! == ent.count {
        break
      }
    }

    return all[idx].p1.x * all[idx].p2.x
  }
}
