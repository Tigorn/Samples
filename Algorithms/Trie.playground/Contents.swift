//: Playground - noun: a place where people can play

import Foundation

// Snap, snapchat, story, chat...

// Snap, Snapchat
// Node(S)
// Node(n)
// Node(a)
// Node(p)
// Node(c) - Empty
// Node(h)
// Node(a)
// Node(t)

let words = ["Snap", "snapchat", "story", "chat"]

class Node<T: Hashable> {
    let value: T?
    var children = [T: Node]()
    var isTerminating = false
    init(_ value: T? = nil) {
        self.value = value
    }
    subscript(char: T) -> Node<T>? {
        get { return children[char] }
        set { children[char] = newValue }
    }
}

let node: Node<Character> = {
    let node = Node<Character>(nil)
    for word in words {
        var current = node
        for char in word.lowercased().characters {
            if current[char] == nil {
                current[char] = Node(char)
            }
            current = current[char]!
        }
        if !current.isTerminating {
            current.isTerminating = true
        }
    }
    return node
}()

func search(_ word: String) -> [String] {
    var current = node
    for char in word.lowercased().characters {
        if let new = current[char] {
            current = new
            print(new.value)
        } else {
            return []
        }
    }
    var words = [String]()
    if current.isTerminating {
        words.append(word.lowercased())
    }
    for node in current.children.values {
        words += wordsInSubtree(node: node, prefix: word.lowercased())
    }
    return words
}

func wordsInSubtree(node: Node<Character>, prefix: String) -> [String] {
    var words = [String]()
    var string = prefix
    if let value = node.value {
        string.append(String(value))
    }
    if node.isTerminating {
        words.append(string)
    }
    for node in node.children.values {
        words += wordsInSubtree(node: node, prefix: string)
    }
    return words
}

let results = search("sna")
print(results)
