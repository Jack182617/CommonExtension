//
//  Array+Extension.swift
//
//
//  Created by Jack on 2022/11/3.
//

import Foundation

public extension Array {
    func toJsonString() -> String {
        guard JSONSerialization.isValidJSONObject(self) else { return "" }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        guard let JSONString = String(data: data, encoding: .utf8) else { return "" }
        return JSONString
    }
    
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
public extension Array {
    func randomElement() -> Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(count)))]
    }
}
public extension Array {
    func mapRecursive<T>(_ transform: (Element) -> T) -> [T] {
        return map { transform($0) }
    }
}
public extension Array {
    mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {
        self = try filter { try !shouldBeRemoved($0) }
    }
}
public extension Array where Element: Hashable {
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
public extension Array where Element: Encodable {
    func toJsonString() -> String? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
