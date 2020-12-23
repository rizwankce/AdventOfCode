import Cocoa

let input = """
467528193
""".map { Int(String($0))! }

//print(input)

class Node: Hashable, CustomStringConvertible {
    var description: String {
        return "P:\(String(describing: prev))->V:\(value)->N: \(String(describing: next))"
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value && lhs.prev == rhs.prev && lhs.next == rhs.next
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }

    var next: Node?
    var prev: Node?
    var value: Int

    init(value: Int) {
        self.value = value
        self.next = nil
        self.prev = nil
    }
}

let low = input.min()!
let high = input.max()!

var dict: [Int: Node] = [:]
var nodes: [Node] = []

for i in input {
    nodes.append(Node.init(value: i))
}

func prepare(_ isMillions: Bool) {
    if isMillions {
        var curHigh = high + 1
        while nodes.count < 1_000_000 {
            nodes.append(Node.init(value: curHigh))
            curHigh += 1
        }
    }

    for (a,b) in zip(nodes,nodes[1...]) {
        a.next = b
    }
    nodes.last?.next = nodes.first

    for node in nodes {
        dict[node.value] = node
    }
}

func partOne() -> String {
    prepare(false)
    var cur = nodes[0]

    for _ in (1...100) {
        let a = cur.next
        let b = a?.next
        let c = b?.next
        cur.next = c?.next
        let toRemove = [cur.value,a!.value,b!.value,c!.value]
        let toKeep = nodes.filter {
            !toRemove.contains($0.value)
        }.map { $0.value }

        var curValue = cur.value
        while !toKeep.contains(curValue) {
            curValue -= 1
            if curValue < low {
                curValue = high
            }
        }

        let newCups = dict[curValue]
        let nextCups = newCups?.next

        newCups?.next = a
        c?.next = nextCups

        cur = cur.next!
    }

    let n1 = nodes.filter {
        $0.value == 1
    }.first!

    var r: [Int] = []
    var c = n1.next
    while c?.value != 1 {
        r.append(c!.value)
        c = c?.next
    }

    return r.map { String($0) }.joined()
}

func partTwo() -> Int {
    prepare(true)
    var cur = nodes[0]

    for _ in (1...10_000_000) {
        let a = cur.next
        let b = a?.next
        let c = b?.next
        cur.next = c?.next
        let toRemove = [cur.value,a!.value,b!.value,c!.value]
        var curValue = cur.value

        while toRemove.contains(curValue) {
            curValue -= 1
            if curValue == 0 {
                curValue = 1_000_000
            }
        }

        let newCups = dict[curValue]
        let nextCups = newCups?.next

        newCups?.next = a
        c?.next = nextCups

        cur = cur.next!
    }

    let cupOne = dict[1]
    let a = cupOne!.next
    let b = a!.next

    return a!.value * b!.value
}

print("Part One answer is: \(partOne())")
print("Part Two answer is: \(partTwo())")

