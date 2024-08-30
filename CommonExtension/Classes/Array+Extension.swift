//
//  Array+Extension.swift
//
//
//  Created by Jack on 2022/11/3.
//

import Foundation

public extension Array{
    init(count: Int, element: (Int) throws -> Element) rethrows {
        try self.init(unsafeUninitializedCapacity: count) { buffer, initializedCount in
            for index in 0..<count {
                try buffer.baseAddress?.advanced(by: index).initialize(to: element(index))
            }
            initializedCount = count
        }
    }
}

public extension Array {
    mutating func safeSwap(from index: Index, to otherIndex: Index) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
    
    @discardableResult
    func sorted<T: Hashable>(like otherArray: [T], keyPath: KeyPath<Element, T>) -> [Element] {
        let dict = otherArray.enumerated().reduce(into: [:]) { $0[$1.element] = $1.offset }
        return sorted {
            guard let thisIndex = dict[$0[keyPath: keyPath]] else { return false }
            guard let otherIndex = dict[$1[keyPath: keyPath]] else { return true }
            return thisIndex < otherIndex
        }
    }
    
    @discardableResult
    func toJsonString() -> String {
        guard JSONSerialization.isValidJSONObject(self) else { return "" }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        guard let JSONString = String(data: data, encoding: .utf8) else { return "" }
        return JSONString
    }
    
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    @discardableResult
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
    @discardableResult
    func randomElement() -> Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(count)))]
    }
    
}

public extension Array where Element: Equatable {
    @discardableResult
    mutating func removeAll(_ item: Element) -> [Element] {
        removeAll(where: { $0 == item })
        return self
    }
    
    @discardableResult
    mutating func removeAll(_ items: [Element]) -> [Element] {
        guard !items.isEmpty else { return self }
        removeAll(where: { items.contains($0) })
        return self
    }
    
    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
    
    @discardableResult
    func toDictionary<Key: Hashable, Value>(_ transform: (Element) -> (Key, Value)?) -> [Key: Value] {
        var dict: [Key: Value] = [:]
        for element in self {
            if let (key, value) = transform(element) {
                dict[key] = value
            }
        }
        return dict
    }
}

extension Array where Element: Encodable {
    @discardableResult
    func toJsonString() -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
