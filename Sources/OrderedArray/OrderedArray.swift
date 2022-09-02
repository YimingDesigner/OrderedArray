import Foundation
import Combine

@available(macOS 10.15, *)
public class OrderedArray<T: Comparable & ObservableObject>: ObservableObject {
    
    private var itemChangedSubscription: [AnyCancellable]
    
    @Published public private(set) var array: [T]
    
    public init() {
        self.itemChangedSubscription = []
        self.array = []
    }
    
    public func contains(_ item: T) -> Bool {
        return array.contains(item)
    }
    
    public func contains(_ item: T, condition: (_ nthItem: T, _ item: T) -> Bool) -> Bool {
        for nthItem in array {
            if condition(nthItem, item) {
                return true
            }
        }
       return false
    }
    
    public func contains(condition: (_ nthItem: T) -> Bool) -> Bool {
        for nthItem in array {
            if condition(nthItem) {
                return true
            }
        }
       return false
    }
    
    public func find(_ item: T, condition: (_ nthItem: T, _ item: T) -> Bool) -> T? {
        for nthItem in array {
            if condition(nthItem, item) {
                return nthItem
            }
        }
        return nil
    }
    
    public func find(condition: (_ nthItem: T) -> Bool) -> T? {
        for nthItem in array {
            if condition(nthItem) {
                return nthItem
            }
        }
        return nil
    }
    
    @MainActor
    public func add(_ item: T) {
        array.insertOrderly(item)
        itemChangedSubscription.append(item.objectWillChange
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { _ in
            self.reorder(item: item)
        })
    }
    
    public func delete(_ item: T) {
        for (index, nthItem) in array.enumerated() {
            if nthItem == item {
                array.remove(at: index)
                return
            }
        }
    }
    
    @MainActor
    private func reorder(item: T) {
        self.delete(item)
        self.array.insertOrderly(item)
    }
    
}
