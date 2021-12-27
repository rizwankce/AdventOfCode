import Cocoa
import Foundation

var input = """
473 players; last marble is worth 70904 points
"""

//print(input)

extension String {
    var numbers: [Int] {
        split(whereSeparator: { "-0123456789".contains($0) == false })
            .map { Int($0)! }
    }
}

class Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.value == rhs.value
    }

    let value: Int
    var next: Node?
    var previous: Node?

    init(_ value: Int) {
        self.value = value
        next = nil
        previous = nil
    }
}

class LinkedList: CustomStringConvertible {
    var head: Node
    var tail: Node

    init() {
        let zero = Node(0)
        head = zero
        tail = zero
        zero.next = zero
        zero.previous = zero
    }

    func insert(current: Node, node: Node) {
        if head == tail {
            node.previous = head
            node.next = head
            head.next = node
            head.previous = node
            tail = node
        }
        else {
            let first = current.next
            let second = current.next?.next

            first?.next = node
            second?.previous = node
            node.next = second
            node.previous = first
        }
    }

    var description: String {
        var node = head
        var result: [Int] = []
        while head !== node.next {
            result.append(node.value)
            node = node.next!
        }
        result.append(node.value)
        return result.description
    }
}

func play(_ playerCount: Int, _ pointsWorth: Int) -> Int {

    let list = LinkedList()
    var current = list.head
    var scores: [Int: Int] = [:]

    for turn in 1 ... pointsWorth {
        if turn % 23 == 0 {
            let playerNumber = turn % playerCount
            let toRemove = current.previous?.previous?.previous?.previous?.previous?.previous?.previous
            let head = toRemove?.previous
            let tail = toRemove?.next
            head?.next = tail
            tail?.previous = head
            current = tail!
            let score = turn + (toRemove?.value ?? 0)
            scores[playerNumber, default: 0] += score

        }
        else {
            let new = Node(turn)
            list.insert(current: current, node: new)
            current = new
        }
    }

    return scores.values.max()!
}

let playerCount = input.numbers[0]
let pointsWorth = input.numbers[1]

func partOne() -> Int {
    play(playerCount,pointsWorth)
}

func partTwo() -> Int {
    play(playerCount,pointsWorth*100)
}

print("Part 1 answer is \(partOne())")
print("Part 2 answer is \(partTwo())")
