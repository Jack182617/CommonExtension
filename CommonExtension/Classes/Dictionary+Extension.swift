//
//  Dictionary+Extension.swift
//
//
//  Created by Jack on 2022/9/30.
//

import Foundation

public extension Dictionary {
    var allKeys: [Key] {
        return Array(self.keys)
    }
    
    var allValues: [Value] {
        return Array(self.values)
    }
    
    func toJsonString() -> String? {
        guard JSONSerialization.isValidJSONObject(self) else {
            print("Invalid JSON object")
            return nil
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            return String(data: data, encoding: .utf8)
        } catch {
            print("Failed to convert dictionary to JSON string: \(error.localizedDescription)")
            return nil
        }
    }
    
    func mapKeysAndValues<K, V>(_ transform: (Key, Value) -> (K, V)) -> [K: V] {
        var dict = [K: V]()
        for (key, value) in self {
            let (newKey, newValue) = transform(key, value)
            dict[newKey] = newValue
        }
        return dict
    }
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { self[$0] = $1 }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}
