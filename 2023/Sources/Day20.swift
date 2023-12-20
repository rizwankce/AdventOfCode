import Algorithms

struct Day20: AdventDay {
    var data: String

    var input: [String] {
        data.lines
    }

    func cycle(
        _ broadcaster: [String],
        _ ffs: [String: [String]],
        _ ffsMemory: [String: Int],
        _ cjs: [String: [String]],
        _ cjsMemory: [String: [String: Int]],
        _ isPart2: Bool
    ) -> Int {
        var ffsMemory = ffsMemory
        var cjsMemory = cjsMemory

        var rxPrev: String? = nil
        var topMost: Set<String> = []
        var topMostIntersted: [Int] = []

        for ff in cjs {
            if ff.value.contains("rx") {
                rxPrev = ff.key
                break
            }
        }

        for ff in cjs {
            if ff.value.contains(rxPrev!) {
                topMost.insert(ff.key)
            }
        }

        var lowCount: Int = 0
        var highCount: Int = 0
        var cycle = 0
        outer: for i in 1... {
            if i == 1001 && !isPart2 {
                break
            }

            cycle += 1
            lowCount += broadcaster.count + 1
            var queue: [(String, Int)] = broadcaster.map { ($0, 0) }
            while !queue.isEmpty {
                let current = queue.removeFirst()
                let source = current.0
                let pluse = current.1

                if current.1 == 0 {
                    if topMost.contains(source) {
                        topMostIntersted.append(i)
                        if topMostIntersted.count == topMost.count && isPart2 {
                            break outer
                        }
                    }
                }

                var next: [(String, Int)] = []

                if ffs.keys.contains(source) {
                    if pluse == 0 {
                        let c = ffsMemory[source]
                        let n = c == 0 ? 1 : 0
                        ffsMemory[source] = n
                        for d in ffs[source]! {
                            next.append((d, n))
                        }
                    }
                }
                else if cjs.keys.contains(source) {
                    let mem = cjsMemory[source]!
                    if mem.values.allSatisfy({ $0 == 1 }) {
                        for d in cjs[source]! {
                            next.append((d, 0))
                        }
                    }
                    else {
                        for d in cjs[source]! {
                            next.append((d, 1))
                        }
                    }
                }

                for n in next {
                    if n.1 == 0 {
                        lowCount += 1
                    }
                    else if n.1 == 1 {
                        highCount += 1
                    }

                    for c in cjs.keys {
                        if c == n.0 {
                            let m = cjsMemory[c]
                            if m != nil {
                                var m = m!
                                m[source] = n.1
                                cjsMemory[c] = m
                            }
                            else {
                                let n: [String: Int] = [source: n.1]
                                cjsMemory[c] = n
                            }
                        }
                    }
                }

                queue.append(contentsOf: next)
            }
        }

        if isPart2 {
            return topMostIntersted.lcm()
        }

        let cy = (1000 / cycle)
        return (lowCount * cy) * (highCount * cy)
    }

    func parse() -> (
        [String], [String: [String]], [String: Int], [String: [String]], [String: [String: Int]]
    ) {
        var broadcaster: [String] = []
        var ffs: [String: [String]] = [:]
        var ffsMemory: [String: Int] = [:]
        var cjs: [String: [String]] = [:]
        var cjsMemory: [String: [String: Int]] = [:]

        for line in input {
            let com = line.components(separatedBy: " -> ")
            var source = com[0]
            let destination = com[1].components(separatedBy: ",").map {
                $0.trimmingCharacters(in: .whitespaces)
            }

            if source == "broadcaster" {
                broadcaster.append(contentsOf: destination)
            }
            else {
                if source.contains("%") {
                    _ = source.removeFirst()
                    ffs[source] = destination
                    ffsMemory[source] = 0
                }
                else if source.contains("&") {
                    _ = source.removeFirst()
                    cjs[source] = destination
                }
                else {
                    fatalError()
                }
            }
        }

        for cj in cjs.keys {
            for ff in ffs {
                if ff.value.contains(cj) {
                    var mem = cjsMemory[cj]
                    if mem == nil {
                        cjsMemory[cj, default: [:]] = [ff.key: 0]
                    }
                    else {
                        mem![ff.key] = 0
                        cjsMemory[cj] = mem
                    }
                }
            }
        }

        return (broadcaster, ffs, ffsMemory, cjs, cjsMemory)
    }

    func part1() -> Any {
        let parsed = parse()
        return cycle(parsed.0, parsed.1, parsed.2, parsed.3, parsed.4, false)
    }

    func part2() -> Any {
        let parsed = parse()
        return cycle(parsed.0, parsed.1, parsed.2, parsed.3, parsed.4, true)
    }
}
