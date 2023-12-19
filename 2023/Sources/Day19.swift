import Algorithms

struct Day19: AdventDay {
    var data: String

    var input: [String] {
        data.trimmingCharacters(in: .newlines).components(separatedBy: "\n\n")
    }

    struct Rule: CustomStringConvertible {
        var description: String {
            "\(condition): \(next)"
        }

        let condition: String
        let next: String
        let left: String
        let value: Int
        let operation: String

        init(_ line: String) {
            // a<2006:qkq
            let com = line.components(separatedBy: ":")
            self.condition = com[0]
            self.next = com[1]

            if condition.contains("<") {
                let com = condition.components(separatedBy: "<")
                self.left = com[0]
                self.value = Int(com[1])!
                self.operation = "<"
            }
            else {
                let com = condition.components(separatedBy: ">")
                self.left = com[0]
                self.value = Int(com[1])!
                self.operation = ">"
            }
        }

        func process(_ rating: Ratings) -> String? {
            if condition.contains("<") {
                if rating.get(left) < value {
                    return next
                }
                else {
                    return nil
                }
            }
            else if condition.contains(">") {
                if rating.get(left) > value {
                    return next
                }
                else {
                    return nil
                }
            }

            fatalError()
        }
    }

    struct Workflow: CustomStringConvertible {
        let name: String
        let rules: [Rule]
        let last: String

        var description: String {
            "\(name) \(rules) \(last)"
        }

        init(_ line: String) {
            let com = line.split(whereSeparator: { "{}".contains($0) != false })
            self.name = String(com[0])
            var rls = com[1].components(separatedBy: ",")
            self.last = rls.removeLast()
            var rules: [Rule] = []
            for r in rls {
                rules.append(Rule(r))
            }
            self.rules = rules
        }

        func process(_ rating: Ratings) -> String {
            var next: String? = nil
            for rule in rules {
                let result = rule.process(rating)
                if let result = result {
                    next = result
                    break
                }
            }

            return next ?? last
        }
    }

    struct Ratings: CustomStringConvertible {

        var description: String {
            "x: \(x), m: \(m), s:\(s), a:\(a)"
        }

        var x: Int
        var m: Int
        var s: Int
        var a: Int

        init(_ line: String) {
            // x=787,m=2655,a=1222,s=2876
            let com = line.components(separatedBy: ",")
            self.x = 0
            self.m = 0
            self.s = 0
            self.a = 0
            for c in com {
                let l = c.components(separatedBy: "=")
                let v = Int(l[1])!
                switch l[0] {
                case "x": self.x = v
                case "m": self.m = v
                case "s": self.s = v
                case "a": self.a = v
                default: fatalError()
                }
            }
        }

        func get(_ string: String) -> Int {
            switch string {
            case "x": return x
            case "m": return m
            case "s": return s
            case "a": return a
            default: fatalError()
            }
        }

        func sum() -> Int {
            x + m + s + a
        }
    }

    func parseWorkflows() -> [Workflow] {
        input[0].components(separatedBy: "\n").map { Workflow($0) }
    }

    func parseRating() -> [Ratings] {
        input[1].components(separatedBy: "\n").map {
            $0.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "")
        }
        .map {
            Ratings($0)
        }
    }

    func part1() -> Any {
        let workflows = parseWorkflows()
        let ratings = parseRating()

        func workflow(named name: String) -> Workflow {
            workflows.first(where: { $0.name == name })!
        }

        var sorted: [Ratings] = []
        for rating in ratings {
            var current = workflow(named: "in")
            while true {
                let next = current.process(rating)
                if next == "R" || next == "A" {
                    if next == "A" {
                        sorted.append(rating)
                    }
                    break
                }
                current = workflow(named: next)
            }
        }

        return sorted.map { $0.sum() }.reduce(0, +)
    }

    func part2() -> Any {
        let workflows = parseWorkflows()

        func workflow(named name: String) -> Workflow {
            workflows.first(where: { $0.name == name })!
        }

        func findTotal(_ current: String, _ parts: [String: ClosedRange<Int>]) -> Int {
            var parts = parts
            if current == "R" {
                return 0
            }

            if current == "A" {
                return parts.values.map { v in
                    v.upperBound - v.lowerBound + 1
                }.reduce(1, *)
            }

            let workflow = workflow(named: current)
            var total = 0

            for rule in workflow.rules {
                let range = parts[rule.left]!
                if rule.operation == "<" {
                    if range.lowerBound < rule.value {
                        parts[rule.left] = (range.lowerBound...rule.value - 1)
                        total += findTotal(rule.next, parts)
                    }

                    if range.upperBound >= rule.value {
                        parts[rule.left] = (rule.value...range.upperBound)
                    }
                    else {
                        break
                    }
                }
                else {
                    if range.upperBound > rule.value {
                        parts[rule.left] = (rule.value + 1...range.upperBound)
                        total += findTotal(rule.next, parts)
                    }

                    if range.lowerBound <= rule.value {
                        parts[rule.left] = (range.lowerBound...rule.value)
                    }
                    else {
                        break
                    }
                }
            }

            total += findTotal(workflow.last, parts)
            return total
        }

        let range = 1...4000
        return findTotal("in", ["x": range, "m": range, "a": range, "s": range])
    }
}
