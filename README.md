# OptimizedCollections
Optimized Collections in Swift

Here, I will be adding few optimized collections that I had to create at some point it my career. Hopefully, it will be useful for others who are looking for custom and optimized collections.

## Binary Search Tree

Custom Iterator:

* Gives the ability to iterate through a sequence of binary search tree objects.
* Confirms to Sequence and IteratorProtocol
* Enables to use for-in and other functional methods that we can normally use with any sequence

```
// create a binary tree
var tree: BinarySearchTree<Int> = BinarySearchTree.empty
[5,2,4,8,3,1,9,11,20,10].forEach { tree.insert(newValue: $0) }

// and iterate through it
for element in tree {
  // Do something with the element here
}

// other functional methods that you can use
tree.reduce(0, +) 
tree.map { // Do something here }

```
