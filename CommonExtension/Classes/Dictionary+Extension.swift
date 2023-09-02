//
//  Dictionary+Extension.swift
//  
//
//  Created by Jack on 2022/9/30.
//

import Foundation

public extension Dictionary {
    func toJsonString() -> String {
        guard JSONSerialization.isValidJSONObject(self) else { return "" }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return "" }
        guard let JSONString = String(data: data, encoding: .utf8) else { return "" }
        return JSONString
    }
}
