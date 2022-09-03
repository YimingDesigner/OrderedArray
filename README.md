# OrderedArray

Automatically manage the item order of array.

___

## Overview

`OrderedArray` is designed like what array used to be, while added the ability to manage the order. `OrderedArray` uses `Combine` to handle the order, and there are two conditions to update the order:

1. When adding a new item;
2. When changing an existing item's content.

All of those works are automatically done.

## Initializing

```swift
@Published private(set) var array: [T]

// Initialize. T: Comparable & ObservableObject
let orderedArrayInstance = OrderedArray<T>()
```

## Getting Data

```swift
// Get `array`
orderedArrayInstance.array
```

The `array` is wrapped with `@Published` which means you can use it in a view letting `Combine` handle UI update.

But sometimes you may want to use `Combine` explicitly in a ViewModel by using fellowing approach.

```swift
private var orderedArrayInstanceChangedSubscription: AnyCancellable?

init() {
  self.orderedArrayInstanceChangedSubscription = orderArrayInstance.objectWillChange.sink{ self.objectWillChange.send() }
}
```

## Operating Data

```swift
// Find if `item` is in array
func contains(_ item: T) -> Bool

// Find if condition is satisfied by any item in array
func contains(condition: (_ nthItem: T) -> Bool) -> Bool

// Find and return item by given condition
func find(condition: (_ nthItem: T) -> Bool) -> T?

// Add a new item
@MainActor func add(_ item: T)

// Delete a item
public func delete(_ item: T)
```
