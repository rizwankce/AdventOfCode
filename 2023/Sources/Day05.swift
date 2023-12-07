import Algorithms

struct Day05: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    /*
     seed-to-soil map:
     50 98 2
     52 50 48
     */
    struct MapRange {
        let source: ClosedRange<Int>
        let destination: ClosedRange<Int>

        let src: Int
        let dest: Int
        let size: Int

        init(_ numbers: [Int]) {
            self.destination = (numbers[0]...numbers[0] + numbers[2] - 1)
            self.source = (numbers[1]...numbers[1] + numbers[2] - 1)
            self.src = numbers[1]
            self.dest = numbers[0]
            self.size = numbers[2]
        }

        func next(_ s: Int) -> Int? {
            if source.contains(s) {
                let diff = s - source.lowerBound
                let next = destination.lowerBound + diff
                return next
            }
            return nil
        }
    }

    struct Map {
        let name: String
        let mapRanges: [MapRange]

        func next(_ sources: [Int]) -> [Int] {
            var nexts: [Int] = []
            for source in sources {
                var found = source
                for r in mapRanges {
                    if let n = r.next(source) {
                        found = n
                    }
                }
                nexts.append(found)
            }
            return nexts
        }

        func next(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
            var ranges = ranges
            var founds: [ClosedRange<Int>] = []

            for mapRange in mapRanges {
                let src = mapRange.src
                let dest = mapRange.dest
                let srcEnd = mapRange.src + mapRange.size
                var nexts: [ClosedRange<Int>] = []
                while !ranges.isEmpty {
                    let cur = ranges.removeLast()
                    let st = cur.lowerBound
                    let ed = st + cur.count - 1
                    let left = (st, min(ed, src))
                    let mid = (max(st, src), min(srcEnd, ed))
                    let right = (max(srcEnd, st), ed)

                    if left.1 > left.0 {
                        nexts.append((left.0...left.1))
                    }
                    if mid.1 > mid.0 {
                        founds.append((mid.0 - src + dest...mid.1 - src + dest))
                    }
                    if right.1 > right.0 {
                        nexts.append((right.0...right.1))
                    }
                }
                ranges = nexts
            }

            return founds + ranges
        }
    }

    func parse() -> ([Int], [Map]) {
        let com = data.components(separatedBy: "\n\n")
        let seeds = com[0].components(separatedBy: ": ")[1].numbers
        var maps: [Map] = []
        for line in com.dropFirst() {
            let lines = line.components(separatedBy: "\n")
            let name = lines.first!
            var ranges: [MapRange] = []
            for r in lines.dropFirst() {
                if r.count > 0 {
                    let nums = r.numbers
                    ranges.append(MapRange(nums))
                }
            }
            maps.append(Map(name: name, mapRanges: ranges))
        }
        return (seeds, maps)
    }

    func part1() -> Any {
        let (seeds, maps) = parse()
        var index = 0
        var nexts: [Int] = seeds

        while index < maps.count {
            let map = maps[index]
            nexts = map.next(nexts)
            index += 1
        }

        return nexts.sorted().first!
    }

    func part2() -> Any {
        let (seeds, maps) = parse()
        var allSeeds: [ClosedRange<Int>] = []
        for pair in seeds.chunks(ofCount: 2) {
            let start = pair.first!
            let range = pair.last!
            let n = (start...(start + range - 1))
            allSeeds.append(n)
        }

        var ans: [Int] = []
        for seed in allSeeds {
            var nexts: [ClosedRange<Int>] = [seed]
            for map in maps {
                nexts = map.next(nexts)
            }
            ans.append(nexts.map { $0.lowerBound }.min()!)
        }
        return ans.min()!
    }
}
