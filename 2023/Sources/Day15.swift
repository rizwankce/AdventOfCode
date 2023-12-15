import Algorithms

struct Day15: AdventDay {
    var data: String

    class Lens: CustomStringConvertible {
        var description: String {
            "\(name) \(opration) \(focalLength)"
        }

        enum Operation: String, Hashable {
            case equal = "="
            case minus = "-"
        }

        let name: String
        let opration: Operation
        let focalLength: Int
        let rawString: String

        init(_ string: String) {
            self.rawString = string
            // rn=1 or cm-
            if string.contains("=") {
                let com = string.components(separatedBy: "=")
                self.name = com[0]
                self.opration = .equal
                self.focalLength = Int(com[1])!
            }
            else if string.contains("-") {
                let com = string.components(separatedBy: "-")
                self.name = com[0]
                self.opration = .minus
                self.focalLength = -1
            }
            else {
                fatalError()
            }
        }

        func hash(_ includeOperation: Bool = false) -> Int {
            var current = 0
            for char in includeOperation ? rawString : name {
                current += Int(char.asciiValue!)
                current *= 17
                current = current % 256
            }
            return current
        }
    }

    func parse() -> [Lens] {
        data.trimmingCharacters(in: .newlines).components(separatedBy: ",").map { Lens($0) }
    }

    func part1() -> Any {
        parse().map { $0.hash(true) }.reduce(0, +)
    }

    func part2() -> Any {
        let lenses = parse()
        var map: [Int: [Lens]] = [:]

        for lens in lenses {
            let box = lens.hash()

            switch lens.opration {
            case .equal:
                if var ls = map[box] {
                    if let idx = ls.firstIndex(where: { $0.name == lens.name }) {
                        ls[idx] = lens
                        map[box] = ls
                    }
                    else {
                        map[box]!.append(lens)
                    }
                }
                else {
                    map[box, default: []].append(lens)
                }
            case .minus:
                if var ls = map[box] {
                    if let idx = ls.firstIndex(where: { $0.name == lens.name }) {
                        ls.remove(at: idx)
                        map[box] = ls
                    }
                }
            }
        }

        var ans = 0
        for kv in map {
            for (idx, lens) in kv.value.enumerated() {
                ans += (1 + kv.key) * (idx + 1) * (lens.focalLength)
            }
        }

        return ans
    }
}
