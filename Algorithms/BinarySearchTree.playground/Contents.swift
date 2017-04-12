//: Playground - noun: a place where people can play

import UIKit

enum BinarySearchTree<T: Comparable> {
    case empty
    case leaf(T)
    indirect case node(BinarySearchTree, T, BinarySearchTree)
    
    var count: Int {
        switch self {
        case .empty:
            return 0
        case .leaf(_):
            return 1
        case let .node(left, _, right):
            return left.count + 1 + right.count
        }
    }
    
    var min: BinarySearchTree {
        var node = self
        var prev = node
        while case let .node(next, _, _) = node {
            prev = node
            node = next
        }
        if case .leaf = node {
            return node
        }
        return prev
    }
    
    var max: BinarySearchTree {
        var node = self
        var prev = node
        while case let .node(_, _, next) = node {
            prev = node
            node = next
        }
        if case .leaf = node {
            return node
        }
        return prev
    }
    
    func append(_ newValue: T) -> BinarySearchTree {
        switch self {
        case .empty:
            return .leaf(newValue)
        case let .leaf(value):
            if newValue < value {
                return .node(.leaf(newValue), value, .empty)
            } else {
                return .node(.empty, value, .leaf(newValue))
            }
        case let .node(left, value, right):
            if newValue < value {
                return .node(left.append(newValue), value, right)
            } else {
                return .node(left, value, right.append(newValue))
            }
        }
    }
    
    func search(_ x: T) -> BinarySearchTree? {
        switch self {
        case .empty:
            return nil
        case let .leaf(y):
            return (x == y) ? self : nil
        case let .node(left, y, right):
            if x < y {
                return left.search(x)
            } else if x > y {
                return right.search(x)
            } else {
                return self
            }
        }
    }
    
}

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty: return "."
        case let .leaf(value): return "\(value)"
        case let .node(left, value, right):
            return "(\(left.description) <- \(value) -> \(right.description))"
        }
    }
}

var tree = BinarySearchTree.leaf(7)
tree = tree.append(2)
tree = tree.append(5)
tree = tree.append(10)
tree = tree.append(9)
tree = tree.append(1)
print(tree)

tree.search(10)
tree.search(1)
tree.search(11)
