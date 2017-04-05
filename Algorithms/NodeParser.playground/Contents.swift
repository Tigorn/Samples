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
    
    static func make(_ dict: [T: Any?]) -> [Node<T>] {
        var nodes = [Node<T>]()
        for (key, value) in dict {
            let node = Node(key)
            if let value = value as? [T: Any?] {
                for child in Node.make(value) {
                    node.addChild(child)
                }
            }
            nodes.append(node)
        }
        return nodes
    }
    
}

extension Dictionary where Key: Hashable {
    
    func makeNodes() -> [Node<Key>] {
        return Node.make(self)
    }
    
}

let dict = ["Social": ["Arts": ["Art Dealers and Galleries": ""]]]
print(dict.makeNodes())
