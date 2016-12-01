//: Playground - noun: a place where people can play

// If Teresa's daughter is my daughter's mother, what am i to Teresa?

class TreeNode<T> {
    var value: T
    
    weak var parent: TreeNode?
    var children = [TreeNode<T>]()
    
    init(value: T) {
        self.value = value
    }
    
    func addChild(_ node: TreeNode<T>) {
        children.append(node)
        node.parent = self
    }
}

extension TreeNode: CustomStringConvertible {
    var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return s
    }
}

let 👩🏼 = TreeNode(value: "Teresa")
let 👸🏼 = TreeNode(value: "Teresa's daughter")

👩🏼.addChild(👸🏼)
let 👽 = 👸🏼.parent
