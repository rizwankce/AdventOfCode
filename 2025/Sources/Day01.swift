import Algorithms

struct Day01: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n").compactMap { String($0) }
  }

  func part1() -> Any {
    var cur = 50
    var ans = 0
    for e in entities {
      let dir = e.first
      let num = e.dropFirst()
      if dir == "L" {
        cur = cur - Int(num)!
        while cur < 0 {
          cur = 100 - abs(cur)
        }
      }
      if dir == "R" {
        cur = cur + Int(num)!
        while cur > 99 {
          cur = cur - 100
        }
      }
      if cur == 0 {
        ans += 1
      }
    }
    return ans
  }

  func part2() -> Any {
    var cur = 50
    var ans = 0
    for e in entities {
      let dir = e.first
      let num = e.dropFirst()
      var rs = 0
      var o = cur
      if dir == "L" {
        cur = cur - Int(num)!
        while cur < 0 {
          cur = 100 - abs(cur)
          if o != 0 {
            rs += 1
          }
          o = cur
        }
      }
      if dir == "R" {
        cur = cur + Int(num)!
        while cur > 99 {
          cur = cur - 100
          if cur != 0 {
            rs += 1
          }
          o = cur
        }
      }
      if cur == 0 {
        ans += 1
      }
      ans += rs
    }
    return ans
  }
}
