import Algorithms

struct Day08: AdventDay {
    var data: String

    struct MapNetwork {
        let instructions: [String.Element]
        var maps: [String: (String, String)]
        var starts: [String]

        init(_ input: String) {
            let com = input.trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")
            let lines = com[1].components(separatedBy: "\n")
            self.maps = [:]
            self.starts = []
            self.instructions = com[0].map { $0 }
            for line in lines {
                let lr = line.components(separatedBy: " = ")
                let key = lr[0]
                let value = lr[1].replacingOccurrences(of: "(", with: "").replacingOccurrences(
                    of: ")",
                    with: ""
                ).components(separatedBy: ", ")
                maps[key] = (value[0], value[1])

                if key.last == "A" {
                    starts.append(key)
                }
                assert(key.count == 3)
                assert(value[0].count == 3)
                assert(value[1].count == 3)
            }
        }

        func steps(from: String, to: String) -> Int {
            var i = 0
            var cur = from
            var count = 0

            while true {
                count += 1
                let ins = instructions[i]
                i += 1
                let way = maps[cur]!
                if ins == "L" {
                    cur = way.0
                }
                if ins == "R" {
                    cur = way.1
                }

                if cur == to {
                    break
                }

                if i >= instructions.count {
                    i = 0
                }
            }

            return count
        }

        func stepsFromNodeStartsWithA() -> Int {
            var i = 0
            var cur = starts
            var count = 0
            var vistTimes: [Int] = []

            while vistTimes.count != cur.count {
                count += 1
                let ins = instructions[i]
                i += 1
                var n: [String] = []
                for c in cur {
                    let way = maps[c]!
                    if ins == "L" {
                        n.append(way.0)
                    }
                    if ins == "R" {
                        n.append(way.1)
                    }
                }
                cur = n

                for nx in n {
                    if nx.last == "Z" {
                        vistTimes.append(count)
                    }
                }

                if i > instructions.count - 1 {
                    i = 0
                }
            }
            /*
             [13201, 14429, 18113, 18727, 20569, 22411]
             each node takes differnt steps to reach
             to reach all nodes needs LCM 
             */
            return vistTimes.lcm()
        }
    }

    func part1() -> Any {
        MapNetwork(data).steps(from: "AAA", to: "ZZZ")
    }

    func part2() -> Any {
        MapNetwork(data).stepsFromNodeStartsWithA()
    }
}
