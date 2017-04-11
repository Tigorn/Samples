//: Playground - noun: a place where people can play

import UIKit

class LinkedListNode<T> {
    let value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    init(_ value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    typealias Node = LinkedListNode<T>
    var head: Node?
    var last: Node? {
        guard var node = head else { return nil }
        while case let next? = node.next {
            node = next
        }
        return node
    }
    var count: Int {
        guard var node = head else { return 0 }
        var i = 1 // head counts
        while case let next? = node.next {
            node = next
            i += 1
        }
        return i
    }
    func node(atIndex index: Int) -> Node? {
        guard var node = head else { return nil }
        var i = index
        while case let next? = node.next, i > 0 {
            node = next
            i -= 1
        }
        return node
    }
    func append(_ value: T) {
        let node = Node(value)
        if let last = last {
            last.next = node // last >> node
            node.previous = last // last << node
        } else {
            head = node
        }
    }
    func remove(_ node: Node) {
        let previous = node.previous
        let next = node.next
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        next?.previous = previous
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
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

let list = LinkedList<String>()
list.append("Hello")
list.append("World")
list.node(atIndex: 0)?.value
list.count
let node = list.last
list.remove(node!)
list.append("Swift")

