//: Playground - noun: a place where people can play

import UIKit

class Node<T> {
    typealias U = Node<T>
    
    let value: T
    weak var parent: U?
    var children = [U]()
    
    init(_ value: T) {
        self.value = value
    }
    
    func addChild(_ node: U) {
        children.append(node)
        node.parent = self
    }
}

extension Node: CustomStringConvertible {
    
    var description: String {
        return "\(value) { " + children.map { $0.description }.joined(separator: ", ") + " }"
    }
    
}

extension Node where T: Hashable {
    
    static func make(_ data: [T: Any?]) -> [Node<T>] {
        return data.map { key, value in
            let node = Node(key)
            if let value = value as? [T: Any?] {
                Node.make(value).forEach {
                    node.addChild($0)
                }
            } else if let value = value as? [T] {
                Node.make(value).forEach {
                    node.addChild($0)
                }
            }
            return node
        }
    }
    
}

extension Node {
    
    static func make(_ data: [T]) -> [Node<T>] {
        return data.map { Node($0) }
    }
    
}

extension Dictionary where Key: Hashable {
    
    func makeNodes() -> [Node<Key>] {
        return Node.make(self)
    }
    
}

extension Array {
    
    func makeNodes() -> [Node<Element>] {
        return Node.make(self)
    }
    
}

let dict = [
    "Social": [
        "Arts": [
            "Art Dealers and Galleries"
        ],
        "Bars": [
            "Hotel Lounges"
        ]
    ]
]
print(dict.makeNodes())
