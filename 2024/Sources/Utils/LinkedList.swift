//
//  File.swift
//  AdventOfCode
//
//  Created by Rizwan on 09/12/24.
//

import Foundation

public class LinkedListNode<T>: CustomStringConvertible {
	var value: T
	var next: LinkedListNode?
	weak var previous: LinkedListNode?

	public init(value: T) {
		self.value = value
	}

	public var description: String {
		"\(value)"
	}
}

public class LinkedList<T>: CustomStringConvertible {
	public typealias Node = LinkedListNode<T>

	private var head: Node?

	public var isEmpty: Bool {
		return head == nil
	}

	public var first: Node? {
		return head
	}

	public var last: Node? {
		guard var node = head else {
			return nil
		}

		while let next = node.next {
			node = next
		}
		return node
	}

	public func append(value: T) {
		let newNode = Node(value: value)
		if let lastNode = last {
			newNode.previous = lastNode
			lastNode.next = newNode
		}
		else {
			head = newNode
		}
	}

	public var count: Int {
		guard var node = head else {
			return 0
		}

		var count = 1
		while let next = node.next {
			node = next
			count += 1
		}
		return count
	}
	public func node(atIndex index: Int) -> Node {
		if index == 0 {
			return head!
		}
		else {
			var node = head!.next
			for _ in 1..<index {
				node = node?.next
				if node == nil {  //(*1)
					break
				}
			}
			return node!
		}
	}
	public func insert(_ node: Node, atIndex index: Int) {
		let newNode = node
		if index == 0 {
			newNode.next = head
			head?.previous = newNode
			head = newNode
		}
		else {
			let prev = self.node(atIndex: index - 1)
			let next = prev.next

			newNode.previous = prev
			newNode.next = prev.next
			prev.next = newNode
			next?.previous = newNode
		}
	}

	public func remove(node: Node) -> T {
		let prev = node.previous
		let next = node.next

		if let prev = prev {
			prev.next = next
		}
		else {
			head = next
		}
		next?.previous = prev

		node.previous = nil
		node.next = nil
		return node.value
	}

	public var description: String {
		var s = "["
		var node = head
		while node != nil {
			s += "\(node!.value)"
			node = node!.next
			if node != nil { s += ", " }
		}
		return s + "]"
	}
}
