import Algorithms
import Foundation

struct Day12: AdventDay {
  typealias Grid = Grid2d<Character>

  var data: String

  var grid: Grid {
    Grid(data.lines)
  }

  /*
     AAAA
     BBCD
     BBCC
     EEEC
     */

  func part1() -> Any {
    let grid = grid
    print(grid)

    func perimeter(_ region: Region) -> Int {
      var all: [Point] = []
      for p in region.points {
        let n = p.adjacent().filter {
          grid[$0] != region.name
        }
        n.forEach {
          all.append($0)
        }
      }
      return all.count
    }

    func sides(_ region: Region) -> Int {
      var all: [Point] = []
      for p in region.points {
        let n = p.adjacent().filter {
          grid[$0] != region.name
        }
        n.forEach {
          all.append($0)
        }
      }
      print(region.name, all)
      var p2: [Point] = []
      for p in all {
        var keep = true
        let right = Point(x: p.x + 0, y: p.y + 1)
        if !all.contains(right) {
          p2.append(p)
        }
        let down = Point(x: p.x + 1, y: p.y + 0)
        if !all.contains(down) {
          p2.append(p)
        }
        //                for (dx,dy) in [(1,0), (0,1)] {
        //                    let new = Point(x: p.x + dx, y: p.y + dy)
        //                    if all.contains(new) {
        //                        keep = false
        //                    }
        //                }
        //                if keep {
        //                    print(p, keep)
        //                    p2.append(p)
        //                }
      }
      return p2.count
    }

    func price(_ region: Region) -> Int {
      let area = region.points.count
      let perimeter = perimeter(region)
      //let sides = sides(region)
      print(region.name, area, perimeter)
      return area * perimeter
    }

    struct Region {
      let name: Character
      let points: Set<Point>
    }

    var plants: Set<Character> = []
    var regions: [Region] = []
    for r in (0..<grid.rowCount) {
      for c in (0..<grid.colCount) {
        let p = Point(x: c, y: r)
        let val = grid[p]!

        if regions.map({ $0.points }).filter({ $0.contains(p) }).count > 0 {

        } else {
          plants.insert(val)
          var q: Set<Point> = [p]
          var all: Set<Point> = [p]
          while !q.isEmpty {
            let cur = q.removeFirst()
            let n = cur.adjacent().filter {
              grid[$0] == val && !all.contains($0)
            }
            //print(cur, n)
            n.forEach {
              q.insert($0)
              all.insert($0)
            }
          }
          regions.append(Region(name: val, points: all))
        }
      }
    }
    //print(plants)
    //print(regions)
    var ans = 0
    for region in regions {
      ans += price(region)
    }

    return ans
  }

  func part2() -> Any {
    return 0
  }
}
