//: Playground - noun: a place where people can play

import UIKit

enum BinarySearchTree <T: Comparable> {
    case empty
    indirect case node (left: BinarySearchTree<T>, value: T, right: BinarySearchTree<T>)
    
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    
    private func newTreeWithInsertedValue(newValue: T) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(left: .empty, value: newValue, right: .empty)
        case let .node(left, value, right):
            if newValue < value {
                return .node(left: left.newTreeWithInsertedValue(newValue: newValue), value: value, right: right)
            } else {
                return .node(left: left, value: value, right: right.newTreeWithInsertedValue(newValue: newValue))
            }
        }
    }
    
    mutating func insert(newValue: T) {
        self = newTreeWithInsertedValue(newValue: newValue)
    }
    
    func contains(searchValue: T) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(left, value, right):
            if searchValue == value { return true }
            if searchValue < value {
                return left.contains(searchValue: searchValue)
            } else {
                return right.contains(searchValue: searchValue)
            }
        }
    }
    
    func inorderTraversal(process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.inorderTraversal(process: process)
            process(value)
            right.inorderTraversal(process: process)
        }
    }
    
    func preorderTraversal(process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            process(value)
            left.preorderTraversal(process: process)
            right.preorderTraversal(process: process)
        }
    }
    
    func postorderTraversal(process: (T) -> ()) {
        switch self {
        case .empty:
            return
        case let .node(left, value, right):
            left.postorderTraversal(process: process)
            right.postorderTraversal(process: process)
            process(value)
        }
    }
}

extension BinarySearchTree: Sequence {
    func makeIterator() -> BinarySearchTreeIterator<T> {
        return BinarySearchTreeIterator(self)
    }
    
    struct BinarySearchTreeIterator<T: Comparable>: IteratorProtocol {
        var tree: BinarySearchTree<T>
        var stack = [(T, BinarySearchTree<T>)]()
        
        init(_ tree: BinarySearchTree<T>) {
            self.tree = tree
        }
        
        mutating func next() -> T? {
            while case let .node(left, value, right) = tree {
                stack.append((value, right))
                tree = left
            }
            
            guard let (element, tree) = stack.popLast() else { return nil }
            self.tree = tree
            return element
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
        case .empty:
            return ""
        }
    }
}

extension BinarySearchTree {
    func invert() -> BinarySearchTree {
        if case let .node(left, value, right) = self {
            return .node(left: right.invert(), value: value, right: left.invert())
        } else {
            return .empty
        }
    }
}

var anotherTree: BinarySearchTree<Int> = BinarySearchTree.empty
[5,2,4,8,3,1,9,11,20,10].forEach { anotherTree.insert(newValue: $0) }

// Print Tree
//print(anotherTree.description)

// Invert
print(anotherTree.invert())

// Traversal
anotherTree.inorderTraversal { print($0) }
//anotherTree.preorderTraversal { print($0) }
//anotherTree.postorderTraversal(process: {
//    print($0)
//})

// Iterator
//for element in anotherTree {
//    print(element)
//}

anotherTree.reduce(0, +)

